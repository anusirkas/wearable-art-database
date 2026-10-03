"use client";

import { useEffect, useRef } from "react";

/**
 * Vertical scrolling drives a horizontal track: the section is as tall as the track is wide,
 * and the track stays pinned while it slides left. On small screens or with reduced motion it
 * falls back to a plain horizontally scrollable row (see .hgallery in globals.css).
 */
export default function HorizontalGallery({ children, label }: { children: React.ReactNode; label: string }) {
  const outer = useRef<HTMLDivElement>(null);
  const track = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const section = outer.current;
    const row = track.current;
    if (!section || !row) return;
    const wide = window.matchMedia("(min-width: 760px) and (prefers-reduced-motion: no-preference)");
    let frame = 0;

    const layout = () => {
      if (!wide.matches) {
        section.style.height = "";
        row.style.transform = "";
        section.dataset.pinned = "false";
        return;
      }
      section.dataset.pinned = "true";
      const distance = Math.max(0, row.scrollWidth - window.innerWidth);
      section.style.height = `${distance + window.innerHeight}px`;
      update();
    };

    const update = () => {
      frame = 0;
      if (!wide.matches) return;
      const distance = Math.max(0, row.scrollWidth - window.innerWidth);
      const top = section.getBoundingClientRect().top;
      const progress = Math.min(1, Math.max(0, -top / Math.max(1, section.offsetHeight - window.innerHeight)));
      row.style.transform = `translate3d(${-progress * distance}px, 0, 0)`;
    };

    const onScroll = () => {
      if (!frame) frame = requestAnimationFrame(update);
    };

    layout();
    const resize = new ResizeObserver(layout);
    resize.observe(row);
    window.addEventListener("scroll", onScroll, { passive: true });
    window.addEventListener("resize", layout);
    wide.addEventListener("change", layout);
    return () => {
      cancelAnimationFrame(frame);
      resize.disconnect();
      window.removeEventListener("scroll", onScroll);
      window.removeEventListener("resize", layout);
      wide.removeEventListener("change", layout);
    };
  }, []);

  return (
    <div ref={outer} className="hgallery" data-pinned="false">
      <div className="hgallery-sticky">
        <div ref={track} className="hgallery-track" role="list" aria-label={label}>
          {children}
        </div>
      </div>
    </div>
  );
}
