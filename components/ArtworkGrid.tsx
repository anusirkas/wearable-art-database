import Image from "next/image";
import Link from "next/link";
import type { ArtworkCard } from "@/lib/queries";

export default function ArtworkGrid({ artworks, priority = 0 }: { artworks: ArtworkCard[]; priority?: number }) {
  return (
    <ul className="grid">
      {artworks.map((a, i) => (
        <li key={a.slug}>
          <Link href={`/artworks/${a.slug}`} className="card">
            {a.image ? (
              <span className="card-image">
                <Image
                  src={a.image}
                  alt={`${a.title} by ${a.artist}`}
                  width={a.width ?? 800}
                  height={a.height ?? 1000}
                  sizes="(max-width: 640px) 50vw, (max-width: 1100px) 33vw, 25vw"
                  priority={i < priority}
                />
              </span>
            ) : (
              <span className="no-image" aria-hidden="true">
                {a.type}
              </span>
            )}
            <span className="card-meta">
              <span className="card-maker">{a.artist}</span>
              <span className="card-title">{a.title}</span>
              {a.date_label && <span className="card-sub">{a.date_label}</span>}
            </span>
          </Link>
        </li>
      ))}
    </ul>
  );
}
