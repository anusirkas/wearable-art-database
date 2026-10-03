import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
import ArtworkGrid from "@/components/ArtworkGrid";
import WallLabel from "@/components/WallLabel";
import { getArtwork, getRelated } from "@/lib/queries";
import { formatDate, formatRange, sustainabilityLabel } from "@/lib/format";

export async function generateMetadata({ params }: PageProps<"/artworks/[slug]">): Promise<Metadata> {
  const artwork = await getArtwork((await params).slug);
  if (!artwork) return {};
  return {
    title: `${artwork.title}, ${artwork.artist.name}`,
    description: artwork.description ?? undefined,
    openGraph: artwork.media[0] ? { images: [artwork.media[0].file_url] } : undefined,
  };
}

export default async function ArtworkPage({ params }: PageProps<"/artworks/[slug]">) {
  const { slug } = await params;
  const [artwork, related] = await Promise.all([getArtwork(slug), getRelated(slug)]);
  if (!artwork) notFound();

  const totalHours = artwork.stages.reduce((sum, s) => sum + Number(s.hours ?? 0), 0);
  const dimensions = [
    artwork.length_cm && `length ${Number(artwork.length_cm)} cm`,
    artwork.width_cm && `width ${Number(artwork.width_cm)} cm`,
    artwork.height_cm && `height ${Number(artwork.height_cm)} cm`,
  ].filter(Boolean);
  const sustainableCount = artwork.materials.filter((m) => m.is_sustainable).length;

  return (
    <article className="artwork">
      <Link href="/archive" className="back">
        ← Archive
      </Link>

      <div className="artwork-layout">
        <div className="artwork-media">
          {artwork.media.length > 0 ? (
            artwork.media.map((m, i) => (
              <figure key={m.file_url}>
                <Image
                  src={m.file_url}
                  alt={m.caption ?? artwork.title}
                  width={m.width ?? 1000}
                  height={m.height ?? 1250}
                  sizes="(max-width: 900px) 100vw, 55vw"
                  priority={i === 0}
                />
                {(m.credit || m.license) && (
                  <figcaption>{[m.credit, m.license].filter(Boolean).join(" · ")}</figcaption>
                )}
              </figure>
            ))
          ) : (
            <div className="no-image large" aria-hidden="true">
              {artwork.type}
              <small>No photograph yet</small>
            </div>
          )}
        </div>

        <div className="artwork-info">
          <p className="eyebrow">
            {artwork.custom_type ? `${artwork.custom_type} · ${artwork.type}` : artwork.type}
          </p>
          <h1>{artwork.title}</h1>
          <p className="maker">
            <Link href={`/artists/${artwork.artist.slug}`}>{artwork.artist.name}</Link>
            {artwork.date_label && <span> · {artwork.date_label}</span>}
          </p>
          {artwork.artist.is_demo && <p className="demo-flag">Demo studio · illustrative photography</p>}

          {artwork.description && <p className="lead">{artwork.description}</p>}
          {artwork.inspiration && (
            <p>
              <strong>Inspiration.</strong> {artwork.inspiration}
            </p>
          )}

          <WallLabel
            maker={artwork.artist.name}
            lifeDates={artwork.artist.life_dates}
            title={artwork.title}
            date={artwork.date_label}
            medium={artwork.materials.map((m) => m.name).join(", ") || null}
            credit={artwork.credit_line ?? artwork.media[0]?.credit}
          />

          <dl className="facts">
            {artwork.culture && (
              <>
                <dt>Culture</dt>
                <dd>{artwork.culture}</dd>
              </>
            )}
            {artwork.size_label && (
              <>
                <dt>Size</dt>
                <dd>{artwork.size_label}</dd>
              </>
            )}
            {dimensions.length > 0 && (
              <>
                <dt>Dimensions</dt>
                <dd>{dimensions.join(", ")}</dd>
              </>
            )}
            {totalHours > 0 && (
              <>
                <dt>Handwork</dt>
                <dd>{totalHours} hours</dd>
              </>
            )}
          </dl>

          {artwork.materials.length > 0 && (
            <section>
              <h2>
                Materials
                {sustainableCount > 0 && (
                  <span className="pill green">
                    {sustainableCount} of {artwork.materials.length} sustainable
                  </span>
                )}
              </h2>
              <ul className="materials">
                {artwork.materials.map((m) => (
                  <li key={m.name}>
                    <Link href={`/archive?material=${encodeURIComponent(m.name)}`}>{m.name}</Link>
                    {m.quantity && <span className="muted"> · {m.quantity}</span>}
                    <span className={`sus sus-${String(m.is_sustainable)}`}>{sustainabilityLabel(m.is_sustainable)}</span>
                    {m.origin && <small>{m.origin}</small>}
                  </li>
                ))}
              </ul>
            </section>
          )}

          {artwork.techniques.length > 0 && (
            <section>
              <h2>Techniques</h2>
              <ol className="techniques">
                {artwork.techniques.map((t) => (
                  <li key={t.name}>
                    <Link href={`/archive?technique=${encodeURIComponent(t.name)}`}>{t.name}</Link>
                    {t.description && <small>{t.description}</small>}
                  </li>
                ))}
              </ol>
            </section>
          )}

          {artwork.stages.length > 0 && (
            <section>
              <h2>How it was made</h2>
              <ol className="stages">
                {artwork.stages.map((s) => (
                  <li key={s.name}>
                    <span className="stage-head">
                      <strong>{s.name}</strong>
                      {s.hours && <span>{Number(s.hours)} h</span>}
                    </span>
                    <small>
                      {formatRange(s.started_on, s.finished_on)}
                      {s.notes ? ` · ${s.notes}` : ""}
                    </small>
                  </li>
                ))}
              </ol>
            </section>
          )}

          {artwork.events.length > 0 && (
            <section>
              <h2>Shown at</h2>
              <ul className="plain">
                {artwork.events.map((e) => (
                  <li key={e.name}>
                    <strong>{e.name}</strong>
                    <small>
                      {[e.venue, e.city].filter(Boolean).join(", ")} · {formatRange(e.starts_on, e.ends_on)}
                    </small>
                  </li>
                ))}
              </ul>
            </section>
          )}

          {artwork.reviews.length > 0 && (
            <section>
              <h2>Reviews</h2>
              <ul className="plain">
                {artwork.reviews.map((r, i) => (
                  <li key={i}>
                    <strong>{Number(r.rating)} / 5</strong> {r.comment}
                    <small>{formatDate(r.reviewed_on)}</small>
                  </li>
                ))}
              </ul>
            </section>
          )}

          {(artwork.credit_line || artwork.source_url) && (
            <p className="source">
              {artwork.source_name}
              {artwork.credit_line ? `, ${artwork.credit_line}` : ""}.{" "}
              {artwork.source_url && <a href={artwork.source_url}>View the museum record</a>}
            </p>
          )}
        </div>
      </div>

      {related.length > 0 && (
        <section className="related">
          <h2>Keep looking</h2>
          <ArtworkGrid artworks={related} />
        </section>
      )}
    </article>
  );
}
