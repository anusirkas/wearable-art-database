import Form from "next/form";
import Image from "next/image";
import Link from "next/link";
import HorizontalGallery from "@/components/HorizontalGallery";
import Reveal from "@/components/Reveal";
import WallLabel from "@/components/WallLabel";
import { countryName, formatYear } from "@/lib/format";
import { getArtworksBySlug, getContemporary, getMaterialStats, getStats, getStudios } from "@/lib/queries";

// home page content only changes when the seed data does
export const revalidate = 3600;

const HERO = [
  "feather-dress-the-horn-of-plenty-alexander-mcqueen",
  "ball-gown-house-of-worth-155944",
  "gold-couture-gown-detail-guo-pei",
  "syntopia-look-7-iris-van-herpen",
];
const ROOM_ONE = [
  "ball-gown-house-of-worth-155944",
  "evening-coat-house-of-worth-159193",
  "archaeological-revival-necklace-castellani-716657",
  "brooch-tiffany-co-1025",
];

export default async function Home() {
  const [hero, roomOne, contemporary, studios, materials, stats] = await Promise.all([
    getArtworksBySlug(HERO),
    getArtworksBySlug(ROOM_ONE),
    getContemporary(14),
    getStudios(),
    getMaterialStats(),
    getStats(),
  ]);
  const [featured, ...archiveThumbs] = roomOne;
  const centuries = Math.ceil((new Date().getFullYear() - stats.first_year) / 100);

  return (
    <div className="home">
      {/* ---------- Entrance ---------- */}
      <section className="hero" aria-label="Introduction">
        <div className="hero-slides" aria-hidden="true">
          {hero.map((a, i) =>
            a.image ? (
              <div key={a.slug} className="hero-slide" style={{ "--i": i } as React.CSSProperties}>
                <Image src={a.image} alt="" fill sizes="100vw" priority={i === 0} />
              </div>
            ) : null,
          )}
        </div>
        <div className="hero-shade" />
        <div className="hero-content">
          <p className="eyebrow light">The Wearable Art Archive · {formatYear(stats.first_year)} to now</p>
          <h1 className="display hero-title">
            Made to be worn.
            <br />
            Kept to be remembered.
          </h1>
          <Form action="/archive" className="hero-search" role="search">
            <label htmlFor="hero-q" className="sr-only">
              Search the archive
            </label>
            <input id="hero-q" name="q" type="search" placeholder={`Search ${stats.artworks} pieces`} autoComplete="off" />
            <button type="submit">Enter the archive</button>
          </Form>
        </div>
        <ul className="hero-credits" aria-label="Pieces shown">
          {hero.map((a, i) => (
            <li key={a.slug} style={{ "--i": i } as React.CSSProperties}>
              <Link href={`/artworks/${a.slug}`}>
                {a.artist}, <span>{a.title}</span>
              </Link>
            </li>
          ))}
        </ul>
        <span className="scroll-cue" aria-hidden="true">
          Scroll
        </span>
      </section>

      {/* ---------- Ledger ---------- */}
      <section className="ledger" aria-label="The archive in numbers">
        {[
          [stats.artworks, "pieces"],
          [stats.artists, "makers"],
          [centuries, "centuries"],
          [stats.hours.toLocaleString("en-GB"), "hours of handwork on record"],
        ].map(([value, label], i) => (
          <Reveal key={String(label)} className="ledger-item" delay={i * 90}>
            <span className="ledger-value">{value}</span>
            <span className="ledger-label">{label}</span>
          </Reveal>
        ))}
      </section>

      <div className="rooms">
        {/* ---------- Room I: the museum archive ---------- */}
        <section className="room room-oxblood room-pinned room-one" aria-labelledby="room-one">
          <div className="room-inner room-split">
            <div className="room-text">
              <p className="room-number">Room I</p>
              <h2 id="room-one" className="display">
                The Archive
              </h2>
              <p className="room-years">1750 – 1910</p>
              <p className="room-lead">
                Couture houses, jewellers and milliners from the age before ready-to-wear, from the open-access
                collection of The Metropolitan Museum of Art.
              </p>
              <Link href="/archive?collection=archive" className="room-link">
                Walk the archive →
              </Link>
              <ul className="room-thumbs">
                {archiveThumbs.map((a) =>
                  a.image ? (
                    <li key={a.slug}>
                      <Link href={`/artworks/${a.slug}`}>
                        <Image src={a.image} alt={`${a.title} by ${a.artist}`} width={a.width ?? 400} height={a.height ?? 500} sizes="160px" />
                        <span>{a.artist}</span>
                      </Link>
                    </li>
                  ) : null,
                )}
              </ul>
            </div>
            {featured?.image && (
              <figure className="room-feature">
                <Link href={`/artworks/${featured.slug}`}>
                  <Image src={featured.image} alt={`${featured.title} by ${featured.artist}`} width={featured.width ?? 900} height={featured.height ?? 1200} sizes="(max-width: 900px) 90vw, 40vw" />
                </Link>
                <WallLabel
                  maker={featured.artist}
                  lifeDates={featured.life_dates}
                  title={featured.title}
                  date={featured.date_label}
                  medium={featured.medium}
                  credit="The Metropolitan Museum of Art"
                />
              </figure>
            )}
          </div>
        </section>

        {/* ---------- Room II: contemporary, horizontal ---------- */}
        <section className="room room-white room-two" aria-labelledby="room-two">
          <div className="room-two-head">
            <p className="room-number">Room II</p>
            <h2 id="room-two" className="mega">
              Now
            </h2>
            <p className="room-lead">
              3D-printed couture, coffee tables that become skirts, dresses lit from within. Designers working today,
              photographed in the museums that collect them.
            </p>
            <Link href="/archive?collection=contemporary" className="room-link dark">
              All contemporary pieces →
            </Link>
          </div>
          <HorizontalGallery label="Contemporary designers">
            {contemporary.map((a, i) =>
              a.image ? (
                <Link key={a.slug} href={`/artworks/${a.slug}`} className="hcard" role="listitem">
                  <span className="hcard-index">{String(i + 1).padStart(2, "0")}</span>
                  <Image src={a.image} alt={`${a.title} by ${a.artist}`} width={a.width ?? 800} height={a.height ?? 1100} sizes="(max-width: 760px) 70vw, 28vw" />
                  <span className="hcard-maker">{a.artist}</span>
                  <span className="hcard-title">
                    {a.title}
                    {a.date_label ? `, ${a.date_label}` : ""}
                  </span>
                </Link>
              ) : null,
            )}
          </HorizontalGallery>
        </section>

        {/* ---------- Room III: materials ---------- */}
        <section className="room room-green room-pinned room-three" aria-labelledby="room-three">
          <div className="room-inner room-split">
            <div className="room-text">
              <p className="room-number">Room III</p>
              <h2 id="room-three" className="display">
                Materials
              </h2>
              <p className="room-lead">
                Every piece lists what it is made of, where the material came from, and whether it is sustainable.
                Not to shame silk or gold, but so you can choose knowing.
              </p>
              <Link href="/archive?sustainable=1" className="room-link">
                Show pieces with sustainable materials →
              </Link>
            </div>
            <div className="material-panel">
              <Reveal className="material-bars">
                {[
                  ["Sustainable", materials.sustainable, "is-green"],
                  ["Conventional", materials.conventional, ""],
                  ["Not yet known", materials.unknown, "is-muted"],
                ].map(([label, value, tone]) => {
                  const total = materials.sustainable + materials.conventional + materials.unknown;
                  return (
                    <div key={String(label)} className={`material-bar ${tone}`}>
                      <span className="mb-label">{label}</span>
                      <span className="mb-track">
                        <span style={{ width: `${(Number(value) / total) * 100}%` }} />
                      </span>
                      <span className="mb-value">{value}</span>
                    </div>
                  );
                })}
              </Reveal>
              <p className="material-note">
                Material uses across all pieces. {materials.pieces_with_sustainable} pieces use at least one sustainable
                material.
              </p>
              <ul className="material-list">
                {materials.top.map((m) => (
                  <li key={m.name}>
                    <Link href={`/archive?material=${encodeURIComponent(m.name)}`}>{m.name}</Link>
                    <span>{m.count}</span>
                  </li>
                ))}
              </ul>
            </div>
          </div>
        </section>

        {/* ---------- Room IV: studios ---------- */}
        <section className="room room-charcoal room-four" aria-labelledby="room-four">
          <div className="room-inner">
            <div className="room-four-head">
              <p className="room-number">Room IV</p>
              <h2 id="room-four" className="display">
                Studios
              </h2>
              <p className="room-lead">
                Order from a person, not a factory. One piece, made to last, with the materials and the hours on record.
              </p>
            </div>
            <ul className="studio-grid">
              {studios.map((s, i) => (
                <Reveal as="li" key={s.slug} delay={(i % 3) * 110}>
                  <Link href={`/artists/${s.slug}`} className="studio-card">
                    {s.cover && (
                      <Image src={s.cover} alt="" width={s.cover_w ?? 600} height={s.cover_h ?? 800} sizes="(max-width: 760px) 90vw, 30vw" />
                    )}
                    <span className="studio-name">{s.name}</span>
                    <span className="studio-meta">
                      {countryName(s.country_code)} · {s.works} pieces · {s.hours} hours documented
                    </span>
                  </Link>
                </Reveal>
              ))}
            </ul>
            <p className="demo-note">Studios are demo profiles with illustrative photography, credited on each piece.</p>
          </div>
        </section>
      </div>

      {/* ---------- Exit ---------- */}
      <section className="closing">
        <Reveal>
          <p className="eyebrow">End of the tour</p>
          <Link href="/archive" className="closing-link display">
            Enter the archive →
          </Link>
        </Reveal>
      </section>
    </div>
  );
}
