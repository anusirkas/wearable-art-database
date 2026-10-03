import type { Metadata } from "next";
import Link from "next/link";
import { SuggestTypeForm } from "@/components/Forms";
import { CATEGORIES, getTypes } from "@/lib/queries";

// reference data changes rarely; regenerate hourly
export const revalidate = 3600;

export const metadata: Metadata = { title: "Types" };

export default async function TypesPage() {
  const types = await getTypes();

  return (
    <>
      <section className="intro small">
        <h1>Types</h1>
        <p>
          A fixed set of standard types keeps the archive searchable. Artists can add their own, more precise types, and
          each one sits under a standard type so filters keep working.
        </p>
      </section>

      {CATEGORIES.map((c) => {
        const inCategory = types.filter((t) => t.category === c.value);
        if (inCategory.length === 0) return null;
        return (
          <section key={c.value} className="type-group">
            <h2>{c.label}</h2>
            <ul className="type-list">
              {inCategory.map((t) => (
                <li key={t.id}>
                  <Link href={`/?type=${encodeURIComponent(t.name)}`}>
                    <strong>{t.name}</strong>
                    <span className="muted">{t.works}</span>
                  </Link>
                  {t.description && <small>{t.description}</small>}
                  {t.custom.length > 0 && (
                    <ul className="custom-types">
                      {t.custom.map((ct) => (
                        <li key={ct.name}>
                          <span className="pill">Artist type</span> {ct.name}
                          {ct.description && <small>{ct.description}</small>}
                        </li>
                      ))}
                    </ul>
                  )}
                </li>
              ))}
            </ul>
          </section>
        );
      })}

      <section className="suggest">
        <h2>Suggest a new type</h2>
        <p className="muted">Suggestions go to a review queue first; nothing is published automatically.</p>
        <SuggestTypeForm parents={types.map((t) => t.name)} />
      </section>
    </>
  );
}
