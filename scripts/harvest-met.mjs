// Collects public-domain (CC0) wearable pieces from The Met Open Access API.
// Polite on purpose (the API blocks bursts): one request a second, resumable.
// Writes data/met-candidates.json; images are downloaded by scripts/fetch-images.mjs.
import { existsSync } from "node:fs";
import { mkdir, readFile, writeFile } from "node:fs/promises";

const API = "https://collectionapi.metmuseum.org/public/collection";
const OUT = "data/met-candidates.json";
const HEADERS = { "User-Agent": "wearable-art-archive (portfolio project; github.com/anusirkas)" };

// [department, query, how many named-maker pieces to keep]. Older pieces are far more often
// public domain, so the second round leans on 19th-century makers and terms.
const QUERIES = [
  // round 1
  [8, "evening dress", 2],
  [8, "ensemble", 2],
  [8, "coat", 2],
  [8, "hat", 2],
  [8, "shoes", 4],
  [8, "bag", 1],
  [12, "necklace", 3],
  [12, "brooch", 4],
  [1, "brooch", 3],
  [12, "bracelet", 3],
  [5, "headdress", 3],
  [6, "robe", 0],
  // round 2
  [8, "House of Worth", 6],
  [8, "Charles Frederick Worth", 3],
  [8, "Emile Pingat", 3],
  [8, "1880s dress", 3],
  [8, "bonnet", 2],
  [8, "fan", 2],
  [12, "earrings", 3],
  [12, "ring", 2],
  [12, "tiara", 2],
];

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function json(url) {
  for (let attempt = 0; attempt < 4; attempt++) {
    await sleep(1100);
    const res = await fetch(url, { headers: HEADERS });
    if (res.ok) return res.json();
    if (res.status === 404) return null;
    console.log(`  ${res.status}, backing off`);
    await sleep(60_000 * (attempt + 1));
  }
  throw new Error(`Gave up on ${url}`);
}

const out = existsSync(OUT) ? JSON.parse(await readFile(OUT, "utf8")) : [];
const checked = new Set(out.map((o) => o.objectID));
await mkdir("data", { recursive: true });

for (const [departmentId, q, keep] of QUERIES) {
  let kept = out.filter((o) => o.query === q && o.departmentId === departmentId).length;
  if (kept >= keep) continue;
  const search = await json(`${API}/v1.1/search?q=${encodeURIComponent(q)}&departmentId=${departmentId}&hasImages=true&limit=80`);
  for (const id of search?.objectIDs ?? []) {
    if (kept >= keep) break;
    if (checked.has(id)) continue;
    checked.add(id);
    const o = await json(`${API}/v1/objects/${id}`);
    if (!o?.isPublicDomain || !o.primaryImage || !o.artistDisplayName) continue;
    kept++;
    out.push({
      departmentId,
      query: q,
      objectID: o.objectID,
      title: o.title,
      objectName: o.objectName,
      maker: o.artistDisplayName,
      makerRole: o.artistRole,
      makerBio: o.artistDisplayBio,
      nationality: o.artistNationality,
      culture: o.culture,
      date: o.objectDate,
      beginDate: o.objectBeginDate,
      medium: o.medium,
      dimensions: o.dimensions,
      department: o.department,
      creditLine: o.creditLine,
      image: o.primaryImage,
      url: o.objectURL,
      tags: (o.tags ?? []).map((t) => t.term),
    });
    await writeFile(OUT, JSON.stringify(out, null, 2));
  }
  console.log(`${q} (dept ${departmentId}): ${kept}`);
}

console.log(`total ${out.length}`);
