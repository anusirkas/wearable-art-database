import { db } from "./db";

export type Category = "garment" | "jewellery" | "headwear" | "accessory" | "footwear";
export const CATEGORIES: { value: Category; label: string }[] = [
  { value: "garment", label: "Garments" },
  { value: "jewellery", label: "Jewellery" },
  { value: "headwear", label: "Headwear" },
  { value: "accessory", label: "Accessories" },
  { value: "footwear", label: "Footwear" },
];

export type ArtworkCard = {
  slug: string;
  title: string;
  date_label: string | null;
  artist: string;
  artist_slug: string;
  type: string;
  category: Category;
  image: string | null;
  width: number | null;
  height: number | null;
  sustainable: boolean;
};

export type SearchFilters = {
  q?: string;
  category?: string;
  type?: string;
  material?: string;
  technique?: string;
  sustainable?: boolean;
};

/**
 * Full-text search (title, maker, type, materials, techniques, descriptions) with a trigram
 * fallback so a typo like "embroidry" still finds embroidery. Filters narrow the result in the same query.
 */
export async function searchArtworks(f: SearchFilters): Promise<ArtworkCard[]> {
  const q = f.q?.trim() || null;
  const rows = await db()`
    WITH input AS (
      SELECT
        f_unaccent(lower(${q}::text)) AS text,
        websearch_to_tsquery('simple', f_unaccent(coalesce(${q}::text, ''))) AS simple_q,
        websearch_to_tsquery('english', f_unaccent(coalesce(${q}::text, ''))) AS english_q
    )
    SELECT
      a.slug, a.title, a.date_label, ar.name AS artist, ar.slug AS artist_slug,
      t.name AS type, t.category, m.file_url AS image, m.width, m.height,
      EXISTS (
        SELECT 1 FROM artwork_material am JOIN material mt ON mt.id = am.material_id
        WHERE am.artwork_id = a.id AND mt.is_sustainable
      ) AS sustainable
    FROM artwork a
    JOIN artist ar ON ar.id = a.artist_id
    JOIN artwork_type t ON t.id = a.artwork_type_id
    JOIN artwork_search s ON s.artwork_id = a.id
    LEFT JOIN LATERAL (
      SELECT file_url, width, height FROM media
      WHERE artwork_id = a.id ORDER BY sort_order LIMIT 1
    ) m ON true
    CROSS JOIN input
    WHERE (${q}::text IS NULL
           OR s.document @@ input.simple_q
           OR s.document @@ input.english_q
           OR word_similarity(input.text, s.words) > 0.5)
      AND (${f.category ?? null}::text IS NULL OR t.category = ${f.category ?? null})
      AND (${f.type ?? null}::text IS NULL OR t.name = ${f.type ?? null})
      AND (${f.material ?? null}::text IS NULL OR EXISTS (
            SELECT 1 FROM artwork_material am JOIN material mt ON mt.id = am.material_id
            WHERE am.artwork_id = a.id AND mt.name = ${f.material ?? null}))
      AND (${f.technique ?? null}::text IS NULL OR EXISTS (
            SELECT 1 FROM artwork_technique at JOIN technique te ON te.id = at.technique_id
            WHERE at.artwork_id = a.id AND te.name = ${f.technique ?? null}))
      AND (NOT ${f.sustainable ?? false} OR EXISTS (
            SELECT 1 FROM artwork_material am JOIN material mt ON mt.id = am.material_id
            WHERE am.artwork_id = a.id AND mt.is_sustainable))
    ORDER BY
      CASE WHEN ${q}::text IS NULL THEN 0
           ELSE ts_rank(s.document, input.simple_q || input.english_q)
                + word_similarity(input.text, s.words) END DESC,
      (m.file_url IS NULL), a.year DESC NULLS LAST, a.title
  `;
  return rows as ArtworkCard[];
}

export type Facet = { name: string; count: number };

