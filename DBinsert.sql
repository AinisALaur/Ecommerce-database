INSERT INTO Administratorius (vardas, el_adresas, tel_nr)
VALUES 
('Tomas', 'tomas@gmail.com', '+37012312312'),
('Adomas', 'adomas@gmail.com', '+37012312321'),
('Gabija', 'gabija@gmail.com', '+37012312399');

INSERT INTO Preke (pavadinimas, kategorija, kaina, akcija, sukure_admin, likutis)
VALUES 
('Kompiuteris DELL', 'Technika', 1200, 10, 1, 10), -- 1
('Kompiuteris ACER', 'Technika', 1500, 0, 2, 5), -- 2
('Kompiuteris LENOVA', 'Technika', 900, 0, 3, 6), -- 3
('Apple air pods', 'Technika', 100, 20, 1, 2), -- 4
('Klaviatura Razer', 'Technika', 100, 10, 2, 12), -- 5
('Iphone 13 Pro Max', 'Technika', 600, 15, 3, 15), -- 6
('Dviratis CUBE', 'Sportas', 700, 25, 2, 3), -- 7
('Paspirtukas XIOAMI', 'Sportas', 400, 0, 2, 5), -- 8
('Sportbaciai NIKE', 'Sportas', 100, 10, 3, 30), -- 9
('Sportbaciai ADIDAS', 'Sportas', 90, 0, 3, 26), -- 10
('Begimo sortai', 'Sportas', 30, 0, 1, 2); -- 11

INSERT INTO Uzsakovas (vardas, pavarde, tel_nr, el_adresas, miestas, gatve, namo_nr)
VALUES
('Juozas', 'Juozaukas', '+37012312393', 'juozas@gmail.com', 'Vilnius', 'Kauno', 12),
('Kipras', 'Kiprauskas', '+37012312395', 'kipras@gmail.com', 'Panevezys', 'Savanoriu pr.', 147),
('Arturas', 'Arturauskas', '+3701342391', 'arturas@gmail.com', 'Kaunas', 'Vilniaus', 17),
('Paula', 'Paulauskaite', '+37012342399', 'paula@gmail.com', 'Siauliai', 'Saules', 24),
('Greta', 'Gratauskaite', '+3702342395', 'greta@gmail.com', 'Vilnius', 'Zalgirio', 19);

INSERT INTO Uzsakymas (uzsakovo_id, pateikimo_data)
VALUES
(1, '2026-05-01 14:30:00'), -- 1
(1, '2026-04-12 15:00:00'), -- 2
(2, '2026-03-24 16:30:00'), -- 3
(3, '2026-02-14 17:30:00'), -- 4
(3, '2026-01-30 18:00:00'), -- 5
(4, '2026-01-18 19:30:00'), -- 6
(4, '2025-11-06 20:00:00'), -- 7
(5, '2025-09-16 21:30:00'), -- 8
(2, '2025-05-17 22:00:00'); -- 9

INSERT INTO Krepselis (prekes_id, uzsakymo_id, kiekis, dabartine_kaina)
VALUES
(1, 1, 2, 1200),
(2, 2, 4, 1500),
(11, 3, 3, 30),
(8, 4, 1, 400),
(6, 5, 4, 600),
(7, 6, 2, 700),
(9, 7, 4, 100),
(3, 8, 2, 900),
(10, 9, 1, 90);

CREATE MATERIALIZED VIEW top_klientai
AS SELECT u.id, u.vardas, u.pavarde, SUM(k.kiekis * k.dabartine_kaina) FROM Krepselis k
JOIN Uzsakymas uz ON uz.id = k.uzsakymo_id
JOIN Uzsakovas u ON u.id = uz.uzsakovo_id
GROUP BY u.id, u.vardas, u.pavarde
ORDER BY 1
WITH DATA;