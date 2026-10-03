-- Studio data: the contemporary artists, commissions and trust records from the original
-- course project (Lisa 2), translated and corrected. Artists here are demo profiles.
-- Runs after seed-reference.sql.

INSERT INTO artist (slug, name, status, bio, creative_cv, country_code, membership_status, membership_from, is_demo) VALUES
('anu-sirkas', 'Anu Sirkas', 'verified',
 'Textile and fashion artist focused on rich knitted surfaces and a creative process you can follow from sketch to finished piece.',
 'Studies: textile design. Exhibitions: "A Transparent Story" (Tallinn), "Wearable Futures" (London). Projects: collaborations with sustainable fashion platforms.',
 'EE', 'active', '2023-09-01', true),
('mari-mets', 'Mari Mets', 'emerging',
 'Young fashion artist drawn to luxurious but ethical evening wear.',
 'Studies: fashion design, Aalto University. Shown at several runway shows and pop-up exhibitions.',
 'EE', 'active', '2024-01-15', true),
('anne-kivi', 'Anne Kivi', 'guest',
 'Textile artist working with abstract textile prints and hand-painted fabric.',
 'Studies: contemporary art and printmaking. Textile patterns shown in galleries and at runway shows in Western Europe.',
 'EE', NULL, NULL, true);

INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration)
SELECT v.slug, ar.id, t.id, v.title, v.date_label, v.year, v.size_label, v.description, v.inspiration
FROM (VALUES
  ('multi-technique-knitted-dress', 'anu-sirkas', 'Dress', 'Multi-technique knitted dress', '2024', 2024, 'M',
   'Hand-knitted dress combining jacquard patterns, lace knit, stockinette, rib and English rib. Voluminous and warm, yet with a graceful silhouette.',
   'Nordic weather, layering and the beauty of visible process.'),
  ('haute-couture-evening-gown', 'mari-mets', 'Evening dress', 'Haute couture evening gown', '2024', 2024, 'S',
   'Sculptural evening gown in silk and lace with beads, fringe and satin ribbon, made for extraordinary occasions.',
   'Red-carpet glamour, timeless elegance and the luxury of handwork.'),
  ('hand-painted-two-piece', 'anne-kivi', 'Ensemble', 'Hand-painted two-piece', '2024', 2024, 'M',
   'An abstract composition painted onto cotton with textile paints, then sewn into a blouse and skirt. The colours bleed into each other like paint on canvas.',
   'Abstract painting, colour flow and movement across the fabric.')
) AS v(slug, artist_slug, type_name, title, date_label, year, size_label, description, inspiration)
JOIN artist ar ON ar.slug = v.artist_slug
JOIN artwork_type t ON t.name = v.type_name;

INSERT INTO artwork_material (artwork_id, material_id, quantity)
SELECT a.id, m.id, v.quantity
FROM (VALUES
  ('multi-technique-knitted-dress', 'Merino wool', '900 g'),
  ('multi-technique-knitted-dress', 'Mohair', '600 g'),
  ('multi-technique-knitted-dress', 'Cashmere', '500 g'),
  ('haute-couture-evening-gown', 'Silk', '5 m (about 600 g)'),
  ('haute-couture-evening-gown', 'Lace', '2 m (about 200 g)'),
  ('haute-couture-evening-gown', 'Glass beads', '200 g'),
  ('haute-couture-evening-gown', 'Satin ribbon', '10 m'),
  ('hand-painted-two-piece', 'Organic cotton', '6 m (about 600 g)'),
  ('hand-painted-two-piece', 'Textile paint', 'several layers (about 100 g)')
) AS v(slug, material, quantity)
JOIN artwork a ON a.slug = v.slug
JOIN material m ON m.name = v.material;

INSERT INTO artwork_technique (artwork_id, technique_id, step_order)
SELECT a.id, t.id, v.step_order
FROM (VALUES
  ('multi-technique-knitted-dress', 'Jacquard knitting', 1),
  ('multi-technique-knitted-dress', 'Lace knitting', 2),
  ('multi-technique-knitted-dress', 'Stockinette', 3),
  ('multi-technique-knitted-dress', 'Rib knitting', 4),
  ('multi-technique-knitted-dress', 'English rib', 5),
  ('haute-couture-evening-gown', 'Sewing', 1),
  ('haute-couture-evening-gown', 'Beadwork', 2),
  ('hand-painted-two-piece', 'Textile painting', 1),
  ('hand-painted-two-piece', 'Sewing', 2)
) AS v(slug, technique, step_order)
JOIN artwork a ON a.slug = v.slug
JOIN technique t ON t.name = v.technique;

INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours, notes)
SELECT a.id, v.name, v.started_on::date, v.finished_on::date, v.hours, v.notes
FROM (VALUES
  ('multi-technique-knitted-dress', 'Idea and sketches', '2024-01-10', '2024-01-15', 15.0, 'Sketches, colour palette and technical solutions.'),
  ('multi-technique-knitted-dress', 'Swatches and pattern tests', '2024-01-16', '2024-01-20', 20.0, 'Pattern tests with different yarns.'),
  ('multi-technique-knitted-dress', 'Knitting and finishing', '2024-01-21', '2024-02-10', 85.0, 'Knitting the body and finishing.'),
  ('haute-couture-evening-gown', 'Pattern and construction', '2024-03-01', '2024-03-10', 25.0, 'Searching for the silhouette.'),
  ('haute-couture-evening-gown', 'Materials and toile', '2024-03-11', '2024-03-20', 30.0, 'Test garment.'),
  ('haute-couture-evening-gown', 'Final sewing and details', '2024-03-21', '2024-04-15', 90.0, 'Beads and details by hand.'),
  ('hand-painted-two-piece', 'Composition sketch', '2023-12-01', '2023-12-05', 10.0, 'Composition and colour palette.'),
  ('hand-painted-two-piece', 'Painting the fabric', '2023-12-06', '2023-12-20', 35.0, 'Layered painting with textile paints.'),
  ('hand-painted-two-piece', 'Sewing', '2023-12-21', '2024-01-05', 30.0, 'Constructing the two-piece.')
) AS v(slug, name, started_on, finished_on, hours, notes)
JOIN artwork a ON a.slug = v.slug;

