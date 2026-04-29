'use client'

import { useState } from "react"

export default function Home() {
  const [artworks] = useState([
    {
      id: 1,
      title: "Digital Fabric Dress",
      artist: "Demo Artist",
      year: 2024
    },
    {
      id: 2,
      title: "Wearable Sculpture",
      artist: "Test Designer",
      year: 2023
    }
  ])

  return (
    <main style={{ padding: 40, fontFamily: "Arial" }}>
      <h1 style={{ fontSize: 32 }}>Wearable Art Archive</h1>

      <p style={{ marginBottom: 20 }}>
        A digital collection of wearable art pieces.
      </p>

      <div style={{ display: "grid", gap: 16 }}>
        {artworks.map((a) => (
          <div
            key={a.id}
            style={{
              padding: 16,
              border: "1px solid #ddd",
              borderRadius: 8
            }}
          >
            <h2>{a.title}</h2>
            <p>Artist: {a.artist}</p>
            <p>Year: {a.year}</p>
          </div>
        ))}
      </div>
    </main>
  )
}