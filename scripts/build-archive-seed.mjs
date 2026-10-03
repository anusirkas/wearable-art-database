// Turns data/met-candidates.json into db/seed-archive.sql and downloads each image
// into public/images/archive as WebP (max 1400 px). Re-runnable: skips images already saved.
import { existsSync } from "node:fs";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import sharp from "sharp";

// Not wearable (dish rings), the second half of a pair, or Tostrup pieces that share one
// photograph of the whole set (only the necklace is kept).
const EXCLUDE = new Set([642825, 189235, 189052, 189053, 189051, 189049, 189050]);
const candidates = JSON.parse(await readFile("data/met-candidates.json", "utf8")).filter((o) => !EXCLUDE.has(o.objectID));
const IMAGE_DIR = "public/images/archive";
await mkdir(IMAGE_DIR, { recursive: true });

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const q = (v) => (v === null || v === undefined || v === "" ? "NULL" : `'${String(v).replace(/'/g, "''")}'`);
const slugify = (s) =>
  s.normalize("NFKD").replace(/[̀-ͯ]/g, "").toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");

function typeFor(o) {
  const name = `${o.objectName} ${o.title}`.toLowerCase();
  const rules = [
    // garment words first: "evening coat" is a coat, "headdress" is not a dress
    [/headdress|crown|tiara|diadem|headpiece|head ornament/, "Headdress"],
    [/coat|cape|mantle|cloak|dolman/, "Coat"],
    [/jacket|spencer|bodice/, "Jacket"],
    [/ensemble|suit/, "Ensemble"],
    [/robe|kimono|kosode|uchikake/, "Robe"],
    [/evening|ball gown|court/, "Evening dress"],
    [/wedding|dress|gown/, "Dress"],
    [/necklace|pendant|collar|chain|parure/, "Necklace"],
    [/brooch|\bpin\b/, "Brooch"],
    [/bracelet|bangle|cuff/, "Bracelet"],
    [/earring/, "Earrings"],
    [/\bring\b/, "Ring"],
    [/\bhat\b|bonnet|\bcap\b|turban/, "Hat"],
    [/bag|purse|reticule|pouch/, "Bag"],
    [/\bfan\b/, "Fan"],
    [/shoe|slipper|boot|pump|sandal/, "Shoes"],
  ];
  return rules.find(([re]) => re.test(name))?.[1] ?? "Accessory";
}

const MATERIALS = [
  [/silk|satin|taffeta|chiffon|organza|crepe/, "Silk"],
  [/cotton/, "Cotton"],
  [/linen|flax/, "Linen"],
  [/wool|cashmere/, "Wool"],
  [/velvet/, "Velvet"],
  [/feather|plume/, "Feathers"],
  [/fur\b|mink|sable|ermine/, "Fur"],
  [/leather|suede|kid/, "Leather"],
  [/straw|raffia|bast/, "Straw"],
  [/metal thread|metallic|lamé|lame\b/, "Metallic thread"],
  [/\bgold\b/, "Gold"],
  [/\bsilver\b/, "Silver"],
  [/enamel/, "Enamel"],
  [/(?<!mother-of-)pearl/, "Pearls"],
  [/diamond/, "Diamonds"],
  [/garnet|emerald|ruby|sapphire|amethyst|turquoise|opal|topaz|coral|agate|jade|carnelian|chrysoprase|jacinth|onyx|hardstone|\bjet\b/, "Gemstones"],
  [/glass|bead|sequin|paste|rhinestone|crystal/, "Glass beads"],
  [/lace/, "Lace"],
  [/shell|mother-of-pearl|tortoise/, "Shell"],
];

function materialsFor(o) {
  const medium = (o.medium ?? "").toLowerCase();
  return [...new Set(MATERIALS.filter(([re]) => re.test(medium)).map(([, name]) => name))];
}

function techniquesFor(o, type) {
  const text = `${o.medium} ${o.title} ${o.tags.join(" ")}`.toLowerCase();
  const out = [];
  if (/embroider/.test(text)) out.push("Embroidery");
  if (/bead|sequin/.test(text)) out.push("Beadwork");
  if (/pleat/.test(text)) out.push("Pleating");
  if (/brocade|damask|woven|tapestry/.test(text)) out.push("Weaving");
  if (/enamel/.test(text)) out.push("Enamelling");
  if (/diamond|garnet|emerald|ruby|sapphire|amethyst|turquoise|opal|topaz|pearl|stone/.test(text) &&
      ["Necklace", "Brooch", "Bracelet", "Earrings", "Ring", "Headdress"].includes(type)) out.push("Stone setting");
  if (/\bgold\b|\bsilver\b/.test(text) && ["Necklace", "Brooch", "Bracelet", "Earrings", "Ring"].includes(type))
    out.push("Goldsmithing");
  if (["Hat", "Headdress"].includes(type) && !/gold|silver/.test(text)) out.push("Millinery");
  if (["Dress", "Evening dress", "Ensemble", "Coat", "Jacket", "Robe"].includes(type)) out.push("Sewing");
  return [...new Set(out)];
}

