import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { getArtists } from "@/lib/queries";
import { countryName } from "@/lib/format";

// reference data changes rarely; regenerate hourly
export const revalidate = 3600;

export const metadata: Metadata = { title: "Artists" };

const STATUS: Record<string, string> = {
  verified: "Verified studio",
  emerging: "Emerging",
  guest: "Guest",
  archive: "Museum archive",
};

export default async function ArtistsPage() {
  const artists = await getArtists();
  const studio = artists.filter((a) => a.status !== "archive");
  const archive = artists.filter((a) => a.status === "archive");

  return (
    <>
      <section className="intro small">
        <h1>Artists</h1>
        <p>Contemporary studios you can commission, and the historic houses and makers in the museum archive.</p>
      </section>

      {[
        { title: "Studios", list: studio },
        { title: "Archive makers", list: archive },
      ]
        .filter((g) => g.list.length > 0)
        .map((group) => (
          <section key={group.title} className="artist-group">
            <h2>{group.title}</h2>
            <ul className="artist-list">
              {group.list.map((a) => (
                <li key={a.slug}>
                  <Link href={`/artists/${a.slug}`}>
                    <span className="artist-thumb">
                      {a.cover ? (
                        <Image src={a.cover} alt="" width={160} height={200} sizes="80px" />
                      ) : (
                        <span aria-hidden="true">{a.name.charAt(0)}</span>
                      )}
                    </span>
                    <span>
                      <strong>{a.name}</strong>
                      <small>
                        {[STATUS[a.status], a.life_dates ?? countryName(a.country_code), `${a.works} ${a.works === 1 ? "piece" : "pieces"}`]
                          .filter(Boolean)
                          .join(" · ")}
                      </small>
                    </span>
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        ))}
    </>
  );
}
