'use client'

import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"
import { useParams } from "next/navigation"
import Link from "next/link"

export default function ArtworkDetail() {
  const { id } = useParams()
  const [art, setArt] = useState<any>(null)

  useEffect(() => {
    async function fetchArtwork() {
      const { data, error } = await supabase
        .from("teos")
        .select(`
          id,
          pealkiri,
          kirjeldus,
          aasta,
          kunstnik:kunstnik_id (nimi, riik),
          meedia (faili_url)
        `)
        .eq("id", id)
        .single()

      if (error) console.error(error)
      else setArt(data)
    }

    fetchArtwork()
  }, [id])

  if (!art) return <p className="p-10">Loading...</p>

  return (
    <main className="min-h-screen bg-gray-50 p-10">

      <div className="max-w-3xl mx-auto">

        {/* BACK */}
        <Link href="/" className="text-blue-500 mb-4 inline-block">
          ← Back
        </Link>

        {/* IMAGE */}
        {art.meedia?.[0]?.faili_url && (
          <img
            src={art.meedia[0].faili_url}
            alt={art.pealkiri}
            className="w-full h-96 object-cover rounded-xl mb-6"
          />
        )}

        {/* CONTENT */}
        <h1 className="text-3xl font-bold mb-2">
          {art.pealkiri}
        </h1>

        <p className="text-gray-600 mb-2">
          {art.kunstnik?.nimi} ({art.kunstnik?.riik})
        </p>

        <p className="text-gray-500 mb-4">
          Year: {art.aasta}
        </p>

        <p className="text-gray-700 leading-relaxed">
          {art.kirjeldus}
        </p>

      </div>

    </main>
  )
}