/** Option lists for the filters, with how many artworks each would show. */
export async function getFacets() {
  const sql = db();
  const [types, materials, techniques] = await Promise.all([
    sql`SELECT t.name, t.category, count(a.id)::int AS count
        FROM artwork_type t JOIN artwork a ON a.artwork_type_id = t.id
        GROUP BY t.id ORDER BY count DESC, t.name`,
    sql`SELECT m.name, m.is_sustainable, count(*)::int AS count
        FROM material m JOIN artwork_material am ON am.material_id = m.id
        GROUP BY m.id ORDER BY count DESC, m.name`,
    sql`SELECT te.name, count(*)::int AS count
        FROM technique te JOIN artwork_technique at ON at.technique_id = te.id
        GROUP BY te.id ORDER BY count DESC, te.name`,
  ]);
  return {
    types: types as (Facet & { category: Category })[],
    materials: materials as (Facet & { is_sustainable: boolean | null })[],
    techniques: techniques as Facet[],
  };
}

export async function getStats() {
  const [row] = await db()`
    SELECT
      (SELECT count(*) FROM artwork)::int AS artworks,
      (SELECT count(*) FROM artist)::int AS artists,
      (SELECT count(*) FROM material)::int AS materials,
      (SELECT count(*) FROM artwork_type)::int + (SELECT count(*) FROM custom_artwork_type)::int AS types
  `;
  return row as { artworks: number; artists: number; materials: number; types: number };
}

export type ArtworkDetail = {
  id: number;
  slug: string;
  title: string;
  date_label: string | null;
  description: string | null;
  inspiration: string | null;
  size_label: string | null;
  length_cm: string | null;
  width_cm: string | null;
  height_cm: string | null;
  culture: string | null;
  source_name: string | null;
  source_url: string | null;
  credit_line: string | null;
  type: string;
  category: Category;
  custom_type: string | null;
  artist: { slug: string; name: string; life_dates: string | null; status: string; is_demo: boolean };
  media: { file_url: string; caption: string | null; credit: string | null; license: string | null; width: number | null; height: number | null }[];
  materials: { name: string; category: string; quantity: string | null; origin: string | null; is_sustainable: boolean | null; notes: string | null }[];
  techniques: { name: string; description: string | null; step_order: number | null }[];
  stages: { name: string; started_on: string | null; finished_on: string | null; hours: string | null; notes: string | null }[];
  events: { name: string; event_type: string; venue: string | null; city: string | null; starts_on: string | null; ends_on: string | null }[];
  reviews: { rating: string; comment: string | null; reviewed_on: string }[];
};

export async function getArtwork(slug: string): Promise<ArtworkDetail | null> {
  const [row] = await db()`
    SELECT
      a.id, a.slug, a.title, a.date_label, a.description, a.inspiration, a.size_label,
      a.length_cm, a.width_cm, a.height_cm, a.culture, a.source_name, a.source_url, a.credit_line,
      t.name AS type, t.category, ct.name AS custom_type,
      json_build_object('slug', ar.slug, 'name', ar.name, 'life_dates', ar.life_dates,
                        'status', ar.status, 'is_demo', ar.is_demo) AS artist,
      coalesce((SELECT json_agg(json_build_object('file_url', file_url, 'caption', caption, 'credit', credit,
                  'license', license, 'width', width, 'height', height) ORDER BY sort_order)
                FROM media WHERE artwork_id = a.id), '[]') AS media,
      coalesce((SELECT json_agg(json_build_object('name', m.name, 'category', m.category, 'quantity', am.quantity,
                  'origin', m.origin, 'is_sustainable', m.is_sustainable, 'notes', m.notes) ORDER BY m.name)
                FROM artwork_material am JOIN material m ON m.id = am.material_id
                WHERE am.artwork_id = a.id), '[]') AS materials,
      coalesce((SELECT json_agg(json_build_object('name', te.name, 'description', te.description,
                  'step_order', at.step_order) ORDER BY at.step_order NULLS LAST, te.name)
                FROM artwork_technique at JOIN technique te ON te.id = at.technique_id
                WHERE at.artwork_id = a.id), '[]') AS techniques,
      coalesce((SELECT json_agg(json_build_object('name', name, 'started_on', started_on, 'finished_on', finished_on,
                  'hours', hours, 'notes', notes) ORDER BY started_on NULLS LAST, id)
                FROM creation_stage WHERE artwork_id = a.id), '[]') AS stages,
      coalesce((SELECT json_agg(json_build_object('name', e.name, 'event_type', e.event_type, 'venue', e.venue,
                  'city', e.city, 'starts_on', e.starts_on, 'ends_on', e.ends_on) ORDER BY e.starts_on)
                FROM artwork_event ae JOIN event e ON e.id = ae.event_id
                WHERE ae.artwork_id = a.id), '[]') AS events,
      coalesce((SELECT json_agg(json_build_object('rating', rating, 'comment', comment,
                  'reviewed_on', reviewed_on) ORDER BY reviewed_on DESC)
                FROM review WHERE artwork_id = a.id), '[]') AS reviews
    FROM artwork a
    JOIN artist ar ON ar.id = a.artist_id
    JOIN artwork_type t ON t.id = a.artwork_type_id
    LEFT JOIN custom_artwork_type ct ON ct.id = a.custom_artwork_type_id
    WHERE a.slug = ${slug}
  `;
  return (row as ArtworkDetail) ?? null;
}