const COUNTRY = {
  American: "US", French: "FR", British: "GB", English: "GB", Italian: "IT", German: "DE", Austrian: "AT",
  Spanish: "ES", Japanese: "JP", Chinese: "CN", Dutch: "NL", Belgian: "BE", Russian: "RU", Swiss: "CH",
  Danish: "DK", Swedish: "SE", Irish: "IE", Scottish: "GB", Indian: "IN", Mexican: "MX",
};

function countryFor(o) {
  const word = (o.nationality || o.makerBio || "").split(/[ ,]/)[0];
  return COUNTRY[word] ?? null;
}

function describe(o, type) {
  const medium = o.medium ? o.medium.charAt(0).toLowerCase() + o.medium.slice(1) : null;
  const who = [o.maker, o.makerBio && `(${o.makerBio})`].filter(Boolean).join(" ");
  const parts = [`${o.objectName || type}${medium ? ` in ${medium}` : ""}`, who && `by ${who}`, o.date && `dated ${o.date}`];
  return `${parts.filter(Boolean).join(", ")}. From the collection of The Metropolitan Museum of Art (${o.department}).`;
}

async function saveImage(o) {
  const file = `${IMAGE_DIR}/met-${o.objectID}.webp`;
  if (!existsSync(file)) {
    await sleep(1000);
    const res = await fetch(o.image, { headers: { "User-Agent": "wearable-art-archive (portfolio project)" } });
    if (!res.ok) throw new Error(`${res.status} for ${o.image}`);
    await sharp(Buffer.from(await res.arrayBuffer()))
      .resize({ width: 1400, height: 1750, fit: "inside", withoutEnlargement: true })
      .webp({ quality: 80 })
      .toFile(file);
  }
  const meta = await sharp(file).metadata();
  return { url: `/images/archive/met-${o.objectID}.webp`, width: meta.width, height: meta.height };
}

const sql = ["-- Archive pieces from The Met Open Access (CC0). Generated by scripts/build-archive-seed.mjs.", ""];
const makers = new Map();

for (const o of candidates) {
  const slug = slugify(o.maker);
  if (!makers.has(slug)) makers.set(slug, o);
}
sql.push("INSERT INTO artist (slug, name, status, life_dates, country_code, bio) VALUES");
sql.push(
  [...makers.entries()]
    .map(([slug, o]) => {
      const bio = `${o.makerRole || "Maker"} represented in the costume and decorative arts collections of The Metropolitan Museum of Art.`;
      return `(${q(slug)}, ${q(o.maker)}, 'archive', ${q(o.makerBio)}, ${q(countryFor(o))}, ${q(bio)})`;
    })
    .join(",\n") + "\nON CONFLICT (slug) DO NOTHING;",
);
sql.push("");

let done = 0;
for (const o of candidates) {
  let image;
  try {
    image = await saveImage(o);
  } catch (error) {
    console.log(`skip ${o.objectID}: ${error.message}`);
    continue;
  }
  const type = typeFor(o);
  const slug = `${slugify(o.title)}-${slugify(o.maker)}-${o.objectID}`;
  sql.push(`-- ${o.title} (${o.maker}), Met ${o.objectID}`);
  sql.push(
    `INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, description, culture, source_name, source_url, credit_line)
SELECT ${q(slug)}, ar.id, t.id, ${q(o.title)}, ${q(o.date)}, ${o.beginDate || "NULL"}, ${q(describe(o, type))}, ${q(o.culture)},
  'The Metropolitan Museum of Art', ${q(o.url)}, ${q(o.creditLine)}
FROM artist ar, artwork_type t WHERE ar.slug = ${q(slugify(o.maker))} AND t.name = ${q(type)};`,
  );
  for (const m of materialsFor(o)) {
    sql.push(`INSERT INTO artwork_material (artwork_id, material_id) SELECT a.id, m.id FROM artwork a, material m WHERE a.slug = ${q(slug)} AND m.name = ${q(m)};`);
  }
  techniquesFor(o, type).forEach((te, i) => {
    sql.push(`INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, te.id, ${i + 1} FROM artwork a, technique te WHERE a.slug = ${q(slug)} AND te.name = ${q(te)};`);
  });
  sql.push(
    `INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height)
SELECT id, ${q(image.url)}, 'photo', ${q(`${o.title}, ${o.maker}`)}, 'The Metropolitan Museum of Art', 'CC0', ${image.width}, ${image.height}
FROM artwork WHERE slug = ${q(slug)};`,
  );
  sql.push("");
  done++;
  if (done % 10 === 0) console.log(`${done}/${candidates.length}`);
}

sql.push("REFRESH MATERIALIZED VIEW artwork_search;");
await writeFile("db/seed-archive.sql", sql.join("\n") + "\n");
console.log(`wrote db/seed-archive.sql with ${done} pieces by ${makers.size} makers`);
