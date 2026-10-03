import Form from "next/form";
import Link from "next/link";
import ArtworkGrid from "@/components/ArtworkGrid";
import AutoSubmitSelect, { AutoSubmitCheckbox } from "@/components/AutoSubmit";
import { CATEGORIES, getFacets, getStats, searchArtworks, type SearchFilters } from "@/lib/queries";

function one(v: string | string[] | undefined) {
  return (Array.isArray(v) ? v[0] : v)?.trim() || undefined;
}

export default async function ArchivePage({ searchParams }: PageProps<"/">) {
  const params = await searchParams;
  const filters: SearchFilters = {
    q: one(params.q),
    category: one(params.category),
    type: one(params.type),
    material: one(params.material),
    technique: one(params.technique),
    sustainable: one(params.sustainable) === "1",
  };
  const [artworks, facets, stats] = await Promise.all([searchArtworks(filters), getFacets(), getStats()]);
  const filtered = Object.values(filters).some(Boolean);

  const withCategory = (category?: string) => {
    const next = new URLSearchParams();
    for (const [k, v] of Object.entries({ ...filters, category, type: undefined })) {
      if (v) next.set(k, v === true ? "1" : String(v));
    }
    const s = next.toString();
    return s ? `/?${s}` : "/";
  };

  return (
    <>
      <section className="intro">
        <h1>
          Wearable art, <br />
          documented.
        </h1>
        <p>
          {stats.artworks} pieces by {stats.artists} makers: who made them, from what, how, and how long it took.
          Search across titles, makers, materials and techniques.
        </p>
      </section>

      <Form action="/" className="search" role="search">
        <div className="search-row">
          <label htmlFor="q" className="sr-only">
            Search the archive
          </label>
          <input
            id="q"
            name="q"
            type="search"
            defaultValue={filters.q}
            placeholder="Try “silk evening dress”, “brooch”, “Worth” or “cashmere”"
            autoComplete="off"
          />
          <button type="submit">Search</button>
        </div>

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

      <nav className="categories" aria-label="Categories">
        <Link href={withCategory(undefined)} aria-current={!filters.category ? "page" : undefined}>
          Everything
        </Link>
        {CATEGORIES.map((c) => (
          <Link key={c.value} href={withCategory(c.value)} aria-current={filters.category === c.value ? "page" : undefined}>
            {c.label}
          </Link>
        ))}
      </nav>

      <p className="result-count" aria-live="polite">
        {artworks.length === 1 ? "1 piece" : `${artworks.length} pieces`}
        {filters.q ? ` for “${filters.q}”` : ""}
        {filtered && (
          <>
            {" · "}
            <Link href="/">Clear all</Link>
          </>
        )}
      </p>

      {artworks.length > 0 ? (
        <ArtworkGrid artworks={artworks} priority={4} />
      ) : (
        <p className="empty">
          Nothing matches yet. Try a material (“silk”), a maker, or a broader word like “dress”.
        </p>
      )}
    </>
  );
}
