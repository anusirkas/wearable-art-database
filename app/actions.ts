"use server";

import { createHash } from "node:crypto";
import { headers } from "next/headers";
import { addSubmission } from "@/lib/queries";

export type FormState = { ok: boolean; message: string } | null;

async function visitorHash() {
  const h = await headers();
  const ip = h.get("x-forwarded-for")?.split(",")[0]?.trim() || h.get("x-real-ip") || "unknown";
  // stored only as a salted hash, for rate limiting
  return createHash("sha256").update(`${process.env.SUBMISSION_SALT ?? "wearable-art"}:${ip}`).digest("hex");
}

function text(form: FormData, key: string, max: number) {
  const value = String(form.get(key) ?? "").trim();
  return value.length > max ? null : value;
}

export async function suggestType(_: FormState, form: FormData): Promise<FormState> {
  if (form.get("website")) return { ok: true, message: "Thank you." }; // honeypot
  const name = text(form, "name", 50);
  const parent = text(form, "parent", 50);
  const description = text(form, "description", 255);
  if (!name || name.length < 3) return { ok: false, message: "Give the new type a name (3–50 characters)." };
  if (!parent) return { ok: false, message: "Choose the standard type it belongs under." };
  if (description === null) return { ok: false, message: "Keep the description under 255 characters." };

  const result = await addSubmission("artwork_type", { name, parent, description }, await visitorHash());
  return result.ok
    ? { ok: true, message: `Thank you. “${name}” is in the review queue and appears here once approved.` }
    : { ok: false, message: result.error };
}

export async function requestCommission(_: FormState, form: FormData): Promise<FormState> {
  if (form.get("website")) return { ok: true, message: "Thank you." };
  const artist = text(form, "artist", 100);
  const name = text(form, "name", 200);
  const email = text(form, "email", 200);
  const description = text(form, "description", 1000);
  const budget = Number(form.get("budget") || 0);
  if (!artist) return { ok: false, message: "Missing artist." };
  if (!name) return { ok: false, message: "Tell the artist your name." };
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return { ok: false, message: "Add an email address the artist can reply to." };
  if (!description || description.length < 20) return { ok: false, message: "Describe the piece you have in mind (at least 20 characters)." };
  if (!Number.isFinite(budget) || budget < 0 || budget > 1_000_000) return { ok: false, message: "Budget should be a number in euros." };

  const result = await addSubmission("commission", { artist, name, email, description, budget }, await visitorHash());
  return result.ok
    ? { ok: true, message: "Request received. This is a demo profile, so it stays in the review queue and is not sent on." }
    : { ok: false, message: result.error };
}
