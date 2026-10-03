-- Demo studios: fictional names, illustrative Unsplash photos (photographer credited).

INSERT INTO material (name, category, is_sustainable) VALUES ('Organza', 'fabric', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Tulle', 'fabric', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Mylar', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Polyamide', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Acrylic', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Horsehair', 'fibre', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Polyester', 'fabric', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Fibreglass-reinforced plastic', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Plastic', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Metal', 'metal', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Plastic sheeting', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Calico', 'fabric', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Wood', 'other', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('LEDs', 'other', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Crystals', 'bead', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Rayon', 'fabric', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Aluminium', 'metal', NULL) ON CONFLICT (name) DO NOTHING;
INSERT INTO material (name, category, is_sustainable) VALUES ('Nylon', 'fabric', false) ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Heat bonding', 'Fusing synthetic layers with heat instead of stitching.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Laser cutting', 'Cutting fabric, leather or film with a laser for precise, sealed edges.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('3D printing', 'Building forms layer by layer from a digital model.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Upcycling', 'Remaking discarded or surplus material into something of higher value.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Jacquard weaving', 'Weaving complex patterns with each warp thread lifted individually.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Moulding', 'Shaping a rigid material over or inside a form.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Textile printing', 'Printing pattern or image onto cloth.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Woodworking', 'Shaping wood by hand and machine.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Electronics', 'Building light, sound or motion into a garment.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Smocking', 'Gathering fabric into decorative, elastic folds with stitching.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Assembly without sewing', 'Joining many small parts with rings, rivets or interlocking cuts instead of seams.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Pattern cutting', 'Drafting the flat pattern pieces a garment is cut from.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Hand dyeing', 'Colouring yarn or cloth by hand in small batches.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Cable knitting', 'Crossing stitches to form raised, rope-like cables.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Hand knotting', 'Knotting between each bead or pearl so they never rub.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Coating', 'Covering cloth in a flexible finish such as metallic or wax.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Wirework', 'Bending and joining wire into structure.') ON CONFLICT (name) DO NOTHING;
INSERT INTO technique (name, description) VALUES ('Gilding', 'Applying gold leaf to a surface.') ON CONFLICT (name) DO NOTHING;

INSERT INTO artist (slug, name, status, bio, creative_cv, country_code, membership_status, membership_from, is_demo) VALUES
('atelier-vantreur', 'Atelier Vantreur', 'verified', 'Sculptural eveningwear cut by hand in small numbers. Every gown starts as a paper toile and ends with a record of the hours it took.', 'Shown at Haute Couture Night (London) and Wearable Futures (Copenhagen). Works with two French mills on deadstock silk.', 'FR', 'active', '2023-09-01', true),
('halcyon-knit-lab', 'Halcyon Knit Lab', 'verified', 'A knitwear studio that hand-knits everything in traceable wool and publishes the yarn, the swatches and the hours for each piece.', 'Textile design studies in Copenhagen and Glasgow. Shown at the Wearable Art Triennial. Member since 2023.', 'DK', 'active', '2023-09-01', true),
('brandt-and-mirelle', 'Brandt & Mirelle', 'verified', 'Jewellery studio working in recycled silver and gold, with stones bought one by one from named dealers.', 'Goldsmithing training in Amsterdam and Florence. Curator endorsement for the Harbour series.', 'NL', 'active', '2023-09-01', true),
('ossery-studio', 'Ossery Studio', 'emerging', 'A young London studio painting, coating and fringing garments by hand. Loud colour, slow work.', 'Graduated in fashion and printed textiles in 2023. First solo show: Abstract Fabric Surfaces, Rotterdam.', 'GB', 'active', '2023-09-01', true),
('maison-quellane', 'Maison Quellane', 'emerging', 'Millinery and headpieces, blocked by hand on wooden forms. Somewhere between a hat and a small sculpture.', 'Trained in traditional millinery in Brussels. Headpieces for stage and runway.', 'BE', 'active', '2023-09-01', true),
('wrenfield-reclaim', 'Wrenfield Reclaim', 'guest', 'Statement jewellery made only from reclaimed beads, chains and stones, each traced back to where it was found.', 'Guest studio. Works with estate sales and vintage dealers.', 'US', NULL, NULL, true);

-- Nocturne gown (Atelier Vantreur)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'nocturne-gown', ar.id, t.id, 'Nocturne gown', '2025', 2025, 'S', 'Black silk faille gown with batwing sleeves that fall into a pooled train. Cut from a single length of deadstock silk.', 'Night swimming, and the way dark water closes behind you.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'atelier-vantreur' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '7 m silk faille' FROM artwork a, material m WHERE a.slug = 'nocturne-gown' AND m.name = 'Deadstock fabric';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'lining, 4 m' FROM artwork a, material m WHERE a.slug = 'nocturne-gown' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'nocturne-gown' AND t.name = 'Pattern cutting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'nocturne-gown' AND t.name = 'Sewing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Toile and fittings', '2025-01-06', '2025-01-24', 38 FROM artwork WHERE slug = 'nocturne-gown';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Cutting the silk', '2025-01-27', '2025-01-28', 9 FROM artwork WHERE slug = 'nocturne-gown';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Construction and hand finishing', '2025-01-29', '2025-03-07', 112 FROM artwork WHERE slug = 'nocturne-gown';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/nocturne-gown-1.webp', 'photo', 'Illustrative photo for Nocturne gown', 'Photo: Michael Kyule on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'nocturne-gown';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/nocturne-gown-2.webp', 'detail', 'Illustrative photo for Nocturne gown', 'Photo: Michael Kyule on Unsplash', 'Unsplash License', 1167, 1750, 1 FROM artwork WHERE slug = 'nocturne-gown';

-- Folded paper bustier (Atelier Vantreur)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'folded-paper-bustier', ar.id, t.id, 'Folded paper bustier', '2024', 2024, 'M', 'Ivory cotton-silk bustier dress with origami folds that are set by hand and stitched invisibly from inside.', 'Folded letters, never sent.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'atelier-vantreur' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '3 m cotton-silk' FROM artwork a, material m WHERE a.slug = 'folded-paper-bustier' AND m.name = 'Organic cotton';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '2 m organza' FROM artwork a, material m WHERE a.slug = 'folded-paper-bustier' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'folded-paper-bustier' AND t.name = 'Pleating';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'folded-paper-bustier' AND t.name = 'Sewing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Folding studies', '2024-05-02', '2024-05-16', 26 FROM artwork WHERE slug = 'folded-paper-bustier';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Construction', '2024-05-17', '2024-06-21', 74 FROM artwork WHERE slug = 'folded-paper-bustier';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/folded-paper-bustier-1.webp', 'photo', 'Illustrative photo for Folded paper bustier', 'Photo: Lute on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'folded-paper-bustier';

-- Ink rib gown (Atelier Vantreur)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'ink-rib-gown', ar.id, t.id, 'Ink rib gown', '2025', 2025, 'M', 'Iridescent ribbed bodice in hand-dyed taffeta over a tulle underskirt, finished with a sheer standing collar.', 'The ribs of an umbrella turned inside out by the wind.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'atelier-vantreur' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'taffeta, 5 m' FROM artwork a, material m WHERE a.slug = 'ink-rib-gown' AND m.name = 'Silk';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '8 m' FROM artwork a, material m WHERE a.slug = 'ink-rib-gown' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'ink-rib-gown' AND t.name = 'Hand dyeing';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'ink-rib-gown' AND t.name = 'Sewing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Dye tests', '2025-04-01', '2025-04-09', 14 FROM artwork WHERE slug = 'ink-rib-gown';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Rib construction', '2025-04-10', '2025-05-15', 96 FROM artwork WHERE slug = 'ink-rib-gown';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/ink-rib-gown-1.webp', 'photo', 'Illustrative photo for Ink rib gown', 'Photo: Ivan Vranić on Unsplash', 'Unsplash License', 1168, 1750, 0 FROM artwork WHERE slug = 'ink-rib-gown';

-- Cloud rib sweater (Halcyon Knit Lab)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'cloud-rib-sweater', ar.id, t.id, 'Cloud rib sweater', '2025', 2025, 'M', 'Oversized hand-knitted rib sweater in undyed merino, long enough in the sleeve to swallow your hands.', 'Fog on the Øresund in February.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'halcyon-knit-lab' AND t.name = 'Jacket';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '900 g, undyed' FROM artwork a, material m WHERE a.slug = 'cloud-rib-sweater' AND m.name = 'Merino wool';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'cloud-rib-sweater' AND t.name = 'Rib knitting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'cloud-rib-sweater' AND t.name = 'English rib';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Swatching', '2025-01-08', '2025-01-12', 8 FROM artwork WHERE slug = 'cloud-rib-sweater';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Knitting', '2025-01-13', '2025-02-20', 64 FROM artwork WHERE slug = 'cloud-rib-sweater';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Blocking and seaming', '2025-02-21', '2025-02-25', 6 FROM artwork WHERE slug = 'cloud-rib-sweater';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/cloud-rib-sweater-1.webp', 'photo', 'Illustrative photo for Cloud rib sweater', 'Photo: Valna Studio on Unsplash', 'Unsplash License', 1400, 1750, 0 FROM artwork WHERE slug = 'cloud-rib-sweater';

-- Oxblood cable pullover (Halcyon Knit Lab)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'oxblood-cable-pullover', ar.id, t.id, 'Oxblood cable pullover', '2024', 2024, 'L', 'Dense cable knit in plant-dyed wool, with cables that run unbroken from hem to collar.', 'Old fishermen''s ganseys, slowed down.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'halcyon-knit-lab' AND t.name = 'Jacket';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '1.1 kg, madder-dyed' FROM artwork a, material m WHERE a.slug = 'oxblood-cable-pullover' AND m.name = 'Wool';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '200 g' FROM artwork a, material m WHERE a.slug = 'oxblood-cable-pullover' AND m.name = 'Mohair';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'oxblood-cable-pullover' AND t.name = 'Cable knitting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'oxblood-cable-pullover' AND t.name = 'Hand dyeing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Dyeing the yarn', '2024-09-02', '2024-09-06', 12 FROM artwork WHERE slug = 'oxblood-cable-pullover';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Knitting', '2024-09-09', '2024-11-01', 88 FROM artwork WHERE slug = 'oxblood-cable-pullover';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/oxblood-cable-pullover-1.webp', 'photo', 'Illustrative photo for Oxblood cable pullover', 'Photo: Zoe on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'oxblood-cable-pullover';

-- Moss lace cardigan (in progress) (Halcyon Knit Lab)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'moss-lace-cardigan', ar.id, t.id, 'Moss lace cardigan (in progress)', '2026', 2026, 'M', 'Still on the needles: an openwork lace cardigan in moss-green wool. The archive records it while it is being made.', 'Lichen on granite.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'halcyon-knit-lab' AND t.name = 'Jacket';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'about 600 g so far' FROM artwork a, material m WHERE a.slug = 'moss-lace-cardigan' AND m.name = 'Wool';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'moss-lace-cardigan' AND t.name = 'Lace knitting';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Knitting the back and fronts', '2026-08-01', NULL, 41 FROM artwork WHERE slug = 'moss-lace-cardigan';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/moss-lace-cardigan-1.webp', 'photo', 'Illustrative photo for Moss lace cardigan (in progress)', 'Photo: Giulia Bertelli on Unsplash', 'Unsplash License', 1313, 1750, 0 FROM artwork WHERE slug = 'moss-lace-cardigan';

-- Emerald cascade choker (Brandt & Mirelle)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'emerald-cascade-choker', ar.id, t.id, 'Emerald cascade choker', '2025', 2025, NULL, 'Seventeen strands of seed pearls gathered into a cushion-cut emerald centre, edged with old-cut diamonds.', 'A Mughal choker seen in a museum, rebuilt from memory.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'brandt-and-mirelle' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'seed pearls, 17 strands' FROM artwork a, material m WHERE a.slug = 'emerald-cascade-choker' AND m.name = 'Pearls';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'emerald centre stone' FROM artwork a, material m WHERE a.slug = 'emerald-cascade-choker' AND m.name = 'Gemstones';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'old-cut, reused' FROM artwork a, material m WHERE a.slug = 'emerald-cascade-choker' AND m.name = 'Diamonds';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'setting' FROM artwork a, material m WHERE a.slug = 'emerald-cascade-choker' AND m.name = 'Recycled silver';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'emerald-cascade-choker' AND t.name = 'Stone setting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'emerald-cascade-choker' AND t.name = 'Goldsmithing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Design and stone sourcing', '2025-02-03', '2025-03-14', 22 FROM artwork WHERE slug = 'emerald-cascade-choker';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Setting and stringing', '2025-03-17', '2025-05-02', 140 FROM artwork WHERE slug = 'emerald-cascade-choker';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/emerald-cascade-choker-1.webp', 'photo', 'Illustrative photo for Emerald cascade choker', 'Photo: Shubhi Verma on Unsplash', 'Unsplash License', 1400, 1750, 0 FROM artwork WHERE slug = 'emerald-cascade-choker';

-- Baroque pearl rope (Brandt & Mirelle)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'baroque-pearl-rope', ar.id, t.id, 'Baroque pearl rope', '2024', 2024, NULL, 'Irregular baroque pearls knotted on silk, each knot tied by hand so no two pearls touch.', 'Pearls that refuse to be round.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'brandt-and-mirelle' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '41 baroque pearls' FROM artwork a, material m WHERE a.slug = 'baroque-pearl-rope' AND m.name = 'Pearls';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'knotting thread' FROM artwork a, material m WHERE a.slug = 'baroque-pearl-rope' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'baroque-pearl-rope' AND t.name = 'Hand knotting';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Grading the pearls', '2024-10-01', '2024-10-03', 6 FROM artwork WHERE slug = 'baroque-pearl-rope';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Knotting', '2024-10-04', '2024-10-09', 14 FROM artwork WHERE slug = 'baroque-pearl-rope';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/baroque-pearl-rope-1.webp', 'photo', 'Illustrative photo for Baroque pearl rope', 'Photo: Rosemary Media on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'baroque-pearl-rope';

-- Harbour bead necklace (Brandt & Mirelle)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'harbour-bead-necklace', ar.id, t.id, 'Harbour bead necklace', '2025', 2025, NULL, 'Glass beads in harbour blues with a gold-plated clasp shaped like a mooring hook.', 'Rotterdam harbour at dusk.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'brandt-and-mirelle' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'Murano glass, 118 beads' FROM artwork a, material m WHERE a.slug = 'harbour-bead-necklace' AND m.name = 'Glass beads';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'recycled, plated clasp' FROM artwork a, material m WHERE a.slug = 'harbour-bead-necklace' AND m.name = 'Gold';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'harbour-bead-necklace' AND t.name = 'Beadwork';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'harbour-bead-necklace' AND t.name = 'Goldsmithing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Clasp carving', '2025-06-02', '2025-06-10', 18 FROM artwork WHERE slug = 'harbour-bead-necklace';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Stringing', '2025-06-11', '2025-06-13', 7 FROM artwork WHERE slug = 'harbour-bead-necklace';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/harbour-bead-necklace-1.webp', 'photo', 'Illustrative photo for Harbour bead necklace', 'Photo: César O''neill on Unsplash', 'Unsplash License', 1154, 1750, 0 FROM artwork WHERE slug = 'harbour-bead-necklace';

-- Sun pendant chain (Brandt & Mirelle)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'sun-pendant-chain', ar.id, t.id, 'Sun pendant chain', '2025', 2025, NULL, 'A hand-pierced sun in recycled silver on a fine trace chain.', 'The first warm day of the year.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'brandt-and-mirelle' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '14 g' FROM artwork a, material m WHERE a.slug = 'sun-pendant-chain' AND m.name = 'Recycled silver';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'sun-pendant-chain' AND t.name = 'Goldsmithing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Piercing and finishing', '2025-03-03', '2025-03-07', 11 FROM artwork WHERE slug = 'sun-pendant-chain';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/sun-pendant-chain-1.webp', 'photo', 'Illustrative photo for Sun pendant chain', 'Photo: César O''neill on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'sun-pendant-chain';

-- Spill dress (Ossery Studio)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'spill-dress', ar.id, t.id, 'Spill dress', '2025', 2025, 'S', 'Strapless dress in organic cotton, hand-painted in layers of textile paint so the colours bleed like spilled ink.', 'Abstract painting, colour flow and movement across fabric.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'ossery-studio' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, '4 m' FROM artwork a, material m WHERE a.slug = 'spill-dress' AND m.name = 'Organic cotton';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'several layers' FROM artwork a, material m WHERE a.slug = 'spill-dress' AND m.name = 'Textile paint';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'spill-dress' AND t.name = 'Textile painting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'spill-dress' AND t.name = 'Sewing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Composition sketches', '2025-02-10', '2025-02-14', 10 FROM artwork WHERE slug = 'spill-dress';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Painting the fabric', '2025-02-17', '2025-03-07', 42 FROM artwork WHERE slug = 'spill-dress';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Construction', '2025-03-10', '2025-03-21', 28 FROM artwork WHERE slug = 'spill-dress';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/spill-dress-1.webp', 'photo', 'Illustrative photo for Spill dress', 'Photo: Solene bernardeau on Unsplash', 'Unsplash License', 988, 1750, 0 FROM artwork WHERE slug = 'spill-dress';

-- Liquid chrome set (Ossery Studio)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'liquid-chrome-set', ar.id, t.id, 'Liquid chrome set', '2026', 2026, 'M', 'Top and trousers in deadstock jersey, coated by hand in a flexible metallic finish.', 'Mercury, and car paint at night.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'ossery-studio' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'stretch jersey, 3 m' FROM artwork a, material m WHERE a.slug = 'liquid-chrome-set' AND m.name = 'Deadstock fabric';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'coating' FROM artwork a, material m WHERE a.slug = 'liquid-chrome-set' AND m.name = 'Metallic thread';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'liquid-chrome-set' AND t.name = 'Coating';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'liquid-chrome-set' AND t.name = 'Sewing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Coating tests', '2026-01-12', '2026-01-30', 24 FROM artwork WHERE slug = 'liquid-chrome-set';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Construction', '2026-02-02', '2026-02-20', 36 FROM artwork WHERE slug = 'liquid-chrome-set';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/liquid-chrome-set-1.webp', 'photo', 'Illustrative photo for Liquid chrome set', 'Photo: Marcin Sajur on Unsplash', 'Unsplash License', 1147, 1750, 0 FROM artwork WHERE slug = 'liquid-chrome-set';

-- Copper fringe dress (Ossery Studio)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'copper-fringe-dress', ar.id, t.id, 'Copper fringe dress', '2025', 2025, 'S', 'Short dress with tiers of hand-cut fringe that move like grass in wind.', 'Savannah grass, seen from very close.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'ossery-studio' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'suede-effect fringe, 6 m' FROM artwork a, material m WHERE a.slug = 'copper-fringe-dress' AND m.name = 'Deadstock fabric';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'copper-fringe-dress' AND t.name = 'Sewing';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Cutting the fringe', '2025-07-01', '2025-07-18', 46 FROM artwork WHERE slug = 'copper-fringe-dress';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Construction', '2025-07-21', '2025-08-01', 30 FROM artwork WHERE slug = 'copper-fringe-dress';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/copper-fringe-dress-1.webp', 'photo', 'Illustrative photo for Copper fringe dress', 'Photo: Babarinde Tosin on Unsplash', 'Unsplash License', 1400, 1750, 0 FROM artwork WHERE slug = 'copper-fringe-dress';

-- Black filigree crown (Maison Quellane)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'black-filigree-crown', ar.id, t.id, 'Black filigree crown', '2025', 2025, NULL, 'A crown of lacquered black wire scrolls, light enough to wear all evening.', 'Wrought-iron balconies in Brussels.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'maison-quellane' AND t.name = 'Headdress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'lacquered wire' FROM artwork a, material m WHERE a.slug = 'black-filigree-crown' AND m.name = 'Metal';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'black-filigree-crown' AND t.name = 'Wirework';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'black-filigree-crown' AND t.name = 'Millinery';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Drawing the scrolls', '2025-04-07', '2025-04-11', 9 FROM artwork WHERE slug = 'black-filigree-crown';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Bending and lacquering', '2025-04-14', '2025-05-02', 52 FROM artwork WHERE slug = 'black-filigree-crown';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/black-filigree-crown-1.webp', 'photo', 'Illustrative photo for Black filigree crown', 'Photo: samo mw on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'black-filigree-crown';

-- Sculpted straw brim (Maison Quellane)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'sculpted-straw-brim', ar.id, t.id, 'Sculpted straw brim', '2024', 2024, NULL, 'A wide sun hat in natural straw, blocked by hand and steamed into a soft wave.', 'Long afternoons, no plans.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'maison-quellane' AND t.name = 'Hat';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'natural, undyed' FROM artwork a, material m WHERE a.slug = 'sculpted-straw-brim' AND m.name = 'Straw';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'sculpted-straw-brim' AND t.name = 'Millinery';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Blocking', '2024-03-04', '2024-03-08', 14 FROM artwork WHERE slug = 'sculpted-straw-brim';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Shaping and finishing', '2024-03-11', '2024-03-15', 12 FROM artwork WHERE slug = 'sculpted-straw-brim';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/sculpted-straw-brim-1.webp', 'photo', 'Illustrative photo for Sculpted straw brim', 'Photo: DDP on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'sculpted-straw-brim';

-- Gilded bloom eyepiece (Maison Quellane)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'gilded-bloom-eyepiece', ar.id, t.id, 'Gilded bloom eyepiece', '2026', 2026, NULL, 'A gilded flower that covers one eye, held by a hidden band.', 'A daisy pressed in a book and forgotten.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'maison-quellane' AND t.name = 'Headdress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'gold leaf over brass' FROM artwork a, material m WHERE a.slug = 'gilded-bloom-eyepiece' AND m.name = 'Gold';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'gilded-bloom-eyepiece' AND t.name = 'Gilding';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Forming the petals', '2026-02-02', '2026-02-13', 20 FROM artwork WHERE slug = 'gilded-bloom-eyepiece';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Gilding', '2026-02-16', '2026-02-20', 10 FROM artwork WHERE slug = 'gilded-bloom-eyepiece';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/gilded-bloom-eyepiece-1.webp', 'photo', 'Illustrative photo for Gilded bloom eyepiece', 'Photo: Selvadass M on Unsplash', 'Unsplash License', 984, 1750, 0 FROM artwork WHERE slug = 'gilded-bloom-eyepiece';

-- Salvaged jewel bib (Wrenfield Reclaim)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'salvaged-jewel-bib', ar.id, t.id, 'Salvaged jewel bib', '2025', 2025, NULL, 'A bib necklace built from 60 stones and beads rescued from broken costume jewellery.', 'A jewellery box found at an estate sale.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'wrenfield-reclaim' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'reclaimed, 60 pieces' FROM artwork a, material m WHERE a.slug = 'salvaged-jewel-bib' AND m.name = 'Glass beads';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'reclaimed' FROM artwork a, material m WHERE a.slug = 'salvaged-jewel-bib' AND m.name = 'Gemstones';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'salvaged-jewel-bib' AND t.name = 'Beadwork';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'salvaged-jewel-bib' AND t.name = 'Upcycling';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Sorting and cleaning', '2025-05-05', '2025-05-09', 12 FROM artwork WHERE slug = 'salvaged-jewel-bib';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Assembly', '2025-05-12', '2025-05-30', 34 FROM artwork WHERE slug = 'salvaged-jewel-bib';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/salvaged-jewel-bib-1.webp', 'photo', 'Illustrative photo for Salvaged jewel bib', 'Photo: Camila Quintero Franco on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'salvaged-jewel-bib';

-- Rivière, reworked (Wrenfield Reclaim)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'riviere-reworked', ar.id, t.id, 'Rivière, reworked', '2024', 2024, NULL, 'A broken rivière necklace, re-strung and reset with matching vintage paste stones.', 'Repair as design.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'wrenfield-reclaim' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'vintage paste stones' FROM artwork a, material m WHERE a.slug = 'riviere-reworked' AND m.name = 'Glass beads';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'new settings' FROM artwork a, material m WHERE a.slug = 'riviere-reworked' AND m.name = 'Recycled silver';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'riviere-reworked' AND t.name = 'Stone setting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'riviere-reworked' AND t.name = 'Upcycling';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Repair', '2024-11-04', '2024-11-15', 21 FROM artwork WHERE slug = 'riviere-reworked';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/riviere-reworked-1.webp', 'photo', 'Illustrative photo for Rivière, reworked', 'Photo: Rosemary Media on Unsplash', 'Unsplash License', 1167, 1750, 0 FROM artwork WHERE slug = 'riviere-reworked';

-- Candy gem chain (Wrenfield Reclaim)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'candy-gem-chain', ar.id, t.id, 'Candy gem chain', '2025', 2025, NULL, 'Coloured stones from a dozen broken necklaces, joined on one long gold-tone chain.', 'Sweet jars.', NULL, NULL, NULL
FROM artist ar, artwork_type t WHERE ar.slug = 'wrenfield-reclaim' AND t.name = 'Necklace';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'reclaimed, 24 stones' FROM artwork a, material m WHERE a.slug = 'candy-gem-chain' AND m.name = 'Gemstones';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, 'gold-tone chain' FROM artwork a, material m WHERE a.slug = 'candy-gem-chain' AND m.name = 'Metal';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'candy-gem-chain' AND t.name = 'Upcycling';
INSERT INTO creation_stage (artwork_id, name, started_on, finished_on, hours) SELECT id, 'Assembly', '2025-08-04', '2025-08-08', 9 FROM artwork WHERE slug = 'candy-gem-chain';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/studios/candy-gem-chain-1.webp', 'photo', 'Illustrative photo for Candy gem chain', 'Photo: César O''neill on Unsplash', 'Unsplash License', 1387, 1750, 0 FROM artwork WHERE slug = 'candy-gem-chain';

