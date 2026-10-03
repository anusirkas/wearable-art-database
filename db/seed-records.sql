-- Commissions, transactions, exhibitions and trust records for the demo studios.
-- Adapted from the original course project's example data (Lisa 2). Runs after seed-studios.sql.

INSERT INTO event (name, event_type, venue, city, starts_on, ends_on) VALUES
('Wearable Art Triennial', 'exhibition', 'Hall Nine', 'Copenhagen', '2025-06-01', '2025-06-30'),
('Haute Couture Night', 'fashion_show', 'Pier Seven', 'London', '2025-09-10', '2025-09-11'),
('Abstract Fabric Surfaces', 'exhibition', 'Atrium Twelve', 'Rotterdam', '2025-04-01', '2025-04-20');

INSERT INTO artwork_event (artwork_id, event_id, shown_from, shown_until)
SELECT a.id, e.id, e.starts_on, e.ends_on
FROM (VALUES
  ('cloud-rib-sweater', 'Wearable Art Triennial'),
  ('oxblood-cable-pullover', 'Wearable Art Triennial'),
  ('nocturne-gown', 'Haute Couture Night'),
  ('ink-rib-gown', 'Haute Couture Night'),
  ('spill-dress', 'Abstract Fabric Surfaces')
) AS v(slug, event_name)
JOIN artwork a ON a.slug = v.slug
JOIN event e ON e.name = v.event_name;

INSERT INTO collector (name, contact, country_code) VALUES
('Demo Museum Collection', 'collections@example.com', 'NL'),
('Private Collector X', 'collectorx@example.com', 'FI'),
('Slow Fashion Fund', 'hello@example.org', 'NL');

INSERT INTO commission (artist_id, collector_id, description, budget, status, submitted_on, deadline)
SELECT ar.id, c.id,
  'Custom piece: a one-of-a-kind knitted gala dress in luxury yarns.',
  5000, 'in_progress', '2025-06-01', '2025-08-01'
FROM artist ar, collector c
WHERE ar.slug = 'halcyon-knit-lab' AND c.name = 'Private Collector X';

INSERT INTO offer (commission_id, price, offered_on, status, due_on, terms)
SELECT id, 5200, '2025-06-03', 'accepted', '2025-07-25', 'Price includes materials and handwork; 30% deposit.'
FROM commission;

-- Deposit on the commission (no artwork yet), then a direct sale of an existing piece.
INSERT INTO transaction (artwork_id, commission_id, collector_id, transaction_type_id, occurred_on, amount, channel, note)
SELECT NULL, cm.id, cm.collector_id, tt.id, '2025-06-05', 1560.00, 'platform', '30% deposit to confirm the commission.'
FROM commission cm, transaction_type tt WHERE tt.name = 'Deposit';

INSERT INTO transaction (artwork_id, commission_id, collector_id, transaction_type_id, occurred_on, amount, channel, note)
SELECT a.id, NULL, c.id, tt.id, '2025-10-01', 3800.00, 'platform', 'Direct purchase of the Nocturne gown.'
FROM artwork a, collector c, transaction_type tt
WHERE a.slug = 'nocturne-gown' AND c.name = 'Private Collector X' AND tt.name = 'Sale';

INSERT INTO endorsement (artist_id, endorsement_type_id, endorsed_by, endorsed_on, description)
SELECT ar.id, et.id, v.endorsed_by, v.endorsed_on::date, v.description
FROM (VALUES
  ('halcyon-knit-lab', 'Education', 'Textile design programme', '2020-06-20', 'Studies in textile design.'),
  ('atelier-vantreur', 'Exhibition', 'Haute Couture Night', '2025-09-11', 'Shown at the "Haute Couture Night" runway show in London.'),
  ('brandt-and-mirelle', 'Curator', 'Independent jewellery curator', '2025-05-20', 'Curator endorsement for the Harbour series.')
) AS v(slug, type_name, endorsed_by, endorsed_on, description)
JOIN artist ar ON ar.slug = v.slug
JOIN endorsement_type et ON et.name = v.type_name;

INSERT INTO review (artist_id, artwork_id, collector_id, rating, comment, reviewed_on)
SELECT NULL, a.id, c.id, 5.0, 'Meticulous work and masterful technique; a truly unique piece.', '2025-06-20'
FROM artwork a, collector c WHERE a.slug = 'cloud-rib-sweater' AND c.name = 'Private Collector X';

INSERT INTO review (artist_id, artwork_id, collector_id, rating, comment, reviewed_on)
SELECT ar.id, NULL, c.id, 4.5, 'A strong concept and fearless use of colour.', '2025-04-25'
FROM artist ar, collector c WHERE ar.slug = 'ossery-studio' AND c.name = 'Demo Museum Collection';

INSERT INTO trust_score (artist_id, score, calculated_on, basis)
SELECT ar.id, v.score, v.calculated_on::date, v.basis
FROM (VALUES
  ('halcyon-knit-lab', 92.50, '2025-06-30', 'Based on endorsements (education) and collector reviews.'),
  ('atelier-vantreur', 78.00, '2025-10-05', 'Based on an exhibition endorsement and first reviews.'),
  ('brandt-and-mirelle', 85.00, '2025-06-01', 'Based on a curator endorsement.')
) AS v(slug, score, calculated_on, basis)
JOIN artist ar ON ar.slug = v.slug;

-- Artist-added types, now owned by the studios that use them.
UPDATE custom_artwork_type SET artist_id = (SELECT id FROM artist WHERE slug = 'halcyon-knit-lab') WHERE name = 'Knitted sculpture dress';
UPDATE custom_artwork_type SET artist_id = (SELECT id FROM artist WHERE slug = 'wrenfield-reclaim') WHERE name = 'Upcycled statement collar';
UPDATE artwork SET custom_artwork_type_id = (SELECT id FROM custom_artwork_type WHERE name = 'Upcycled statement collar') WHERE slug = 'salvaged-jewel-bib';

-- keep search in sync with every row above
REFRESH MATERIALIZED VIEW artwork_search;
