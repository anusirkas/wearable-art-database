import type { Metadata } from "next";
import Form from "next/form";
import Link from "next/link";
import ArtworkGrid from "@/components/ArtworkGrid";
import AutoSubmitSelect, { AutoSubmitCheckbox } from "@/components/AutoSubmit";
import { formatYear } from "@/lib/format";
import { CATEGORIES, COLLECTIONS, getFacets, getStats, searchArtworks, type SearchFilters } from "@/lib/queries";

export const metadata: Metadata = { title: "Archive" };

function one(v: string | string[] | undefined) {
  return (Array.isArray(v) ? v[0] : v)?.trim() || undefined;
}

export default async function ArchivePage({ searchParams }: PageProps<"/archive">) {
  const params = await searchParams;
  const filters: SearchFilters = {
    q: one(params.q),
    collection: one(params.collection),
    category: one(params.category),
    type: one(params.type),
    material: one(params.material),
    technique: one(params.technique),
    sustainable: one(params.sustainable) === "1",
  };
  const [artworks, facets, stats] = await Promise.all([searchArtworks(filters), getFacets(), getStats()]);
  const filtered = Object.values(filters).some(Boolean);

  /** Same filters with one key changed; switching category also resets the type. */
  const withParam = (key: "collection" | "category", value?: string) => {
    const next = new URLSearchParams();
    const merged = { ...filters, [key]: value, ...(key === "category" ? { type: undefined } : {}) };
    for (const [k, v] of Object.entries(merged)) {
      if (v) next.set(k, v === true ? "1" : String(v));
    }
    const s = next.toString();
    return s ? `/archive?${s}` : "/archive";
  };

  return (
    <div className="archive-page">
      <header className="page-head">
        <p className="eyebrow">The archive</p>
        <h1 className="display">Search the collection</h1>
        <p className="lead">
          {stats.artworks} pieces by {stats.artists} makers, from {formatYear(stats.first_year)} to now. Search titles, makers,
          materials and techniques at once.
        </p>
      </header>

      <Form action="/archive" className="search" role="search">
        <div className="search-row">
          <label htmlFor="q" className="sr-only">
            Search the archive
          </label>
          <input
            id="q"
            name="q"
            type="search"
            defaultValue={filters.q}
            placeholder="Try “feathers”, “brooch”, “McQueen” or “recycled silver”"
            autoComplete="off"
          />
          <button type="submit">Search</button>
        </div>

        {filters.collection && <input type="hidden" name="collection" value={filters.collection} />}
        {filters.category && <input type="hidden" name="category" value={filters.category} />}

        <div className="filters">
          <AutoSubmitSelect
            name="type"
            label="Type"
            value={filters.type ?? ""}
            options={facets.types
              .filter((t) => !filters.category || t.category === filters.category)
              .map((t) => ({ value: t.name, label: `${t.name} (${t.count})` }))}
          />
          <AutoSubmitSelect
            name="material"
            label="Material"
            value={filters.material ?? ""}
            options={facets.materials.map((m) => ({ value: m.name, label: `${m.name} (${m.count})` }))}
          />
          <AutoSubmitSelect
            name="technique"
            label="Technique"
            value={filters.technique ?? ""}
            options={facets.techniques.map((t) => ({ value: t.name, label: `${t.name} (${t.count})` }))}
          />
          <AutoSubmitCheckbox name="sustainable" label="Sustainable materials" checked={!!filters.sustainable} />
        </div>
      </Form>

      <div className="chips-row">
        <nav className="chips" aria-label="Collections">
          <Link href={withParam("collection")} aria-current={!filters.collection ? "page" : undefined}>
            All collections
          </Link>
          {COLLECTIONS.map((c) => (
            <Link key={c.value} href={withParam("collection", c.value)} aria-current={filters.collection === c.value ? "page" : undefined}>
              {c.label}
            </Link>
          ))}
        </nav>
        <nav className="categories" aria-label="Categories">
          <Link href={withParam("category")} aria-current={!filters.category ? "page" : undefined}>
            Everything
          </Link>
          {CATEGORIES.map((c) => (
            <Link key={c.value} href={withParam("category", c.value)} aria-current={filters.category === c.value ? "page" : undefined}>
              {c.label}
            </Link>
          ))}
        </nav>
      </div>

      <p className="result-count" aria-live="polite">
        {artworks.length === 1 ? "1 piece" : `${artworks.length} pieces`}
        {filters.q ? ` for “${filters.q}”` : ""}
        {filtered && (
          <>
            {" · "}
            <Link href="/archive">Clear all</Link>
          </>
        )}
      </p>

      {artworks.length > 0 ? (
        <ArtworkGrid artworks={artworks} priority={4} />
      ) : (
        <p className="empty">Nothing matches yet. Try a material (“silk”), a maker, or a broader word like “dress”.</p>
      )}
    </div>
  );
}
