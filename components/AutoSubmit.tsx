"use client";

/** A select that submits its form on change, so filters apply without a button. */
export default function AutoSubmitSelect({
  name,
  label,
  value,
  options,
}: {
  name: string;
  label: string;
  value: string;
  options: { value: string; label: string }[];
}) {
  return (
    <label className="filter">
      <span>{label}</span>
      <select name={name} defaultValue={value} onChange={(e) => e.currentTarget.form?.requestSubmit()}>
        <option value="">All</option>
        {options.map((o) => (
          <option key={o.value} value={o.value}>
            {o.label}
          </option>
        ))}
      </select>
    </label>
  );
}

export function AutoSubmitCheckbox({ name, label, checked }: { name: string; label: string; checked: boolean }) {
  return (
    <label className="toggle">
      <input
        type="checkbox"
        name={name}
        value="1"
        defaultChecked={checked}
        onChange={(e) => e.currentTarget.form?.requestSubmit()}
      />
      <span>{label}</span>
    </label>
  );
}
