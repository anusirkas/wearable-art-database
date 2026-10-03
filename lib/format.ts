const DATE = new Intl.DateTimeFormat("en-GB", { day: "numeric", month: "short", year: "numeric", timeZone: "UTC" });

export function formatDate(value: string | null) {
  return value ? DATE.format(new Date(value)) : "";
}

export function formatRange(from: string | null, to: string | null) {
  if (from && to) return `${formatDate(from)} – ${formatDate(to)}`;
  return formatDate(from ?? to);
}

export function sustainabilityLabel(value: boolean | null) {
  if (value === true) return "Sustainable";
  if (value === false) return "Conventional";
  return "Unknown";
}

const REGIONS = new Intl.DisplayNames(["en"], { type: "region" });

export function countryName(code: string | null) {
  if (!code) return null;
  try {
    return REGIONS.of(code.trim()) ?? code;
  } catch {
    return code;
  }
}
