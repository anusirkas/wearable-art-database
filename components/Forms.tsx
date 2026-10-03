"use client";

import { useActionState } from "react";
import { requestCommission, suggestType, type FormState } from "@/app/actions";

function Status({ state }: { state: FormState }) {
  if (!state) return null;
  return (
    <p className={state.ok ? "form-ok" : "form-error"} role="status">
      {state.message}
    </p>
  );
}

/** Off-screen field bots fill in and people never see. */
function Honeypot() {
  return (
    <input type="text" name="website" tabIndex={-1} autoComplete="off" className="honeypot" aria-hidden="true" />
  );
}

export function SuggestTypeForm({ parents }: { parents: string[] }) {
  const [state, action, pending] = useActionState(suggestType, null);
  if (state?.ok) return <Status state={state} />;
  return (
    <form action={action} className="form">
      <Honeypot />
      <label>
        <span>New type</span>
        <input name="name" required minLength={3} maxLength={50} placeholder="e.g. Knitted body sculpture" />
      </label>
      <label>
        <span>Belongs under</span>
        <select name="parent" required defaultValue="">
          <option value="" disabled>
            Choose a standard type
          </option>
          {parents.map((p) => (
            <option key={p}>{p}</option>
          ))}
        </select>
      </label>
      <label className="wide">
        <span>What makes it its own type? (optional)</span>
        <input name="description" maxLength={255} />
      </label>
      <button type="submit" disabled={pending}>
        {pending ? "Sending…" : "Suggest type"}
      </button>
      <Status state={state} />
    </form>
  );
}

export function CommissionForm({ artist }: { artist: string }) {
  const [state, action, pending] = useActionState(requestCommission, null);
  if (state?.ok) return <Status state={state} />;
  return (
    <form action={action} className="form">
      <Honeypot />
      <input type="hidden" name="artist" value={artist} />
      <label>
        <span>Your name</span>
        <input name="name" required maxLength={200} autoComplete="name" />
      </label>
      <label>
        <span>Email</span>
        <input name="email" type="email" required maxLength={200} autoComplete="email" />
      </label>
      <label className="wide">
        <span>The piece you have in mind</span>
        <textarea name="description" required minLength={20} maxLength={1000} rows={4} />
      </label>
      <label>
        <span>Budget (EUR, optional)</span>
        <input name="budget" type="number" min={0} step={50} inputMode="numeric" />
      </label>
      <button type="submit" disabled={pending}>
        {pending ? "Sending…" : "Request a commission"}
      </button>
      <Status state={state} />
    </form>
  );
}
