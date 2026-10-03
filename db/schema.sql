-- Wearable Art Archive: PostgreSQL schema.
-- Ported from the Oracle course project (TalTech ICA0005, 21 entities); see README for the
-- Estonian → English name map. Re-runnable: drops and recreates everything.

DROP MATERIALIZED VIEW IF EXISTS artwork_search;
DROP TABLE IF EXISTS
  submission, trust_score, review, endorsement, endorsement_type, transaction, transaction_type,
  offer, commission, artwork_event, event, media, creation_stage, artwork_technique,
  artwork_material, artwork, technique, material, custom_artwork_type, artwork_type,
  collector, artist
  CASCADE;
DROP FUNCTION IF EXISTS f_unaccent(text);

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;

-- unaccent() is only STABLE, which indexes don't accept; this wrapper pins the dictionary.
CREATE FUNCTION f_unaccent(text) RETURNS text
  LANGUAGE sql IMMUTABLE PARALLEL SAFE STRICT
  AS $$ SELECT public.unaccent('public.unaccent'::regdictionary, $1) $$;

------------------------------------------------------------
-- People
------------------------------------------------------------
CREATE TABLE artist (                                   -- KUNSTNIK
  id                integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  slug              text NOT NULL UNIQUE,
  name              varchar(200) NOT NULL,
  status            varchar(20) NOT NULL DEFAULT 'emerging'
                      CHECK (status IN ('verified', 'emerging', 'guest', 'archive')),
  bio               varchar(1000),
  creative_cv       varchar(4000),
  life_dates        varchar(100),                       -- e.g. "French, 1890–1973"; archive makers only
  country_code      char(2),                            -- ISO 3166-1 alpha-2
  created_at        timestamptz NOT NULL DEFAULT now(),
  membership_status varchar(20) CHECK (membership_status IN ('active', 'paused')),
  membership_from   date,
  membership_until  date,
  is_demo           boolean NOT NULL DEFAULT false,
  CHECK (membership_until IS NULL OR membership_from IS NULL OR membership_until >= membership_from)
);

CREATE TABLE collector (                                -- KOLLEKTSIONAAR
  id           integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name         varchar(200) NOT NULL,
  contact      varchar(200),
  country_code char(2)
);

------------------------------------------------------------
-- Classification
------------------------------------------------------------
CREATE TABLE artwork_type (                             -- TEOSE_TYYP
  id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        varchar(50) NOT NULL UNIQUE,
  category    varchar(20) NOT NULL
                CHECK (category IN ('garment', 'jewellery', 'headwear', 'accessory', 'footwear')),
  description varchar(255)
);

-- Types artists add themselves, always hanging off a standard type so filters keep working.
CREATE TABLE custom_artwork_type (                      -- UUS_TEOSE_TYYP
  id              integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artwork_type_id integer NOT NULL REFERENCES artwork_type (id),
  artist_id       integer REFERENCES artist (id) ON DELETE SET NULL,
  name            varchar(50) NOT NULL,
  description     varchar(255),
  UNIQUE (artwork_type_id, name)
);

CREATE TABLE material (                                 -- MATERJAL
  id             integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name           varchar(200) NOT NULL UNIQUE,
  category       varchar(30) NOT NULL
                   CHECK (category IN ('fibre', 'fabric', 'metal', 'stone', 'bead', 'dye', 'trim', 'other')),
  origin         varchar(200),
  is_sustainable boolean,                               -- NULL = unknown
  notes          varchar(500)
);

CREATE TABLE technique (                                -- TEHNIKA
  id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        varchar(200) NOT NULL UNIQUE,
  description varchar(1000)
);

