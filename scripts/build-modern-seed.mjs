// Builds db/seed-contemporary.sql (real designers, Wikimedia Commons photos) and
// db/seed-studios.sql (fictional demo studios, Unsplash photos), downloading images
// into public/images/contemporary and public/images/studios. Re-runnable.
import { existsSync } from "node:fs";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import sharp from "sharp";

const UA = { "User-Agent": "wearable-art-archive/1.0 (portfolio project; github.com/anusirkas)" };
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const q = (v) => (v === null || v === undefined || v === "" ? "NULL" : `'${String(v).replace(/'/g, "''")}'`);
const slugify = (s) =>
  s.normalize("NFKD").replace(/[̀-ͯ]/g, "").toLowerCase().replace(/&/g, "and").replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");

// Materials and techniques that only the modern layers use. Unknown sustainability stays NULL.
const NEW_MATERIALS = {
  Organza: ["fabric", null], Tulle: ["fabric", null], Mylar: ["other", false], Polyamide: ["other", false],
  Acrylic: ["other", false], Horsehair: ["fibre", null], Polyester: ["fabric", false],
  "Fibreglass-reinforced plastic": ["other", false], Plastic: ["other", false], Metal: ["metal", null],
  "Plastic sheeting": ["other", false], Calico: ["fabric", null], Wood: ["other", true], LEDs: ["other", false],
  Crystals: ["bead", false], Rayon: ["fabric", null], Aluminium: ["metal", null], Nylon: ["fabric", false],
};
const NEW_TECHNIQUES = {
  "Heat bonding": "Fusing synthetic layers with heat instead of stitching.",
  "Laser cutting": "Cutting fabric, leather or film with a laser for precise, sealed edges.",
  "3D printing": "Building forms layer by layer from a digital model.",
  Upcycling: "Remaking discarded or surplus material into something of higher value.",
  "Jacquard weaving": "Weaving complex patterns with each warp thread lifted individually.",
  Moulding: "Shaping a rigid material over or inside a form.",
  "Textile printing": "Printing pattern or image onto cloth.",
  Woodworking: "Shaping wood by hand and machine.",
  Electronics: "Building light, sound or motion into a garment.",
  Smocking: "Gathering fabric into decorative, elastic folds with stitching.",
  "Assembly without sewing": "Joining many small parts with rings, rivets or interlocking cuts instead of seams.",
  "Pattern cutting": "Drafting the flat pattern pieces a garment is cut from.",
  "Hand dyeing": "Colouring yarn or cloth by hand in small batches.",
  "Cable knitting": "Crossing stitches to form raised, rope-like cables.",
  "Hand knotting": "Knotting between each bead or pearl so they never rub.",
  Coating: "Covering cloth in a flexible finish such as metallic or wax.",
  Wirework: "Bending and joining wire into structure.",
  Gilding: "Applying gold leaf to a surface.",
};

async function download(url, file, attempts = 4) {
  if (existsSync(file)) return;
  for (let a = 0; a < attempts; a++) {
    await sleep(1500 * (a + 1));
    const res = await fetch(url, { headers: UA, redirect: "follow" });
    if (res.ok) {
      await sharp(Buffer.from(await res.arrayBuffer()))
        .rotate()
        .resize({ width: 1400, height: 1750, fit: "inside", withoutEnlargement: true })
        .webp({ quality: 80 })
        .toFile(file);
      return;
    }
    console.log(`  ${res.status} for ${url}, retrying`);
    if (res.status === 429) await sleep(30_000 * (a + 1));
  }
  throw new Error(`could not download ${url}`);
}

async function size(file) {
  const m = await sharp(file).metadata();
  return { width: m.width, height: m.height };
}

function referenceSql() {
  const lines = [];
  for (const [name, [category, sustainable]] of Object.entries(NEW_MATERIALS)) {
    lines.push(`INSERT INTO material (name, category, is_sustainable) VALUES (${q(name)}, ${q(category)}, ${sustainable === null ? "NULL" : sustainable}) ON CONFLICT (name) DO NOTHING;`);
  }
  for (const [name, description] of Object.entries(NEW_TECHNIQUES)) {
    lines.push(`INSERT INTO technique (name, description) VALUES (${q(name)}, ${q(description)}) ON CONFLICT (name) DO NOTHING;`);
  }
  return lines;
}

function pieceSql({ slug, artistSlug, type, title, dateLabel, year, size: sizeLabel, description, inspiration, sourceName, sourceUrl, credit }) {
  return `INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT ${q(slug)}, ar.id, t.id, ${q(title)}, ${q(dateLabel)}, ${year ?? "NULL"}, ${q(sizeLabel)}, ${q(description)}, ${q(inspiration)}, ${q(sourceName)}, ${q(sourceUrl)}, ${q(credit)}
FROM artist ar, artwork_type t WHERE ar.slug = ${q(artistSlug)} AND t.name = ${q(type)};`;
}

const materialSql = (slug, name, quantity) =>
  `INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, ${q(quantity)} FROM artwork a, material m WHERE a.slug = ${q(slug)} AND m.name = ${q(name)};`;
