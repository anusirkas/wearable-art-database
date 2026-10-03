-- Contemporary designers, photographed in museums and exhibitions. Wikimedia Commons, openly licensed.

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

INSERT INTO artist (slug, name, status, life_dates, country_code, bio) VALUES
('iris-van-herpen', 'Iris van Herpen', 'contemporary', 'Dutch, born 1984', 'NL', 'Dutch couturier who builds garments with 3D printing, laser cutting and heat-bonded materials, often with scientists and architects.'),
('guo-pei', 'Guo Pei', 'contemporary', 'Chinese, born 1967', 'CN', 'Beijing couturier known for monumental, hand-embroidered gowns that can take thousands of hours to make.'),
('marine-serre', 'Marine Serre', 'contemporary', 'French, born 1991', 'FR', 'Paris designer whose collections are built largely from regenerated and upcycled materials.'),
('alexander-mcqueen', 'Alexander McQueen', 'contemporary', 'British, 1969–2010', 'GB', 'London designer whose theatrical collections joined Savile Row tailoring with romantic, often dark storytelling.'),
('viktor-and-rolf', 'Viktor & Rolf', 'contemporary', 'Dutch, founded 1993', 'NL', 'Amsterdam duo who treat couture as conceptual art, from upside-down shows to dresses cut like sculptures.'),
('rei-kawakubo', 'Rei Kawakubo', 'contemporary', 'Japanese, born 1942', 'JP', 'Founder of Comme des Garçons, who questions what a garment is with abstract, body-reshaping forms.'),
('yohji-yamamoto', 'Yohji Yamamoto', 'contemporary', 'Japanese, born 1943', 'JP', 'Tokyo designer of asymmetric, mostly black tailoring that drapes away from the body.'),
('issey-miyake', 'Issey Miyake', 'contemporary', 'Japanese, 1938–2022', 'JP', 'Designer and engineer of cloth, best known for permanent garment pleating and experiments with new fibres.'),
('thierry-mugler', 'Thierry Mugler', 'contemporary', 'French, 1948–2022', 'FR', 'Paris designer of sculpted, armour-like silhouettes and some of the most theatrical shows of the 1980s and 90s.'),
('john-galliano', 'John Galliano', 'contemporary', 'British, born 1960', 'GB', 'Designer known for historical romance and bias-cut drama, at his own label, Christian Dior and Maison Margiela.'),
('gareth-pugh', 'Gareth Pugh', 'contemporary', 'British, born 1981', 'GB', 'London designer of geometric, often monochrome looks in unexpected materials, from plastic to bin bags.'),
('hussein-chalayan', 'Hussein Chalayan', 'contemporary', 'Cypriot-British, born 1970', 'GB', 'Designer who brings furniture, technology and migration into fashion: tables that become skirts, dresses lit by LEDs.'),
('molly-goddard', 'Molly Goddard', 'contemporary', 'British, born 1988', 'GB', 'London designer of exuberant, hand-smocked tulle dresses.'),
('vivienne-westwood', 'Vivienne Westwood', 'contemporary', 'British, 1941–2022', 'GB', 'From punk to historical tailoring, a designer who reworked British dress history and campaigned on climate.'),
('shaun-leane', 'Shaun Leane', 'contemporary', 'British, born 1969', 'GB', 'London jeweller trained in traditional goldsmithing, known for sculptural body pieces made with Alexander McQueen.'),
('kei-ninomiya', 'Kei Ninomiya', 'contemporary', 'Japanese, born 1984', 'JP', 'Designer of the Noir Kei Ninomiya label, who builds garments from thousands of small parts without sewing them.');

