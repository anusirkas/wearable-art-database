// Lists openly licensed photos of contemporary designers' work on Wikimedia Commons.
// Writes data/commons-candidates.json for hand-picking; nothing is downloaded here.
import { mkdir, writeFile } from "node:fs/promises";

const API = "https://commons.wikimedia.org/w/api.php";
const HEADERS = { "User-Agent": "wearable-art-archive/1.0 (portfolio project; github.com/anusirkas)" };
const OK_LICENSES = /^(CC0|Public domain|CC BY(-SA)? [0-9.]+)$/i;

const DESIGNERS = [
  "Iris van Herpen", "Guo Pei", "Marine Serre", "Alexander McQueen", "Viktor & Rolf", "Rei Kawakubo",
  "Comme des Garçons", "Yohji Yamamoto", "Issey Miyake", "Jean Paul Gaultier", "Thierry Mugler",
  "John Galliano", "Schiaparelli Roseberry", "Rick Owens", "Gareth Pugh", "Hussein Chalayan",
  "Noir Kei Ninomiya", "Simone Rocha", "Molly Goddard", "Christopher John Rogers", "Richard Quinn",
  "Craig Green", "Shaun Leane", "Zandra Rhodes", "Vivienne Westwood",
];

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const strip = (html = "") => html.replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim();

const out = [];
for (const designer of DESIGNERS) {
  const params = new URLSearchParams({
    action: "query",
    format: "json",
    generator: "search",
    gsrnamespace: "6",
    gsrlimit: "30",
    gsrsearch: `"${designer}" filetype:bitmap`,
    prop: "imageinfo",
    iiprop: "url|size|extmetadata",
    iiurlwidth: "1400",
    iiextmetadatafilter: "LicenseShortName|Artist|ImageDescription|DateTimeOriginal",
  });
  let body = null;
  for (let attempt = 0; attempt < 4 && !body; attempt++) {
    await sleep(3000 * (attempt + 1));
    const res = await fetch(`${API}?${params}`, { headers: HEADERS });
    const text = await res.text();
    if (text.startsWith("{")) body = JSON.parse(text);
    else console.log(`  rate limited, waiting`);
  }
  const pages = Object.values(body?.query?.pages ?? {});
  let kept = 0;
  for (const p of pages) {
    const ii = p.imageinfo?.[0];
    const m = ii?.extmetadata ?? {};
    const license = m.LicenseShortName?.value ?? "";
    if (!ii || !OK_LICENSES.test(license)) continue;
    if (ii.height < 1400 || ii.height < ii.width * 1.05) continue; // portrait, large enough
    kept++;
    out.push({
      designer,
      title: p.title.replace(/^File:/, ""),
      page: ii.descriptionurl,
      thumb: ii.thumburl,
      width: ii.width,
      height: ii.height,
      license,
      artist: strip(m.Artist?.value),
      description: strip(m.ImageDescription?.value).slice(0, 300),
      date: strip(m.DateTimeOriginal?.value).slice(0, 10),
    });
  }
  console.log(`${designer}: ${kept}`);
}

await mkdir("data", { recursive: true });
await writeFile("data/commons-candidates.json", JSON.stringify(out, null, 2));
console.log(`total ${out.length}`);
