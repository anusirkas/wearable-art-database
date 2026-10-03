import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import ArtworkGrid from "@/components/ArtworkGrid";
import { CommissionForm } from "@/components/Forms";
import { getArtist, getArtistWorks } from "@/lib/queries";
import { countryName, formatDate } from "@/lib/format";

export async function generateMetadata({ params }: PageProps<"/artists/[slug]">): Promise<Metadata> {
  const artist = await getArtist((await params).slug);
  return artist ? { title: artist.name, description: artist.bio ?? undefined } : {};
}

export default async function ArtistPage({ params }: PageProps<"/artists/[slug]">) {
  const { slug } = await params;
  const [artist, works] = await Promise.all([getArtist(slug), getArtistWorks(slug)]);
  if (!artist) notFound();
  const isArchive = artist.status === "archive";

  return (
    <article className="artist">
      <Link href="/artists" className="back">
        ← Artists
      </Link>

      <header className="artist-head">
        <p className="eyebrow">{isArchive ? "Museum archive" : `${artist.status} studio`}</p>
        <h1>{artist.name}</h1>
        <p className="muted">{artist.life_dates ?? countryName(artist.country_code)}</p>
        {artist.is_demo && <p className="demo-flag">Demo profile from the original course project</p>}
        {artist.bio && <p className="lead">{artist.bio}</p>}
      </header>

      {!isArchive && (
        <div className="artist-panels">
          {artist.trust && (
            <section className="panel">
              <h2>Trust score</h2>
              <p className="big-number">
                {Number(artist.trust.score)}
                <small>/100</small>
              </p>
              <p className="muted">
                {artist.trust.basis} Calculated {formatDate(artist.trust.calculated_on)}.
              </p>
            </section>
          )}
          {artist.total_hours && (
            <section className="panel">
              <h2>Documented handwork</h2>
              <p className="big-number">
                {Number(artist.total_hours)}
                <small> hours</small>
              </p>
              <p className="muted">Across every creation stage logged in the archive.</p>
            </section>
          )}
          {artist.endorsements.length > 0 && (
            <section className="panel">
              <h2>Endorsements</h2>
              <ul className="plain">
                {artist.endorsements.map((e, i) => (
                  <li key={i}>
                    <strong>{e.type}</strong> {e.description}
                    <small>
                      {e.endorsed_by}
                      {e.endorsed_on ? ` · ${formatDate(e.endorsed_on)}` : ""}
                    </small>
                  </li>
                ))}
              </ul>
            </section>
          )}
          {artist.reviews.length > 0 && (
            <section className="panel">
              <h2>Reviews</h2>
              <ul className="plain">
                {artist.reviews.map((r, i) => (
                  <li key={i}>
                    <strong>{Number(r.rating)} / 5</strong> {r.comment}
                    <small>{formatDate(r.reviewed_on)}</small>
                  </li>
                ))}
              </ul>
            </section>
          )}
        </div>
      )}

      {artist.creative_cv && (
        <section className="cv">
          <h2>CV</h2>
          <p>{artist.creative_cv}</p>
        </section>
      )}

      <section>
        <h2>Work in the archive</h2>
        {works.length > 0 ? <ArtworkGrid artworks={works} /> : <p className="muted">No pieces yet.</p>}
      </section>

      {!isArchive && (
        <section className="commission">
          <h2>Commission a piece</h2>
          <p className="muted">
            Ordering from a person, not a factory: one piece, made to last, with the materials and hours on record.
          </p>
          <CommissionForm artist={artist.slug} />
        </section>
      )}
    </article>
  );
}
