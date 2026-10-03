// Runs SQL files against DATABASE_URL: `node scripts/db.mjs db/schema.sql db/seed.sql`
import { Pool } from "@neondatabase/serverless";
import { existsSync, readFileSync } from "node:fs";

function databaseUrl() {
  if (process.env.DATABASE_URL) return process.env.DATABASE_URL;
  if (existsSync(".env.local")) {
    const match = readFileSync(".env.local", "utf8").match(/^DATABASE_URL=(.*)$/m);
    if (match) return match[1].trim().replace(/^["']|["']$/g, "");
  }
  throw new Error("DATABASE_URL is not set (add it to .env.local)");
}

const files = process.argv.slice(2);
if (files.length === 0) throw new Error("Usage: node scripts/db.mjs <file.sql>...");

const pool = new Pool({ connectionString: databaseUrl() });
const client = await pool.connect();
try {
  for (const file of files) {
    const started = Date.now();
    await client.query("BEGIN");
    await client.query(readFileSync(file, "utf8"));
    await client.query("COMMIT");
    console.log(`✓ ${file} (${Date.now() - started} ms)`);
  }
} catch (error) {
  await client.query("ROLLBACK");
  console.error(error.message, error.position ? `(at char ${error.position})` : "");
  process.exitCode = 1;
} finally {
  client.release();
  await pool.end();
}
