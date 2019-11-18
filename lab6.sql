--zad6.1.----------------
--1.

INSERT INTO czekoladki (
    idczekoladki,
    nazwa,
    czekolada,
    orzechy,
    nadzienie,
    opis,
    koszt,
    masa
) VALUES (
    'W98',
    'Biały kieł',
    'biała',
    'laskowe',
    'marcepan',
    'Rozpływające się w rękach i kieszeniach',
    '0.45',
    '20'
)

--2.
INSERT INTO klienci (
    idklienta,
    nazwa,
    ulica,
    miejscowosc,
    kod,
    telefon
) VALUES (
    '90',
    'Matusiak Edward',
    'Kropiwnickiego 6/3',
    'Leningrad',
    '31-471',
    '031 423 45 38'
),
(
    '91',
    'Matusiak Alina',
    'Kropiwnickiego 6/3',
    'Leningrad',
    '31-471',
    '031 423 45 38'
),
(
    '92',
    'Kimono Franek',
    'Karateków 8',
    'Mistrz',
    '30-029',
    '501 498 324'
)

--3.
INSERT INTO klienci (
    idklienta,
    nazwa,
    ulica,
    miejscowosc,
    kod,
    telefon
) VALUES (
    '93',
    'Matusiak Iza',
    (SELECT ulica FROM klienci WHERE idklienta = 90),
    (SELECT miejscowosc FROM klienci WHERE idklienta = 90),
    (SELECT kod FROM klienci WHERE idklienta = 90),
    (SELECT telefon FROM klienci WHERE idklienta = 90)
)

--zad6.2.--------------------------------------------------------
--1.
INSERT INTO czekoladki (
	idczekoladki,
	nazwa,
	czekolada,
	orzechy,
	nadzienie,
	opis,
	koszt,
	masa
) VALUES (
	'X91',
	'Nieznana Nieznajoma',
	NULL,
	NULL,
	NULL,
	'Niewidzialna czekoladka wpomagajaca odchudzanie',
	0.26,
	0
), (
	'M98',
	'Mleczny Raj',
	'Mleczna',
	NULL,
	NULL,
	'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem',
	0.26,
	36
)

--6.3.--------------------------------
--1.
DELETE FROM czekoladki WHERE idczekoladki IN ('X91', 'M98');

--2.
INSERT INTO czekoladki (
        idczekoladki,
        nazwa,
        opis,
        koszt,
        masa
) VALUES (
        'X91',
        'Nieznana Nieznajoma',
        'Niewidzialna czekoladka wpomagajaca odchudzanie',
        0.26,
        0
)

INSERT INTO czekoladki (
        idczekoladki,
        nazwa,
        czekolada,
        opis,
        koszt,
        masa
) VALUES (
        'M98',
        'Mleczny Raj',
        'Mleczna',
        'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem',
        0.26,
        36
)

--6.4.-------------------------------------------------------
--1.
UPDATE klienci SET nazwa = 'Nowak Iza' WHERE nazwa LIKE 'Matusiak Iza';

--2.
UPDATE czekoladki SET koszt = (0.9*koszt) WHERE idczekoladki IN ('W98', 'M98', 'X91');

--3.
UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98') WHERE nazwa = 'Nieznana Nieznajoma';

--6.5----------------------------------------------------------
--1.
DELETE FROM klienci WHERE nazwa LIKE 'Matusiak%';

--6.6----------------------------------------------------------
--1.
INSERT INTO pudelka (
	idpudelka,
	nazwa,
	opis,
	cena,
	stan
) VALUES (
	'new1',
	'Nowe pudelko',
	NULL,
	'20.00',
	300
), (
        'new2',
        'Nowe pudeleczko',
        NULL,
        '40.00',
        500
);

INSERT INTO zawartosc (
	idpudelka,
	idczekoladki,
	sztuk
) VALUES (
	'new1',
	'b01',
	2
), (
        'new1',
        'b02',
        3
), (
        'new1',
        'b03',
        2
), (
        'new1',
        'b04',
        3
);

INSERT INTO zawartosc (
	idpudelka,
	idczekoladki,
	sztuk
) VALUES (
	'new2',
	'm05',
	2
), (
        'new2',
        'm14',
        3
), (
        'new2',
        'w06',
        5
), (
        'new2',
        'f01',
        3
)

--6.7---------------------------------------------------------------------------------------------------------------
COPY pudelka 
    FROM 'skrypt6.7.txt' with (null '', delimiter '|');

COPY pudelka 
    FROM stdin with (null '', delimiter '|');

new1|Nowe pudelko||20.00|300
new2|Nowe pudeleczko||40.00|500

--6.8------------------------------------------------------------------------
UPDATE zawartosc SET sztuk = sztuk + 1 WHERE idpudelka IN ('new1', 'new2');
UPDATE czekoladki SET czekolada = 'brak' WHERE czekolada IS NULL;
UPDATE czekoladki SET orzechy = 'brak' WHERE orzechy IS NULL;
UPDATE czekoladki SET nadzienie = 'brak' WHERE nadzienie IS NULL;

UPDATE czekoladki SET czekolada = NULL WHERE czekolada = 'brak';
UPDATE czekoladki SET orzechy = NULL WHERE orzechy = 'brak';
UPDATE czekoladki SET nadzienie = NULL WHERE nadzienie = 'brak';