------------------------------------------------------------
-- Artworks
------------------------------------------------------------
CREATE TABLE artwork (                                  -- TEOS
  id                     integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  slug                   text NOT NULL UNIQUE,
  artist_id              integer NOT NULL REFERENCES artist (id),
  artwork_type_id        integer NOT NULL REFERENCES artwork_type (id),
  custom_artwork_type_id integer REFERENCES custom_artwork_type (id),
  title                  varchar(200) NOT NULL,
  date_label             varchar(50),                   -- "ca. 1925", "2024"
  year                   integer,                       -- sortable year
  description            varchar(2000),
  inspiration            varchar(1000),
  size_label             varchar(10),                   -- S / M / L for garments
  length_cm              numeric(6,2) CHECK (length_cm > 0),
  width_cm               numeric(6,2) CHECK (width_cm > 0),
  height_cm              numeric(6,2) CHECK (height_cm > 0),
  culture                varchar(100),
  source_name            varchar(100),                  -- e.g. "The Metropolitan Museum of Art"
  source_url             varchar(500),
  credit_line            varchar(500),
  created_at             timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON artwork (artist_id);
CREATE INDEX ON artwork (artwork_type_id);

-- One artwork, many materials. The course version had both a surrogate id and a composite PK;
-- the pair itself is the key.
CREATE TABLE artwork_material (                         -- TEOSE_MATERJAL
  artwork_id  integer NOT NULL REFERENCES artwork (id) ON DELETE CASCADE,
  material_id integer NOT NULL REFERENCES material (id),
  quantity    varchar(100),                             -- "900 g", "5 m"
  PRIMARY KEY (artwork_id, material_id)
);
CREATE INDEX ON artwork_material (material_id);

CREATE TABLE artwork_technique (                        -- TEOSE_TEHNIKA
  artwork_id   integer NOT NULL REFERENCES artwork (id) ON DELETE CASCADE,
  technique_id integer NOT NULL REFERENCES technique (id),
  step_order   integer,
  PRIMARY KEY (artwork_id, technique_id)
);
CREATE INDEX ON artwork_technique (technique_id);

CREATE TABLE creation_stage (                           -- LOOMISE_ETAPP
  id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artwork_id  integer NOT NULL REFERENCES artwork (id) ON DELETE CASCADE,
  name        varchar(200) NOT NULL,
  started_on  date,
  finished_on date,
  hours       numeric(6,2) CHECK (hours >= 0),
  notes       varchar(1000),
  CHECK (finished_on IS NULL OR started_on IS NULL OR finished_on >= started_on)
);
CREATE INDEX ON creation_stage (artwork_id);

CREATE TABLE media (                                    -- MEEDIA
  id         integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artwork_id integer NOT NULL REFERENCES artwork (id) ON DELETE CASCADE,
  file_url   varchar(1000) NOT NULL,
  media_type varchar(10) NOT NULL DEFAULT 'photo' CHECK (media_type IN ('photo', 'detail', 'video')),
  caption    varchar(500),
  credit     varchar(500),
  license    varchar(50),
  width      integer,
  height     integer,
  sort_order integer NOT NULL DEFAULT 0,
  added_on   date NOT NULL DEFAULT current_date
);
CREATE INDEX ON media (artwork_id, sort_order);

------------------------------------------------------------
-- Exhibitions
------------------------------------------------------------
CREATE TABLE event (                                    -- SUNDMUS
  id         integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name       varchar(200) NOT NULL,
  event_type varchar(20) NOT NULL CHECK (event_type IN ('exhibition', 'gallery', 'fashion_show')),
  venue      varchar(200),
  city       varchar(100),
  starts_on  date,
  ends_on    date,
  CHECK (ends_on IS NULL OR starts_on IS NULL OR ends_on >= starts_on)
);

CREATE TABLE artwork_event (                            -- TEOSE_SUNDMUS
  artwork_id   integer NOT NULL REFERENCES artwork (id) ON DELETE CASCADE,
  event_id     integer NOT NULL REFERENCES event (id) ON DELETE CASCADE,
  shown_from   date,
  shown_until  date,
  PRIMARY KEY (artwork_id, event_id)
);

------------------------------------------------------------
-- Commissions and transactions (ownership is traced through these)
------------------------------------------------------------
CREATE TABLE commission (                               -- TELLIMUS
  id           integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artist_id    integer NOT NULL REFERENCES artist (id),
  collector_id integer NOT NULL REFERENCES collector (id),
  description  varchar(1000),
  budget       numeric(10,2) CHECK (budget >= 0),
  currency     char(3) NOT NULL DEFAULT 'EUR',
  status       varchar(20) NOT NULL DEFAULT 'new'
                 CHECK (status IN ('new', 'in_progress', 'completed', 'cancelled')),
  submitted_on date NOT NULL DEFAULT current_date,
  deadline     date
);

CREATE TABLE offer (                                    -- PAKKUMINE
  id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  commission_id integer NOT NULL REFERENCES commission (id) ON DELETE CASCADE,
  price         numeric(10,2) CHECK (price >= 0),
  currency      char(3) NOT NULL DEFAULT 'EUR',
  offered_on    date NOT NULL DEFAULT current_date,
  status        varchar(20) NOT NULL DEFAULT 'submitted'
                  CHECK (status IN ('submitted', 'accepted', 'declined')),
  due_on        date,
  delivered_on  date,
  terms         varchar(1000)
);

CREATE TABLE transaction_type (                         -- TEHINGU_TYYP
  id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        varchar(50) NOT NULL UNIQUE,
  description varchar(255)
);

CREATE TABLE transaction (                              -- TEHING
  id                  integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artwork_id          integer REFERENCES artwork (id),
  commission_id       integer REFERENCES commission (id),
  collector_id        integer NOT NULL REFERENCES collector (id),
  transaction_type_id integer NOT NULL REFERENCES transaction_type (id),
  occurred_on         date NOT NULL,
  amount              numeric(10,2) NOT NULL CHECK (amount >= 0),
  currency            char(3) NOT NULL DEFAULT 'EUR',
  channel             varchar(10) NOT NULL CHECK (channel IN ('platform', 'external')),
  note                varchar(500),
  -- a deposit may precede the artwork existing, but a transaction is always about something
  CHECK (artwork_id IS NOT NULL OR commission_id IS NOT NULL)
);

------------------------------------------------------------
-- Trust
------------------------------------------------------------
CREATE TABLE endorsement_type (                         -- KINNITUSE_TYYP
  id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        varchar(50) NOT NULL UNIQUE,
  description varchar(255)
);

CREATE TABLE endorsement (                              -- KINNITUS
  id                  integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artist_id           integer NOT NULL REFERENCES artist (id) ON DELETE CASCADE,
  endorsement_type_id integer NOT NULL REFERENCES endorsement_type (id),
  endorsed_by         varchar(200),
  endorsed_on         date,
  description         varchar(1000)
);

-- A review is about an artist or an artwork, never both (the course version required both).
CREATE TABLE review (                                   -- HINNANG
  id           integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artist_id    integer REFERENCES artist (id) ON DELETE CASCADE,
  artwork_id   integer REFERENCES artwork (id) ON DELETE CASCADE,
  collector_id integer REFERENCES collector (id),
  rating       numeric(2,1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment      varchar(1000),
  reviewed_on  date NOT NULL DEFAULT current_date,
  CHECK ((artist_id IS NULL) <> (artwork_id IS NULL))
);

CREATE TABLE trust_score (                              -- USALDUSSKOOR
  id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  artist_id     integer NOT NULL REFERENCES artist (id) ON DELETE CASCADE,
  score         numeric(5,2) NOT NULL CHECK (score BETWEEN 0 AND 100),
  calculated_on date NOT NULL DEFAULT current_date,
  basis         varchar(1000)
);

------------------------------------------------------------
-- Public suggestions: never shown on the site until reviewed
------------------------------------------------------------
CREATE TABLE submission (
  id         integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  kind       varchar(20) NOT NULL CHECK (kind IN ('artwork_type', 'artist', 'commission')),
  payload    jsonb NOT NULL,
  status     varchar(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  ip_hash    text,
  created_at timestamptz NOT NULL DEFAULT now()
);

------------------------------------------------------------
-- Search: one row per artwork with everything a visitor might type
------------------------------------------------------------
CREATE MATERIALIZED VIEW artwork_search AS
SELECT
  a.id AS artwork_id,
  f_unaccent(lower(concat_ws(' ',
    a.title, ar.name, t.name, ct.name, a.culture, a.date_label,
    string_agg(DISTINCT m.name, ' '), string_agg(DISTINCT te.name, ' ')
  ))) AS words,
  setweight(to_tsvector('simple', f_unaccent(coalesce(a.title, ''))), 'A') ||
  setweight(to_tsvector('simple', f_unaccent(concat_ws(' ', ar.name, t.name, ct.name))), 'A') ||
  setweight(to_tsvector('simple', f_unaccent(concat_ws(' ',
    string_agg(DISTINCT m.name, ' '), string_agg(DISTINCT te.name, ' '), a.culture))), 'B') ||
  setweight(to_tsvector('english', f_unaccent(concat_ws(' ', a.description, a.inspiration))), 'C') AS document
FROM artwork a
JOIN artist ar ON ar.id = a.artist_id
JOIN artwork_type t ON t.id = a.artwork_type_id
LEFT JOIN custom_artwork_type ct ON ct.id = a.custom_artwork_type_id
LEFT JOIN artwork_material am ON am.artwork_id = a.id
LEFT JOIN material m ON m.id = am.material_id
LEFT JOIN artwork_technique at ON at.artwork_id = a.id
LEFT JOIN technique te ON te.id = at.technique_id
GROUP BY a.id, ar.name, t.name, ct.name;

CREATE UNIQUE INDEX ON artwork_search (artwork_id);
CREATE INDEX ON artwork_search USING gin (document);
CREATE INDEX ON artwork_search USING gin (words gin_trgm_ops);
