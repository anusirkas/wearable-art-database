'use client'

import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"

export default function Home() {
  const [artworks, setArtworks] = useState<any[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchArtworks() {
      const { data, error } = await supabase
        .from("artworks")
        .select("*")

      if (error) {
        console.error("Supabase error:", error)
      } else {
        setArtworks(data || [])
      }

      setLoading(false)
    }

    fetchArtworks()
  }, [])

  return (
    <main className="min-h-screen bg-gray-50 p-10">

      {/* HEADER */}
      <div className="max-w-5xl mx-auto mb-10">
        <h1 className="text-4xl font-bold text-gray-900">
          Wearable Art Archive
        </h1>
        <p className="text-gray-600 mt-2">
          Digital collection of wearable art pieces stored in Supabase.
        </p>
      </div>

      {/* LOADING */}
      {loading && (
        <p className="text-center text-gray-500">
          Loading artworks...
        </p>
      )}

      {/* EMPTY STATE */}
      {!loading && artworks.length === 0 && (
        <p className="text-center text-gray-500">
          No artworks found in database.
        </p>
      )}

      {/* GRID */}
      <div className="max-w-5xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

        {artworks.map((art) => (
          <div
            key={art.id}
            className="bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition"
          >

            {/* IMAGE */}
            {art.image_url && (
              <div className="h-48 overflow-hidden">
                <img
                  src={art.image_url}
                  alt={art.title}
                  className="w-full h-full object-cover hover:scale-105 transition duration-300"
                />
              </div>
            )}

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