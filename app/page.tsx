'use client'

import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"
import Link from "next/link"

export default function Home() {
  const [artworks, setArtworks] = useState<any[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchArtworks() {
      const { data, error } = await supabase
        .from("teos")
        .select(`
          id,
          pealkiri,
          aasta,
          kunstnik:kunstnik_id (nimi),
          meedia (faili_url)
        `)

      if (error) {
        console.error(error)
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
          Digital collection of wearable art.
        </p>
      </div>

      {/* LOADING */}
      {loading && <p className="text-center">Loading...</p>}

      {/* GRID */}
      <div className="max-w-5xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

        {artworks.map((art) => (
          <Link key={art.id} href={`/teos/${art.id}`}>
            
            <div className="bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition cursor-pointer">

              {/* IMAGE */}
              {art.meedia?.[0]?.faili_url && (
                <div className="h-48 overflow-hidden">
                  <img
                    src={art.meedia[0].faili_url}
                    alt={art.pealkiri}
                    className="w-full h-full object-cover hover:scale-105 transition duration-300"
                  />
                </div>
              )}

              {/* CONTENT */}
              <div className="p-4">
                <h2 className="text-xl font-semibold">
                  {art.pealkiri}
                </h2>

                <p className="text-gray-600">
                  {art.kunstnik?.nimi}
                </p>

                <p className="text-sm text-gray-500">
                  {art.aasta}
                </p>
              </div>

            </div>

          </Link>
        ))}

      </div>

    </main>
  )
}