INSERT INTO event (name, event_type, venue, city, starts_on, ends_on) VALUES
('Wearable Art Triennial', 'exhibition', 'Art Museum of Estonia', 'Tallinn', '2024-06-01', '2024-06-30'),
('Haute Couture Night', 'fashion_show', 'Covent Garden', 'London', '2024-09-10', '2024-09-11'),
('Abstract Fabric Surfaces', 'exhibition', 'Centre for Contemporary Arts', 'Tallinn', '2024-04-01', '2024-04-20');

INSERT INTO artwork_event (artwork_id, event_id, shown_from, shown_until)
SELECT a.id, e.id, e.starts_on, e.ends_on
FROM (VALUES
  ('multi-technique-knitted-dress', 'Wearable Art Triennial'),
  ('haute-couture-evening-gown', 'Haute Couture Night'),
  ('hand-painted-two-piece', 'Abstract Fabric Surfaces')
) AS v(slug, event_name)
JOIN artwork a ON a.slug = v.slug
JOIN event e ON e.name = v.event_name;

INSERT INTO collector (name, contact, country_code) VALUES
('Demo Museum Collection', 'collections@example.com', 'EE'),
('Private Collector X', 'collectorx@example.com', 'FI'),
('Slow Fashion Fund', 'hello@example.org', 'NL');

INSERT INTO commission (artist_id, collector_id, description, budget, status, submitted_on, deadline)
SELECT ar.id, c.id,
  'Custom piece: a one-of-a-kind knitted gala dress in luxury yarns.',
  5000, 'in_progress', '2024-06-01', '2024-08-01'
FROM artist ar, collector c
WHERE ar.slug = 'anu-sirkas' AND c.name = 'Private Collector X';

INSERT INTO offer (commission_id, price, offered_on, status, due_on, terms)
SELECT id, 5200, '2024-06-03', 'accepted', '2024-07-25', 'Price includes materials and handwork; 30% deposit.'
FROM commission;

-- Deposit on the commission (no artwork yet), then a direct sale of an existing piece.
INSERT INTO transaction (artwork_id, commission_id, collector_id, transaction_type_id, occurred_on, amount, channel, note)
SELECT NULL, cm.id, cm.collector_id, tt.id, '2024-06-05', 1560.00, 'platform', '30% deposit to confirm the commission.'
FROM commission cm, transaction_type tt WHERE tt.name = 'Deposit';

INSERT INTO transaction (artwork_id, commission_id, collector_id, transaction_type_id, occurred_on, amount, channel, note)
SELECT a.id, NULL, c.id, tt.id, '2024-10-01', 3800.00, 'platform', 'Direct purchase of the evening gown.'
FROM artwork a, collector c, transaction_type tt
WHERE a.slug = 'haute-couture-evening-gown' AND c.name = 'Private Collector X' AND tt.name = 'Sale';

INSERT INTO endorsement (artist_id, endorsement_type_id, endorsed_by, endorsed_on, description)
SELECT ar.id, et.id, v.endorsed_by, v.endorsed_on::date, v.description
FROM (VALUES
  ('anu-sirkas', 'Education', 'Textile design programme', '2020-06-20', 'Studies in textile design.'),
  ('mari-mets', 'Exhibition', 'Haute Couture Night', '2024-09-11', 'Shown at the "Haute Couture Night" runway show in London.')
) AS v(slug, type_name, endorsed_by, endorsed_on, description)
JOIN artist ar ON ar.slug = v.slug
JOIN endorsement_type et ON et.name = v.type_name;

INSERT INTO review (artist_id, artwork_id, collector_id, rating, comment, reviewed_on)
SELECT NULL, a.id, c.id, 5.0, 'Meticulous work and masterful technique; a truly unique piece.', '2024-06-20'
FROM artwork a, collector c WHERE a.slug = 'multi-technique-knitted-dress' AND c.name = 'Private Collector X';

INSERT INTO review (artist_id, artwork_id, collector_id, rating, comment, reviewed_on)
SELECT ar.id, NULL, c.id, 4.5, 'A strong concept and fearless use of colour.', '2024-04-25'
FROM artist ar, collector c WHERE ar.slug = 'anne-kivi' AND c.name = 'Demo Museum Collection';

INSERT INTO trust_score (artist_id, score, calculated_on, basis)
SELECT ar.id, v.score, v.calculated_on::date, v.basis
FROM (VALUES
  ('anu-sirkas', 92.50, '2024-06-30', 'Based on endorsements (education) and collector reviews.'),
  ('mari-mets', 78.00, '2024-10-05', 'Based on an exhibition endorsement and first reviews.')
) AS v(slug, score, calculated_on, basis)
JOIN artist ar ON ar.slug = v.slug;

-- keep search in sync with the rows above
REFRESH MATERIALIZED VIEW artwork_search;
