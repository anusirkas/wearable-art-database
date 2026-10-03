import type { Metadata } from "next";
import { IBM_Plex_Mono, Inter_Tight } from "next/font/google";
import Link from "next/link";
import "./globals.css";

const sans = Inter_Tight({ variable: "--font-sans", subsets: ["latin", "latin-ext"] });
const mono = IBM_Plex_Mono({ variable: "--font-mono", subsets: ["latin"], weight: ["400", "500"] });

export const metadata: Metadata = {
  title: { default: "Wearable Art Archive", template: "%s · Wearable Art Archive" },
  description:
    "A searchable archive of wearable art: garments, jewellery and headwear, with makers, materials, techniques and the hours behind each piece.",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className={`${sans.variable} ${mono.variable}`}>
      <body>
        <header className="site-header">
          <Link href="/" className="wordmark">
            Wearable Art <span>Archive</span>
          </Link>
          <nav aria-label="Main">
            <Link href="/">Archive</Link>
            <Link href="/artists">Artists</Link>
            <Link href="/types">Types</Link>
            <Link href="/about">The data</Link>
          </nav>
        </header>
        <main>{children}</main>
        <footer className="site-footer">
          <p>
            Archive pieces: The Metropolitan Museum of Art, Open Access (CC0). Studio profiles are demo data from the
            original course project.
          </p>
          <p>
            Built by <a href="https://portfolio-anu-sirkas-projects.vercel.app">Anu Sirkas</a> · Next.js + PostgreSQL
          </p>
        </footer>
      </body>
    </html>
  );
}
