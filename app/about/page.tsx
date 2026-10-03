import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { getCourseQueries } from "@/lib/queries";
import erd from "@/public/wearable-art-erd.png";

// reference data changes rarely; regenerate hourly
export const revalidate = 3600;

export const metadata: Metadata = { title: "The data" };

// The original Oracle course project used Estonian names; the PostgreSQL port uses English ones.
const NAME_MAP: [string, string, string][] = [
  ["KUNSTNIK", "artist", "Artists and studios"],
  ["TEOS", "artwork", "The wearable pieces"],
  ["TEOSE_TYYP", "artwork_type", "Standard types (dress, brooch…)"],
  ["UUS_TEOSE_TYYP", "custom_artwork_type", "Types added by artists"],
  ["MATERJAL", "material", "Materials, origin, sustainability"],
  ["TEHNIKA", "technique", "Techniques"],
  ["TEOSE_MATERJAL", "artwork_material", "Which materials, how much"],
  ["TEOSE_TEHNIKA", "artwork_technique", "Which techniques, in what order"],
  ["LOOMISE_ETAPP", "creation_stage", "Making stages and hours"],
  ["MEEDIA", "media", "Photos and their credits"],
  ["SUNDMUS", "event", "Exhibitions, galleries, runway shows"],
  ["TEOSE_SUNDMUS", "artwork_event", "Where a piece was shown"],
  ["KOLLEKTSIONAAR", "collector", "Buyers and collectors"],
  ["TELLIMUS", "commission", "Commission requests"],
  ["PAKKUMINE", "offer", "The artist's offers"],
  ["TEHING", "transaction", "Payments; traces ownership"],
  ["TEHINGU_TYYP", "transaction_type", "Deposit, sale, fee"],
  ["KINNITUS", "endorsement", "Professional endorsements"],
  ["KINNITUSE_TYYP", "endorsement_type", "Education, exhibition, curator"],
  ["HINNANG", "review", "Community reviews"],
  ["USALDUSSKOOR", "trust_score", "Trust score over time"],
];

const FIXES = [
  "Every foreign key and NOT NULL rule now holds: the original inserts referenced columns that didn't exist and put NULL into required keys.",
  "A review is about an artist or an artwork, enforced with a CHECK, instead of requiring both.",
  "Join tables use the (artwork, material) pair as the key instead of a surrogate id plus a composite key.",
  "Countries are ISO codes, statuses and event types are checked against fixed lists, dates can't end before they start.",
  "Ownership history is traced through commissions and transactions, as the final version of the course project decided, so the earlier OMANDILUGU table is gone.",
];

export default async function AboutPage() {
  const { laborious, byArtist, luxury } = await getCourseQueries();

  return (
    <article className="about">
      <section className="intro small">
        <h1>The data</h1>
        <p>
          This archive started as a database course project at TalTech: 21 tables designed in Oracle to document wearable
          art from first sketch to sale. Here it runs on PostgreSQL, with the schema cleaned up and the search built in.
        </p>
      </section>

      <section>
        <h2>Entity–relationship diagram</h2>
        <p className="muted">The original design from the course project.</p>
        <a href={erd.src} className="erd">
          <Image src={erd} alt="Entity–relationship diagram of the 21 tables" sizes="(max-width: 1100px) 100vw, 1100px" />
        </a>
      </section>

      <section>
        <h2>From Estonian to English</h2>
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Course project (Oracle)</th>
                <th>This archive (PostgreSQL)</th>
                <th>Holds</th>
              </tr>
            </thead>
            <tbody>
              {NAME_MAP.map(([et, en, what]) => (
                <tr key={en}>
                  <td>
                    <code>{et}</code>
                  </td>
                  <td>
                    <code>{en}</code>
                  </td>
                  <td>{what}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>

      <section>
        <h2>What changed in the port</h2>
        <ul className="bullets">
          {FIXES.map((f) => (
            <li key={f}>{f}</li>
          ))}
        </ul>
      </section>

      <section>
        <h2>The course queries, running live</h2>

        <div className="query">
          <h3>Exclusive, labour-intensive pieces</h3>
          <p className="muted">“Show me only pieces that took real time to make”: more than 100 hours of handwork.</p>
          <pre>{`SELECT a.title, sum(cs.hours) AS total_hours
FROM creation_stage cs
JOIN artwork a ON a.id = cs.artwork_id
GROUP BY a.id
HAVING sum(cs.hours) > 100;`}</pre>
          <ul className="result">
            {laborious.map((r) => (
              <li key={r.slug}>
                <Link href={`/artworks/${r.slug}`}>{r.title}</Link> <span>{r.total_hours} h</span>
              </li>
            ))}
          </ul>
        </div>

        <div className="query">
          <h3>One artist&apos;s work</h3>
          <p className="muted">“I like Halcyon Knit Lab&apos;s work. Show me all their pieces.”</p>
          <pre>{`SELECT ar.name, a.title, t.name AS type, a.description
FROM artist ar
JOIN artwork a ON a.artist_id = ar.id
JOIN artwork_type t ON t.id = a.artwork_type_id
WHERE ar.name = 'Halcyon Knit Lab';`}</pre>
          <ul className="result">
            {byArtist.map((r) => (
              <li key={r.title}>
                {r.title} <span>{r.type}</span>
              </li>
            ))}
          </ul>
        </div>

        <div className="query">
          <h3>Luxury materials</h3>
          <p className="muted">“Which pieces use silk, cashmere or merino, and how much?”</p>
          <pre>{`SELECT a.title, ar.name AS artist, m.name AS material, am.quantity
FROM artwork a
JOIN artwork_material am ON am.artwork_id = a.id
JOIN material m ON m.id = am.material_id
JOIN artist ar ON ar.id = a.artist_id
WHERE m.name IN ('Silk', 'Cashmere', 'Merino wool');`}</pre>
          <ul className="result">
            {luxury.map((r) => (
              <li key={`${r.slug}-${r.material}`}>
                <span className="result-name">
                  <Link href={`/artworks/${r.slug}`}>{r.title}</Link>, {r.artist}
                </span>
                <span>{[r.material, r.quantity].filter(Boolean).join(" · ")}</span>
              </li>
            ))}
          </ul>
        </div>
      </section>

      <section>
        <h2>How search works</h2>
        <p>
          A materialized view joins each piece with its maker, type, materials and techniques into one weighted
          full-text document (title and maker count most, descriptions least). A query matches by full-text search in
          both a plain and an English dictionary, so “dresses” finds “dress”, and falls back to trigram similarity on
          accent-free text, so a typo like “embroidry” still finds embroidery. Both are backed by GIN indexes.
        </p>
      </section>
    </article>
  );
}