/** Other pieces by the same maker, then the same type, for "keep looking". */
export async function getRelated(slug: string, limit = 4): Promise<ArtworkCard[]> {
  const rows = await db()`
    WITH me AS (SELECT id, artist_id, artwork_type_id FROM artwork WHERE slug = ${slug})
    SELECT a.slug, a.title, a.date_label, ar.name AS artist, ar.slug AS artist_slug,
           t.name AS type, t.category, m.file_url AS image, m.width, m.height, false AS sustainable
    FROM artwork a
    CROSS JOIN me
    JOIN artist ar ON ar.id = a.artist_id
    JOIN artwork_type t ON t.id = a.artwork_type_id
    LEFT JOIN LATERAL (SELECT file_url, width, height FROM media WHERE artwork_id = a.id
                       ORDER BY sort_order LIMIT 1) m ON true
    WHERE a.id <> me.id AND (a.artist_id = me.artist_id OR a.artwork_type_id = me.artwork_type_id)
    ORDER BY (a.artist_id = me.artist_id) DESC, (m.file_url IS NULL), a.year DESC NULLS LAST
    LIMIT ${limit}
  `;
  return rows as ArtworkCard[];
}

export type ArtistSummary = {
  slug: string;
  name: string;
  status: string;
  life_dates: string | null;
  country_code: string | null;
  is_demo: boolean;
  works: number;
  cover: string | null;
};

export async function getArtists(): Promise<ArtistSummary[]> {
  const rows = await db()`
    SELECT ar.slug, ar.name, ar.status, ar.life_dates, ar.country_code, ar.is_demo,
           count(a.id)::int AS works,
           (SELECT m.file_url FROM artwork a2 JOIN media m ON m.artwork_id = a2.id
            WHERE a2.artist_id = ar.id ORDER BY a2.year DESC NULLS LAST, m.sort_order LIMIT 1) AS cover
    FROM artist ar LEFT JOIN artwork a ON a.artist_id = ar.id
    GROUP BY ar.id
    ORDER BY (ar.status = 'archive'), works DESC, ar.name
  `;
  return rows as ArtistSummary[];
}

export type ArtistDetail = {
  id: number;
  slug: string;
  name: string;
  status: string;
  bio: string | null;
  creative_cv: string | null;
  life_dates: string | null;
  country_code: string | null;
  membership_status: string | null;
  is_demo: boolean;
  endorsements: { type: string; endorsed_by: string | null; endorsed_on: string | null; description: string | null }[];
  reviews: { rating: string; comment: string | null; reviewed_on: string }[];
  trust: { score: string; calculated_on: string; basis: string | null } | null;
  total_hours: string | null;
};

export async function getArtist(slug: string): Promise<ArtistDetail | null> {
  const [row] = await db()`
    SELECT ar.id, ar.slug, ar.name, ar.status, ar.bio, ar.creative_cv, ar.life_dates, ar.country_code,
           ar.membership_status, ar.is_demo,
      coalesce((SELECT json_agg(json_build_object('type', et.name, 'endorsed_by', e.endorsed_by,
                  'endorsed_on', e.endorsed_on, 'description', e.description) ORDER BY e.endorsed_on DESC)
                FROM endorsement e JOIN endorsement_type et ON et.id = e.endorsement_type_id
                WHERE e.artist_id = ar.id), '[]') AS endorsements,
      coalesce((SELECT json_agg(json_build_object('rating', rating, 'comment', comment,
                  'reviewed_on', reviewed_on) ORDER BY reviewed_on DESC)
                FROM review WHERE artist_id = ar.id), '[]') AS reviews,
      (SELECT json_build_object('score', score, 'calculated_on', calculated_on, 'basis', basis)
       FROM trust_score WHERE artist_id = ar.id ORDER BY calculated_on DESC LIMIT 1) AS trust,
      (SELECT sum(cs.hours) FROM creation_stage cs JOIN artwork a ON a.id = cs.artwork_id
       WHERE a.artist_id = ar.id) AS total_hours
    FROM artist ar WHERE ar.slug = ${slug}
  `;
  return (row as ArtistDetail) ?? null;
}

