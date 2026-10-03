-- Reference data: types, materials, techniques and the lookup tables.

INSERT INTO artwork_type (name, category, description) VALUES
('Dress',          'garment',   'A one-piece garment.'),
('Evening dress',  'garment',   'Formal or couture dress for evening occasions.'),
('Ensemble',       'garment',   'Two or more pieces designed to be worn together.'),
('Coat',           'garment',   'Outerwear: coats, capes and mantles.'),
('Jacket',         'garment',   'Short outerwear and tailored jackets.'),
('Robe',           'garment',   'Robes, kimonos and wrapped garments.'),
('Necklace',       'jewellery', 'Necklaces, collars and pendants.'),
('Brooch',         'jewellery', 'Brooches and pins.'),
('Bracelet',       'jewellery', 'Bracelets, bangles and cuffs.'),
('Earrings',       'jewellery', 'Earrings and ear ornaments.'),
('Ring',           'jewellery', 'Rings.'),
('Hat',            'headwear',  'Hats and bonnets.'),
('Headdress',      'headwear',  'Ceremonial and sculptural headpieces.'),
('Bag',            'accessory', 'Bags, purses and reticules.'),
('Fan',            'accessory', 'Hand fans.'),
('Accessory',      'accessory', 'Other wearable accessories.'),
('Shoes',          'footwear',  'Shoes, boots and slippers.');

-- Artist-added types (the course project's UUS_TEOSE_TYYP), each under a standard type.
INSERT INTO custom_artwork_type (artwork_type_id, name, description)
SELECT t.id, v.name, v.description
FROM (VALUES
  ('Dress', 'Knitted sculpture dress', 'A dress where the knit structure is the artwork.'),
  ('Accessory', 'Textile body sculpture', 'Wearable sculpture that is not a garment or jewellery.'),
  ('Necklace', 'Upcycled statement collar', 'Collar built from reclaimed materials.')
) AS v(type_name, name, description)
JOIN artwork_type t ON t.name = v.type_name;

INSERT INTO material (name, category, origin, is_sustainable, notes) VALUES
-- from the course project. Origin is only set where the material itself is specific;
-- shared materials like silk appear on archive pieces too.
('Merino wool',     'fibre',  'High-quality merino, European spinner', true,  'Renewable, biodegradable animal fibre.'),
('Mohair',          'fibre',  'Mohair blend, small producer',          true,  NULL),
('Cashmere',        'fibre',  'Cashmere yarn, international supplier', false, 'High environmental cost from overgrazing.'),
('Silk',            'fabric', NULL,                                    false, 'Natural fibre, but resource-intensive to produce.'),
('Organic cotton',  'fabric', 'Certified organic cotton',              true,  'Grown without synthetic pesticides.'),
('Lace',            'fabric', NULL,                                    false, NULL),
('Glass beads',     'bead',   NULL,                                    false, 'Includes crystal, paste and rhinestones.'),
('Satin ribbon',    'trim',   'Natural-fibre satin, European maker',   true,  NULL),
('Textile paint',   'dye',    'Water-based textile paints',            false, NULL),
-- common in the archive pieces
('Cotton',          'fabric', NULL, NULL, NULL),
('Linen',           'fabric', NULL, true, 'Flax needs little water or pesticide.'),
('Wool',            'fibre',  NULL, true, NULL),
('Velvet',          'fabric', NULL, NULL, NULL),
('Feathers',        'trim',   NULL, false, NULL),
('Fur',             'trim',   NULL, false, NULL),
('Leather',         'other',  NULL, false, NULL),
('Straw',           'fibre',  NULL, true, 'Plant fibre.'),
('Metallic thread', 'trim',   NULL, false, NULL),
('Gold',            'metal',  NULL, false, 'Mining impact unless recycled.'),
('Silver',          'metal',  NULL, false, NULL),
('Enamel',          'other',  NULL, NULL, NULL),
('Pearls',          'stone',  NULL, NULL, NULL),
('Diamonds',        'stone',  NULL, false, NULL),
('Gemstones',       'stone',  NULL, false, NULL),
('Shell',           'other',  NULL, NULL, NULL),
('Recycled silver', 'metal',  'Reclaimed silver', true, 'Recycled metal avoids new mining.'),
('Deadstock fabric','fabric', 'Unused mill surplus', true, 'Rescued surplus fabric.');

INSERT INTO technique (name, description) VALUES
('Jacquard knitting', 'Multi-colour knitting where the pattern runs through the whole fabric.'),
('Lace knitting',     'Airy, openwork knitted patterns.'),
('Stockinette',       'Plain knit with an even surface.'),
('Rib knitting',      'Elastic rib, used for cuffs, hems and collars.'),
('English rib',       'Deep, lofty rib with strong relief.'),
('Sewing',            'Constructing garments by machine and by hand.'),
('Textile painting',  'Painting and printing fabric with textile paints.'),
('Embroidery',        'Decorating fabric with needle and thread.'),
('Beadwork',          'Sewing beads, sequins and pearls onto a surface.'),
('Pleating',          'Folding fabric into permanent pleats.'),
('Weaving',           'Interlacing warp and weft threads into cloth.'),
('Millinery',         'Shaping and blocking hats and headpieces.'),
('Goldsmithing',      'Shaping precious metals by hand.'),
('Enamelling',        'Fusing powdered glass onto metal.'),
('Stone setting',     'Mounting gemstones into metal.');

INSERT INTO transaction_type (name, description) VALUES
('Deposit',      'Commission deposit, paid before handover.'),
('Sale',         'Final sale of an artwork; ownership changes.'),
('Platform fee', 'Monthly or service fee for using the platform.');

INSERT INTO endorsement_type (name, description) VALUES
('Education',  'Education or degree (institution and studies).'),
('Exhibition', 'Shown at an exhibition or presentation (institutional confirmation).'),
('Curator',    'Endorsement from a curator or field expert.');
