/** A museum wall label: maker, dates, title, medium and credit, set like the card beside a vitrine. */
export default function WallLabel({
  maker,
  lifeDates,
  title,
  date,
  medium,
  credit,
  className = "",
}: {
  maker: string;
  lifeDates?: string | null;
  title: string;
  date?: string | null;
  medium?: string | null;
  credit?: string | null;
  className?: string;
}) {
  return (
    <div className={`wall-label ${className}`}>
      <p className="wl-maker">{maker}</p>
      {lifeDates && <p className="wl-dates">{lifeDates}</p>}
      <p className="wl-title">
        {title}
        {date ? <span>, {date}</span> : null}
      </p>
      {medium && <p className="wl-medium">{medium}</p>}
      {credit && <p className="wl-credit">{credit}</p>}
    </div>
  );
}
