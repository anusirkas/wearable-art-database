'use client'

import { useState } from "react"

export default function Home() {
  const [artworks] = useState([
    {
      id: 1,
      title: "Digital Fabric Dress",
      artist: "Mara Kask",
      year: 2024,
      image: "https://images.unsplash.com/photo-1520975922284-9b456d6f3d8a"
    },
    {
      id: 2,
      title: "Wearable Sculpture",
      artist: "Liis Tamm",
      year: 2023,
      image: "https://images.unsplash.com/photo-1520975958228-1b8c5f1d6a11"
    },
    {
      id: 3,
      title: "Textile Interface",
      artist: "John Doe",
      year: 2025,
      image: "https://images.unsplash.com/photo-1520975682031-cb1f7d2b9a55"
    }
  ])

  return (
    <main className="min-h-screen bg-gray-50 p-10">
      
      {/* HEADER */}
      <div className="max-w-5xl mx-auto mb-10">
        <h1 className="text-4xl font-bold text-gray-900">
          Wearable Art Archive
        </h1>
        <p className="text-gray-600 mt-2">
          A curated digital gallery of experimental wearable art pieces.
        </p>
      </div>

      {/* GRID */}
      <div className="max-w-5xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

        {artworks.map((art) => (
          <div
            key={art.id}
            className="bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition"
          >
            
            {/* IMAGE */}
            <div className="h-48 overflow-hidden">
              <img
                src={art.image}
                alt={art.title}
                className="w-full h-full object-cover hover:scale-105 transition duration-300"
              />
            </div>

            {/* CONTENT */}
            <div className="p-4">
              <h2 className="text-xl font-semibold text-gray-900">
                {art.title}
              </h2>

              <p className="text-gray-600 mt-1">
                Artist: {art.artist}
              </p>

              <p className="text-gray-500 text-sm mt-1">
                Year: {art.year}
              </p>
            </div>

          </div>
        ))}

      </div>

    </main>
  )
}