const techniqueSql = (slug, name, order) =>
  `INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, ${order} FROM artwork a, technique t WHERE a.slug = ${q(slug)} AND t.name = ${q(name)};`;
const mediaSql = (slug, url, caption, credit, license, dims, order) =>
  `INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, ${q(url)}, ${order === 0 ? "'photo'" : "'detail'"}, ${q(caption)}, ${q(credit)}, ${q(license)}, ${dims.width}, ${dims.height}, ${order} FROM artwork WHERE slug = ${q(slug)};`;

// ---------- Contemporary designers (Wikimedia Commons) ----------
const contemporary = JSON.parse(await readFile("data/contemporary.json", "utf8"));
const commons = JSON.parse(await readFile("data/commons-candidates.json", "utf8"));
await mkdir("public/images/contemporary", { recursive: true });

const c = ["-- Contemporary designers, photographed in museums and exhibitions. Wikimedia Commons, openly licensed.", ""];
c.push(...referenceSql(), "");
c.push("INSERT INTO artist (slug, name, status, life_dates, country_code, bio) VALUES");
c.push(
  Object.entries(contemporary.designers)
    .map(([name, d]) => `(${q(d.slug)}, ${q(name)}, 'contemporary', ${q(d.life_dates)}, ${q(d.country)}, ${q(d.bio)})`)
    .join(",\n") + ";",
  "",
);

for (const p of contemporary.pieces) {
  const photo = commons[p.i];
  const designer = contemporary.designers[p.designer];
  const slug = `${slugify(p.title)}-${designer.slug}`;
  const file = `public/images/contemporary/${slug}.webp`;
  try {
    await download(photo.thumb.split("?")[0], file);
  } catch (error) {
    console.log(`skip ${slug}: ${error.message}`);
    continue;
  }
  const credit = `Photo: ${photo.artist || "Wikimedia Commons"}, ${photo.license}, via Wikimedia Commons`;
  c.push(`-- ${p.title} (${p.designer})`);
  c.push(pieceSql({ slug, artistSlug: designer.slug, type: p.type, title: p.title, dateLabel: p.date, year: p.year, description: p.description, sourceName: "Wikimedia Commons", sourceUrl: photo.page, credit }));
  p.materials.forEach((m) => c.push(materialSql(slug, m, null)));
  p.techniques.forEach((t, i) => c.push(techniqueSql(slug, t, i + 1)));
  c.push(mediaSql(slug, `/images/contemporary/${slug}.webp`, `${p.title}, ${p.designer}`, credit, photo.license, await size(file), 0), "");
  console.log(`contemporary: ${slug}`);
}
c.push("REFRESH MATERIALIZED VIEW artwork_search;");
await writeFile("db/seed-contemporary.sql", c.join("\n") + "\n");

// ---------- Demo studios (Unsplash) ----------
const { studios } = JSON.parse(await readFile("data/studios.json", "utf8"));
await mkdir("public/images/studios", { recursive: true });

const s = ["-- Demo studios: fictional names, illustrative Unsplash photos (photographer credited).", ""];
s.push(...referenceSql(), "");
s.push("INSERT INTO artist (slug, name, status, bio, creative_cv, country_code, membership_status, membership_from, is_demo) VALUES");
s.push(
  studios
    .map((st) => `(${q(st.slug)}, ${q(st.name)}, ${q(st.status)}, ${q(st.bio)}, ${q(st.cv)}, ${q(st.country)}, ${st.status === "guest" ? "NULL" : "'active'"}, ${st.status === "guest" ? "NULL" : "'2023-09-01'"}, true)`)
    .join(",\n") + ";",
  "",
);

for (const st of studios) {
  for (const p of st.pieces) {
    s.push(`-- ${p.title} (${st.name})`);
    s.push(pieceSql({ slug: p.slug, artistSlug: st.slug, type: p.type, title: p.title, dateLabel: String(p.year), year: p.year, size: p.size, description: p.description, inspiration: p.inspiration, sourceName: null, sourceUrl: null, credit: null }));
    p.materials.forEach(([m, quantity]) => s.push(materialSql(p.slug, m, quantity)));
    p.techniques.forEach((t, i) => s.push(techniqueSql(p.slug, t, i + 1)));
    p.stages.forEach(([name, from, to, hours]) =>
      s.push(`INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, ${q(name)}, ${q(from)}, ${q(to)}, ${hours} FROM artwork WHERE slug = ${q(p.slug)};`),
    );
    for (const [order, [id, photographer]] of p.photos.entries()) {
      const file = `public/images/studios/${p.slug}-${order + 1}.webp`;
      await download(`https://unsplash.com/photos/${id}/download?w=1600`, file);
      s.push(mediaSql(p.slug, `/images/studios/${p.slug}-${order + 1}.webp`, `Illustrative photo for ${p.title}`, `Photo: ${photographer} on Unsplash`, "Unsplash License", await size(file), order));
    }
    s.push("");
    console.log(`studio: ${p.slug}`);
  }
}
await writeFile("db/seed-studios.sql", s.join("\n") + "\n");
console.log("wrote db/seed-contemporary.sql and db/seed-studios.sql");