export async function getArtistWorks(slug: string): Promise<ArtworkCard[]> {
  const rows = await db()`
    SELECT a.slug, a.title, a.date_label, ar.name AS artist, ar.slug AS artist_slug,
           t.name AS type, t.category, m.file_url AS image, m.width, m.height, false AS sustainable
    FROM artwork a
    JOIN artist ar ON ar.id = a.artist_id
    JOIN artwork_type t ON t.id = a.artwork_type_id
    LEFT JOIN LATERAL (SELECT file_url, width, height FROM media WHERE artwork_id = a.id
                       ORDER BY sort_order LIMIT 1) m ON true
    WHERE ar.slug = ${slug}
    ORDER BY a.year DESC NULLS LAST, a.title
  `;
  return rows as ArtworkCard[];
}

export type TypeRow = {
  id: number;
  name: string;
  category: Category;
  description: string | null;
  works: number;
  custom: { name: string; description: string | null; artist: string | null }[];
};

export async function getTypes(): Promise<TypeRow[]> {
  const rows = await db()`
    SELECT t.id, t.name, t.category, t.description,
      (SELECT count(*)::int FROM artwork a WHERE a.artwork_type_id = t.id) AS works,
      coalesce((SELECT json_agg(json_build_object('name', ct.name, 'description', ct.description,
                  'artist', ar.name) ORDER BY ct.name)
                FROM custom_artwork_type ct LEFT JOIN artist ar ON ar.id = ct.artist_id
                WHERE ct.artwork_type_id = t.id), '[]') AS custom
    FROM artwork_type t
    ORDER BY array_position(ARRAY['garment','jewellery','headwear','accessory','footwear'], t.category::text), t.name
  `;
  return rows as TypeRow[];
}

/** The course project's three example queries, run live. */
export async function getCourseQueries() {
  const sql = db();
  const [laborious, byArtist, luxury] = await Promise.all([
    sql`SELECT a.title, a.slug, sum(cs.hours)::float AS total_hours
        FROM creation_stage cs JOIN artwork a ON a.id = cs.artwork_id
        GROUP BY a.id HAVING sum(cs.hours) > 100 ORDER BY total_hours DESC`,
    sql`SELECT ar.name AS artist, a.title, t.name AS type, a.description
        FROM artist ar JOIN artwork a ON a.artist_id = ar.id JOIN artwork_type t ON t.id = a.artwork_type_id
        WHERE ar.name = 'Anu Sirkas'`,
    sql`SELECT a.slug, a.title, ar.name AS artist, m.name AS material, am.quantity
        FROM artwork a JOIN artwork_material am ON am.artwork_id = a.id JOIN material m ON m.id = am.material_id
        JOIN artist ar ON ar.id = a.artist_id
        WHERE m.name IN ('Silk', 'Cashmere', 'Merino wool') ORDER BY ar.is_demo DESC, a.title, m.name`,
  ]);
  return {
    laborious: laborious as { title: string; slug: string; total_hours: number }[],
    byArtist: byArtist as { artist: string; title: string; type: string; description: string }[],
    luxury: luxury as { slug: string; title: string; artist: string; material: string; quantity: string | null }[],
  };
}

/** Public suggestions only land in a review queue; nothing goes live without approval. */
export async function addSubmission(kind: "artwork_type" | "artist" | "commission", payload: unknown, ipHash: string) {
  const [recent] = await db()`
    SELECT count(*)::int AS n FROM submission
    WHERE ip_hash = ${ipHash} AND created_at > now() - interval '1 hour'
  `;
  if ((recent as { n: number }).n >= 5) return { ok: false as const, error: "Too many suggestions in an hour. Try again later." };
  await db()`INSERT INTO submission (kind, payload, ip_hash) VALUES (${kind}, ${JSON.stringify(payload)}::jsonb, ${ipHash})`;
  return { ok: true as const };
}