-- Syntopia, look 7 (Iris van Herpen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'syntopia-look-7-iris-van-herpen', ar.id, t.id, 'Syntopia, look 7', '2018', 2018, NULL, 'Heat-welded white polyester with Mylar, organza and polyamide tulle, from the Syntopia collection, inspired by bird flight.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Syntopia,_Look_7_(Iris_van_Herpen_Atelier).jpg', 'Photo: Jl FilpoC, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'iris-van-herpen' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'syntopia-look-7-iris-van-herpen' AND m.name = 'Mylar';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'syntopia-look-7-iris-van-herpen' AND m.name = 'Organza';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'syntopia-look-7-iris-van-herpen' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'syntopia-look-7-iris-van-herpen' AND t.name = 'Heat bonding';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'syntopia-look-7-iris-van-herpen' AND t.name = 'Laser cutting';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/syntopia-look-7-iris-van-herpen.webp', 'photo', 'Syntopia, look 7, Iris van Herpen', 'Photo: Jl FilpoC, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 984, 1750, 0 FROM artwork WHERE slug = 'syntopia-look-7-iris-van-herpen';

-- Dress, Capriole collection (Iris van Herpen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'dress-capriole-collection-iris-van-herpen', ar.id, t.id, 'Dress, Capriole collection', 'Autumn/Winter 2011–12', 2011, NULL, 'A dress from Capriole, Iris van Herpen''s collection about the moment before a parachute jump. Shown at the Galleria del Costume, Florence.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Iris_van_herpen,_abito,_capriole_collection,_a-i_2011-12.jpg', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'iris-van-herpen' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'dress-capriole-collection-iris-van-herpen' AND m.name = 'Leather';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'dress-capriole-collection-iris-van-herpen' AND t.name = 'Laser cutting';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/dress-capriole-collection-iris-van-herpen.webp', 'photo', 'Dress, Capriole collection, Iris van Herpen', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons', 'CC BY 3.0', 1220, 1750, 0 FROM artwork WHERE slug = 'dress-capriole-collection-iris-van-herpen';

-- Couture ensemble (Iris van Herpen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'couture-ensemble-iris-van-herpen', ar.id, t.id, 'Couture ensemble', 'Autumn/Winter 2011–12, edition 2015', 2011, NULL, 'Top of 3D-printed white polyamide in the form of spiralling shells; skirt of white cow leather trimmed with clear acrylic fringe.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Iris_van_Herpen_ensemble_(51582).jpg', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'iris-van-herpen' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'couture-ensemble-iris-van-herpen' AND m.name = 'Polyamide';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'couture-ensemble-iris-van-herpen' AND m.name = 'Leather';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'couture-ensemble-iris-van-herpen' AND m.name = 'Acrylic';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'couture-ensemble-iris-van-herpen' AND t.name = '3D printing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/couture-ensemble-iris-van-herpen.webp', 'photo', 'Couture ensemble, Iris van Herpen', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1184, 1750, 0 FROM artwork WHERE slug = 'couture-ensemble-iris-van-herpen';

-- Gown, Sculpting the Senses (Iris van Herpen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'gown-sculpting-the-senses-iris-van-herpen', ar.id, t.id, 'Gown, Sculpting the Senses', '2024 exhibition', NULL, NULL, 'A lattice-like gown shown in Iris van Herpen: Sculpting the Senses at the Gallery of Modern Art, Brisbane, 2024.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Iris_Van_Herpen_Sculpting_the_Senses_exhibition_at_QGOMA,_2024,_10.jpg', 'Photo: Kgbo, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'iris-van-herpen' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'gown-sculpting-the-senses-iris-van-herpen' AND m.name = 'Organza';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'gown-sculpting-the-senses-iris-van-herpen' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'gown-sculpting-the-senses-iris-van-herpen' AND t.name = 'Laser cutting';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'gown-sculpting-the-senses-iris-van-herpen' AND t.name = 'Heat bonding';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/gown-sculpting-the-senses-iris-van-herpen.webp', 'photo', 'Gown, Sculpting the Senses, Iris van Herpen', 'Photo: Kgbo, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1313, 1750, 0 FROM artwork WHERE slug = 'gown-sculpting-the-senses-iris-van-herpen';

-- Gold couture gown (detail) (Guo Pei)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'gold-couture-gown-detail-guo-pei', ar.id, t.id, 'Gold couture gown (detail)', '2015 exhibition', NULL, NULL, 'A gold-embroidered couture gown shown in “China: Through the Looking Glass” at the Metropolitan Museum of Art, 2015.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Met_Guo_Pei_2.jpg', 'Photo: https://www.flickr.com/photos/xiivii/, CC BY 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'guo-pei' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'gold-couture-gown-detail-guo-pei' AND m.name = 'Silk';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'gold-couture-gown-detail-guo-pei' AND m.name = 'Metallic thread';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'gold-couture-gown-detail-guo-pei' AND t.name = 'Embroidery';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/gold-couture-gown-detail-guo-pei.webp', 'photo', 'Gold couture gown (detail), Guo Pei', 'Photo: https://www.flickr.com/photos/xiivii/, CC BY 2.0, via Wikimedia Commons', 'CC BY 2.0', 1167, 1750, 0 FROM artwork WHERE slug = 'gold-couture-gown-detail-guo-pei';

-- Couture gown (Guo Pei)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'couture-gown-guo-pei', ar.id, t.id, 'Couture gown', '2015 exhibition', NULL, NULL, 'A Guo Pei design shown in “China: Through the Looking Glass” at the Metropolitan Museum of Art, 2015.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Met_Guo_Pei_3.jpg', 'Photo: https://www.flickr.com/photos/klg19/, CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'guo-pei' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'couture-gown-guo-pei' AND m.name = 'Silk';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'couture-gown-guo-pei' AND m.name = 'Metallic thread';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'couture-gown-guo-pei' AND t.name = 'Embroidery';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/couture-gown-guo-pei.webp', 'photo', 'Couture gown, Guo Pei', 'Photo: https://www.flickr.com/photos/klg19/, CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 984, 1750, 0 FROM artwork WHERE slug = 'couture-gown-guo-pei';

-- Awakened Icon, Amor Fati (Marine Serre)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'awakened-icon-amor-fati-marine-serre', ar.id, t.id, 'Awakened Icon, Amor Fati', 'Spring/Summer 2021', 2021, NULL, 'A look from Amor Fati, built from regenerated materials with Marine Serre''s crescent-moon print.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Marine_Serre_-_Awakened_Icon_-_Amor_Fati_SS_2021.jpg', 'Photo: Premeditated Chaos, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'marine-serre' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'awakened-icon-amor-fati-marine-serre' AND m.name = 'Deadstock fabric';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'awakened-icon-amor-fati-marine-serre' AND t.name = 'Upcycling';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'awakened-icon-amor-fati-marine-serre' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/awakened-icon-amor-fati-marine-serre.webp', 'photo', 'Awakened Icon, Amor Fati, Marine Serre', 'Photo: Premeditated Chaos, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 864, 1750, 0 FROM artwork WHERE slug = 'awakened-icon-amor-fati-marine-serre';

-- Two dresses, Angels and Demons (Alexander McQueen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'two-dresses-angels-and-demons-alexander-mcqueen', ar.id, t.id, 'Two dresses, Angels and Demons', 'Autumn/Winter 2010', 2010, NULL, 'Looks 16 and 11 from McQueen''s final collection, shown at Savage Beauty, Victoria and Albert Museum.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Dress_by_Alexander_McQueen,_Savage_Beauty_exhibition.jpg', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'alexander-mcqueen' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'two-dresses-angels-and-demons-alexander-mcqueen' AND m.name = 'Silk';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'two-dresses-angels-and-demons-alexander-mcqueen' AND m.name = 'Feathers';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'two-dresses-angels-and-demons-alexander-mcqueen' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'two-dresses-angels-and-demons-alexander-mcqueen' AND t.name = 'Jacquard weaving';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'two-dresses-angels-and-demons-alexander-mcqueen' AND t.name = 'Embroidery';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/two-dresses-angels-and-demons-alexander-mcqueen.webp', 'photo', 'Two dresses, Angels and Demons, Alexander McQueen', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 1313, 1750, 0 FROM artwork WHERE slug = 'two-dresses-angels-and-demons-alexander-mcqueen';

-- Feather dress, The Horn of Plenty (Alexander McQueen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'feather-dress-the-horn-of-plenty-alexander-mcqueen', ar.id, t.id, 'Feather dress, The Horn of Plenty', 'Autumn/Winter 2009', 2009, NULL, 'Look 45 from The Horn of Plenty, shown at Savage Beauty, Victoria and Albert Museum.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Feather_dress_from_Horn_of_Plenty_by_Alexander_McQueen_at_Savage_Beauty.jpg', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'alexander-mcqueen' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'feather-dress-the-horn-of-plenty-alexander-mcqueen' AND m.name = 'Feathers';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'feather-dress-the-horn-of-plenty-alexander-mcqueen' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/feather-dress-the-horn-of-plenty-alexander-mcqueen.webp', 'photo', 'Feather dress, The Horn of Plenty, Alexander McQueen', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 1313, 1750, 0 FROM artwork WHERE slug = 'feather-dress-the-horn-of-plenty-alexander-mcqueen';

-- Dress, Eshu (Alexander McQueen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'dress-eshu-alexander-mcqueen', ar.id, t.id, 'Dress, Eshu', 'Autumn/Winter 2000', 2000, NULL, 'Look 37 from Eshu, named after a Yoruba deity, shown at Savage Beauty, Victoria and Albert Museum.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Savage_Beauty,_dress_by_Alexander_McQueen,_Eshu_collection.jpg', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'alexander-mcqueen' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'dress-eshu-alexander-mcqueen' AND m.name = 'Glass beads';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'dress-eshu-alexander-mcqueen' AND m.name = 'Horsehair';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'dress-eshu-alexander-mcqueen' AND t.name = 'Beadwork';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/dress-eshu-alexander-mcqueen.webp', 'photo', 'Dress, Eshu, Alexander McQueen', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 1313, 1750, 0 FROM artwork WHERE slug = 'dress-eshu-alexander-mcqueen';

-- Parachute cape (Alexander McQueen)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'parachute-cape-alexander-mcqueen', ar.id, t.id, 'Parachute cape', 'Autumn/Winter 2002', 2002, NULL, 'Black silk parachute cape, look 50 from Supercalifragilisticexpialidocious, shown at Savage Beauty, Victoria and Albert Museum.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Parachute_Cape_by_Alexander_McQueen,_Savage_Beauty_exhibition.jpg', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'alexander-mcqueen' AND t.name = 'Coat';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'parachute-cape-alexander-mcqueen' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'parachute-cape-alexander-mcqueen' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/parachute-cape-alexander-mcqueen.webp', 'photo', 'Parachute cape, Alexander McQueen', 'Photo: Isabell Schulz (photos · photo sets), CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 1312, 1750, 0 FROM artwork WHERE slug = 'parachute-cape-alexander-mcqueen';

-- Couture gown (Viktor & Rolf)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'couture-gown-viktor-and-rolf', ar.id, t.id, 'Couture gown', '2018 exhibition', NULL, NULL, 'A sculptural red tulle gown shown in Fashion Artists Viktor & Rolf at the Kunsthal, Rotterdam, 2018.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Fashion_Artists_Viktor_%26_Rolf,_de_Kunsthal,_Rotterdam_(2018)_09.jpg', 'Photo: bertknot, CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'viktor-and-rolf' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'couture-gown-viktor-and-rolf' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'couture-gown-viktor-and-rolf' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/couture-gown-viktor-and-rolf.webp', 'photo', 'Couture gown, Viktor & Rolf', 'Photo: bertknot, CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 978, 1750, 0 FROM artwork WHERE slug = 'couture-gown-viktor-and-rolf';

-- “Hana” dress, Bedtime Story (Viktor & Rolf)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'hana-dress-bedtime-story-viktor-and-rolf', ar.id, t.id, '“Hana” dress, Bedtime Story', 'Autumn/Winter 2005', 2005, NULL, 'From Bedtime Story, a collection built around pillows and bedding worn as clothes.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Viktor_%26_Rolf_%27Hana%27_dress,_Fall-Winter_2005_Bedtime_Story_ready-to-wear_collection_03.jpg', 'Photo: we-make-money-not-art, CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'viktor-and-rolf' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'hana-dress-bedtime-story-viktor-and-rolf' AND m.name = 'Cotton';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'hana-dress-bedtime-story-viktor-and-rolf' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/hana-dress-bedtime-story-viktor-and-rolf.webp', 'photo', '“Hana” dress, Bedtime Story, Viktor & Rolf', 'Photo: we-make-money-not-art, CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 1313, 1750, 0 FROM artwork WHERE slug = 'hana-dress-bedtime-story-viktor-and-rolf';

-- Two looks, Art of the In-Between (Rei Kawakubo)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'two-looks-art-of-the-in-between-rei-kawakubo', ar.id, t.id, 'Two looks, Art of the In-Between', '2017 exhibition', NULL, NULL, 'Comme des Garçons looks shown in Rei Kawakubo/Comme des Garçons: Art of the In-Between, Metropolitan Museum of Art, 2017.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Comme_des_Garcons_at_the_Met_(62477).jpg', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'rei-kawakubo' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'two-looks-art-of-the-in-between-rei-kawakubo' AND m.name = 'Cotton';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'two-looks-art-of-the-in-between-rei-kawakubo' AND m.name = 'Polyester';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'two-looks-art-of-the-in-between-rei-kawakubo' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/two-looks-art-of-the-in-between-rei-kawakubo.webp', 'photo', 'Two looks, Art of the In-Between, Rei Kawakubo', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1084, 1750, 0 FROM artwork WHERE slug = 'two-looks-art-of-the-in-between-rei-kawakubo';

-- Body-reshaping looks (Rei Kawakubo)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'body-reshaping-looks-rei-kawakubo', ar.id, t.id, 'Body-reshaping looks', '2017 exhibition', NULL, NULL, 'Comme des Garçons looks shown in Art of the In-Between, Metropolitan Museum of Art, 2017.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Comme_des_Garcons_at_the_Met_(62442).jpg', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'rei-kawakubo' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'body-reshaping-looks-rei-kawakubo' AND m.name = 'Wool';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'body-reshaping-looks-rei-kawakubo' AND m.name = 'Polyester';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'body-reshaping-looks-rei-kawakubo' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/body-reshaping-looks-rei-kawakubo.webp', 'photo', 'Body-reshaping looks, Rei Kawakubo', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1400, 1684, 0 FROM artwork WHERE slug = 'body-reshaping-looks-rei-kawakubo';

-- Jacket and skirt (Yohji Yamamoto)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'jacket-and-skirt-yohji-yamamoto', ar.id, t.id, 'Jacket and skirt', 'Autumn/Winter 2003–04', 2003, NULL, 'Wool and silk jacket and skirt, shown at the Galleria del Costume, Florence.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Youji_yamamoto,_completo_di_giacca_e_gonna_in_lana_e_seta,_a-i_2003-2004.jpg', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'yohji-yamamoto' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'jacket-and-skirt-yohji-yamamoto' AND m.name = 'Wool';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'jacket-and-skirt-yohji-yamamoto' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'jacket-and-skirt-yohji-yamamoto' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/jacket-and-skirt-yohji-yamamoto.webp', 'photo', 'Jacket and skirt, Yohji Yamamoto', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons', 'CC BY 3.0', 1177, 1750, 0 FROM artwork WHERE slug = 'jacket-and-skirt-yohji-yamamoto';

-- Rhythm Pleats (Issey Miyake)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'rhythm-pleats-issey-miyake', ar.id, t.id, 'Rhythm Pleats', '1990', 1990, NULL, 'Polyester cut and sewn first, then pleated and set with heat and pressure, from the Rhythm Pleats collection.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Issey_Miyake_Rhythm_Pleats_series_1990.jpg', 'Photo: ellenm1, CC BY 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'issey-miyake' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'rhythm-pleats-issey-miyake' AND m.name = 'Polyester';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'rhythm-pleats-issey-miyake' AND t.name = 'Pleating';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/rhythm-pleats-issey-miyake.webp', 'photo', 'Rhythm Pleats, Issey Miyake', 'Photo: ellenm1, CC BY 2.0, via Wikimedia Commons', 'CC BY 2.0', 973, 1750, 0 FROM artwork WHERE slug = 'rhythm-pleats-issey-miyake';

-- Plastic Body bustier (Issey Miyake)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'plastic-body-bustier-issey-miyake', ar.id, t.id, 'Plastic Body bustier', '1980', 1980, NULL, 'A bustier moulded in reinforced plastic, shown in Tra Arte e Moda at the Museo Salvatore Ferragamo, 2016.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Issey_miyake,_plastic_body,_1980,_corpetto_in_fibra_plastica_rinforzata_(tokyo,_miyake_issay_foundation).jpg', 'Photo: Francesco Bini, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'issey-miyake' AND t.name = 'Accessory';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'plastic-body-bustier-issey-miyake' AND m.name = 'Fibreglass-reinforced plastic';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'plastic-body-bustier-issey-miyake' AND t.name = 'Moulding';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/plastic-body-bustier-issey-miyake.webp', 'photo', 'Plastic Body bustier, Issey Miyake', 'Photo: Francesco Bini, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1299, 1750, 0 FROM artwork WHERE slug = 'plastic-body-bustier-issey-miyake';

-- Evening set (Thierry Mugler)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'evening-set-thierry-mugler', ar.id, t.id, 'Evening set', 'Spring 1989', 1989, NULL, 'A mermaid-like evening set, shown in Dress, Dreams and Desire at the Museum at FIT, New York.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Mugler%27s_mermaid_dress_(24218).jpg', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'thierry-mugler' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'evening-set-thierry-mugler' AND m.name = 'Metallic thread';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'evening-set-thierry-mugler' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/evening-set-thierry-mugler.webp', 'photo', 'Evening set, Thierry Mugler', 'Photo: Rhododendrites, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1145, 1750, 0 FROM artwork WHERE slug = 'evening-set-thierry-mugler';

-- Motorcycle corset (Thierry Mugler)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'motorcycle-corset-thierry-mugler', ar.id, t.id, 'Motorcycle corset', 'Autumn/Winter 1992–93', 1992, NULL, 'The bustier-as-motorbike from Mugler''s Les Cow-boys collection, shown at the Montreal Museum of Fine Arts retrospective, 2019.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Mugler_motorcycle_corset.jpeg', 'Photo: Stephen Kelly Photography, CC BY 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'thierry-mugler' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'motorcycle-corset-thierry-mugler' AND m.name = 'Plastic';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'motorcycle-corset-thierry-mugler' AND m.name = 'Metal';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'motorcycle-corset-thierry-mugler' AND t.name = 'Moulding';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/motorcycle-corset-thierry-mugler.webp', 'photo', 'Motorcycle corset, Thierry Mugler', 'Photo: Stephen Kelly Photography, CC BY 2.0, via Wikimedia Commons', 'CC BY 2.0', 715, 1750, 0 FROM artwork WHERE slug = 'motorcycle-corset-thierry-mugler';

-- Newspaper dress for Christian Dior (John Galliano)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'newspaper-dress-for-christian-dior-john-galliano', ar.id, t.id, 'Newspaper dress for Christian Dior', 'Autumn/Winter 2000', 2000, NULL, 'Galliano''s print of Dior''s own newspaper headlines, shown at the Royal Ontario Museum, 2011.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Galliano_dior_newspaper_dress_ROM.jpg', 'Photo: cphoffman42, CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'john-galliano' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'newspaper-dress-for-christian-dior-john-galliano' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'newspaper-dress-for-christian-dior-john-galliano' AND t.name = 'Textile printing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/newspaper-dress-for-christian-dior-john-galliano.webp', 'photo', 'Newspaper dress for Christian Dior, John Galliano', 'Photo: cphoffman42, CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 863, 1750, 0 FROM artwork WHERE slug = 'newspaper-dress-for-christian-dior-john-galliano';

-- Pink ensemble for Christian Dior (John Galliano)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'pink-ensemble-for-christian-dior-john-galliano', ar.id, t.id, 'Pink ensemble for Christian Dior', '1998', 1998, NULL, 'Shown in Fabulous Fashion: From Dior''s New Look to Now, Philadelphia Museum of Art, 2018.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:1998_pink_ensemble_by_John_Galliano_for_Dior.jpg', 'Photo: Laura Blanchard, CC BY-SA 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'john-galliano' AND t.name = 'Coat';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'pink-ensemble-for-christian-dior-john-galliano' AND m.name = 'Wool';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'pink-ensemble-for-christian-dior-john-galliano' AND m.name = 'Fur';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'pink-ensemble-for-christian-dior-john-galliano' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/pink-ensemble-for-christian-dior-john-galliano.webp', 'photo', 'Pink ensemble for Christian Dior, John Galliano', 'Photo: Laura Blanchard, CC BY-SA 2.0, via Wikimedia Commons', 'CC BY-SA 2.0', 1313, 1750, 0 FROM artwork WHERE slug = 'pink-ensemble-for-christian-dior-john-galliano';

-- Look 41 (Gareth Pugh)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'look-41-gareth-pugh', ar.id, t.id, 'Look 41', '2014', 2014, NULL, 'Ensemble in plastic sheeting and calico, chosen as the Fashion Museum Bath''s Dress of the Year 2014.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Gareth_Pugh._Dress_of_the_Year_2014.jpg', 'Photo: Mabalu (photograph), Gareth Pugh (outfit)., CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'gareth-pugh' AND t.name = 'Ensemble';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'look-41-gareth-pugh' AND m.name = 'Plastic sheeting';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'look-41-gareth-pugh' AND m.name = 'Calico';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'look-41-gareth-pugh' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/look-41-gareth-pugh.webp', 'photo', 'Look 41, Gareth Pugh', 'Photo: Mabalu (photograph), Gareth Pugh (outfit)., CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1150, 1727, 0 FROM artwork WHERE slug = 'look-41-gareth-pugh';

-- Dress (Gareth Pugh)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'dress-gareth-pugh', ar.id, t.id, 'Dress', 'Spring/Summer 2018', 2018, NULL, 'A geometric orange dress, shown at the Galleria del Costume, Florence.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Gareth_pugh,_abito,_p-e_2018,_01.jpg', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'gareth-pugh' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'dress-gareth-pugh' AND m.name = 'Polyester';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'dress-gareth-pugh' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/dress-gareth-pugh.webp', 'photo', 'Dress, Gareth Pugh', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons', 'CC BY 3.0', 745, 1750, 0 FROM artwork WHERE slug = 'dress-gareth-pugh';

-- Coffee table skirt, Afterwords (Hussein Chalayan)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'coffee-table-skirt-afterwords-hussein-chalayan', ar.id, t.id, 'Coffee table skirt, Afterwords', 'Autumn/Winter 2000', 2000, NULL, 'A wooden coffee table that telescopes into a skirt, from Afterwords, a collection about leaving home in a hurry.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Coffee_table_skirt_Hussein_Chalayan.jpg', 'Photo: Manuelarosi, CC BY-SA 3.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'hussein-chalayan' AND t.name = 'Accessory';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'coffee-table-skirt-afterwords-hussein-chalayan' AND m.name = 'Wood';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'coffee-table-skirt-afterwords-hussein-chalayan' AND t.name = 'Woodworking';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/coffee-table-skirt-afterwords-hussein-chalayan.webp', 'photo', 'Coffee table skirt, Afterwords, Hussein Chalayan', 'Photo: Manuelarosi, CC BY-SA 3.0, via Wikimedia Commons', 'CC BY-SA 3.0', 1313, 1750, 0 FROM artwork WHERE slug = 'coffee-table-skirt-afterwords-hussein-chalayan';

-- Tulle dress (Hussein Chalayan)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'tulle-dress-hussein-chalayan', ar.id, t.id, 'Tulle dress', '2000', 2000, NULL, 'A ruffled pink tulle dress by Hussein Chalayan, 2000.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Hussein_Chalayan_tulle_dress,_2000.jpg', 'Photo: Hussein Chalayan, CC0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'hussein-chalayan' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'tulle-dress-hussein-chalayan' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'tulle-dress-hussein-chalayan' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/tulle-dress-hussein-chalayan.webp', 'photo', 'Tulle dress, Hussein Chalayan', 'Photo: Hussein Chalayan, CC0, via Wikimedia Commons', 'CC0', 828, 1750, 0 FROM artwork WHERE slug = 'tulle-dress-hussein-chalayan';

-- LED dress (Hussein Chalayan)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'led-dress-hussein-chalayan', ar.id, t.id, 'LED dress', '2007', 2007, NULL, 'A dress lit from within by LEDs, from Chalayan''s experiments with light and technology in clothing.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:LED_dress_by_Hussein_Chalayan_(2).jpg', 'Photo: renaissancechambara, CC BY 2.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'hussein-chalayan' AND t.name = 'Dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'led-dress-hussein-chalayan' AND m.name = 'LEDs';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'led-dress-hussein-chalayan' AND m.name = 'Crystals';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'led-dress-hussein-chalayan' AND t.name = 'Electronics';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/led-dress-hussein-chalayan.webp', 'photo', 'LED dress, Hussein Chalayan', 'Photo: renaissancechambara, CC BY 2.0, via Wikimedia Commons', 'CC BY 2.0', 1163, 1750, 0 FROM artwork WHERE slug = 'led-dress-hussein-chalayan';

-- Daria dress (Molly Goddard)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'daria-dress-molly-goddard', ar.id, t.id, 'Daria dress', '2019', 2019, NULL, 'Nylon tulle with over 60 metres of fabric, displayed at V&A East, London.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Daria_dress,_2019,_by_Molly_Goddard_03.jpg', 'Photo: 14GTR, CC0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'molly-goddard' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'daria-dress-molly-goddard' AND m.name = 'Tulle';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'daria-dress-molly-goddard' AND t.name = 'Smocking';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/daria-dress-molly-goddard.webp', 'photo', 'Daria dress, Molly Goddard', 'Photo: 14GTR, CC0, via Wikimedia Commons', 'CC0', 1017, 1750, 0 FROM artwork WHERE slug = 'daria-dress-molly-goddard';

-- Evening dress after Elizabeth I (Vivienne Westwood)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'evening-dress-after-elizabeth-i-vivienne-westwood', ar.id, t.id, 'Evening dress after Elizabeth I', '1997', 1997, NULL, 'An evening dress inspired by portraits of Queen Elizabeth I.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Evening_dress_inspired_by_Queen_Elizabeth_the_first_Westwood_1997.jpg', 'Photo: Mx Lucy, CC BY-SA 4.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'vivienne-westwood' AND t.name = 'Evening dress';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'evening-dress-after-elizabeth-i-vivienne-westwood' AND m.name = 'Silk';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'evening-dress-after-elizabeth-i-vivienne-westwood' AND t.name = 'Textile printing';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 2 FROM artwork a, technique t WHERE a.slug = 'evening-dress-after-elizabeth-i-vivienne-westwood' AND t.name = 'Sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/evening-dress-after-elizabeth-i-vivienne-westwood.webp', 'photo', 'Evening dress after Elizabeth I, Vivienne Westwood', 'Photo: Mx Lucy, CC BY-SA 4.0, via Wikimedia Commons', 'CC BY-SA 4.0', 1035, 1750, 0 FROM artwork WHERE slug = 'evening-dress-after-elizabeth-i-vivienne-westwood';

-- Coiled corset for Alexander McQueen (Shaun Leane)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'coiled-corset-for-alexander-mcqueen-shaun-leane', ar.id, t.id, 'Coiled corset for Alexander McQueen', 'Autumn/Winter 1999', 1999, NULL, 'A form-encasing bodice made from coils of aluminium, look 47 from Alexander McQueen’s The Overlook.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Fitting_of_the_Coiled_Corset.jpg', 'Photo: Shaun Leane, CC BY-SA 3.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'shaun-leane' AND t.name = 'Accessory';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'coiled-corset-for-alexander-mcqueen-shaun-leane' AND m.name = 'Aluminium';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'coiled-corset-for-alexander-mcqueen-shaun-leane' AND t.name = 'Goldsmithing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/coiled-corset-for-alexander-mcqueen-shaun-leane.webp', 'photo', 'Coiled corset for Alexander McQueen, Shaun Leane', 'Photo: Shaun Leane, CC BY-SA 3.0, via Wikimedia Commons', 'CC BY-SA 3.0', 1161, 1750, 0 FROM artwork WHERE slug = 'coiled-corset-for-alexander-mcqueen-shaun-leane';

-- Jacket, Moncler Genius (Kei Ninomiya)
INSERT INTO artwork (slug, artist_id, artwork_type_id, title, date_label, year, size_label, description, inspiration, source_name, source_url, credit_line)
SELECT 'jacket-moncler-genius-kei-ninomiya', ar.id, t.id, 'Jacket, Moncler Genius', 'Autumn/Winter 2018–19', 2018, NULL, 'A sculptural puffer for 6 Moncler Noir Kei Ninomiya, shown at the Galleria del Costume, Florence.', NULL, 'Wikimedia Commons', 'https://commons.wikimedia.org/wiki/File:Moncler_genius,_6_moncler_noir_kei_ninomiya,_giacca,_a-i_2018-19,_01.jpg', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons'
FROM artist ar, artwork_type t WHERE ar.slug = 'kei-ninomiya' AND t.name = 'Jacket';
INSERT INTO artwork_material (artwork_id, material_id, quantity) SELECT a.id, m.id, NULL FROM artwork a, material m WHERE a.slug = 'jacket-moncler-genius-kei-ninomiya' AND m.name = 'Nylon';
INSERT INTO artwork_technique (artwork_id, technique_id, step_order) SELECT a.id, t.id, 1 FROM artwork a, technique t WHERE a.slug = 'jacket-moncler-genius-kei-ninomiya' AND t.name = 'Assembly without sewing';
INSERT INTO media (artwork_id, file_url, media_type, caption, credit, license, width, height, sort_order) SELECT id, '/images/contemporary/jacket-moncler-genius-kei-ninomiya.webp', 'photo', 'Jacket, Moncler Genius, Kei Ninomiya', 'Photo: Sailko, CC BY 3.0, via Wikimedia Commons', 'CC BY 3.0', 1266, 1750, 0 FROM artwork WHERE slug = 'jacket-moncler-genius-kei-ninomiya';

REFRESH MATERIALIZED VIEW artwork_search;
