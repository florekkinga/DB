--zad4.1.--------------------------------------------------------------------------------------------------------------
SELECT k.nazwa, z.zamowienia FROM klienci k, zamowienia z; ----> iloczyn kartezjanski

--zad4.2.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT z.datarealizacji, z.idzamowienia FROM zamowienia z JOIN klienci k ON z.idklienta = k.idklienta WHERE k.nazwa LIKE '%Antoni';

--2. 
SELECT z.datarealizacji, z.idzamowienia FROM zamowienia z JOIN klienci k ON z.idklienta = k.idklienta WHERE k.ulica LIKE '%/%';

--3. 
SELECT z.datarealizacji, z.idzamowienia FROM zamowienia z JOIN klienci k ON z.idklienta = k.idklienta WHERE k.miejscowosc = 'Kraków' AND ((z.datarealizacji >= '2013-11-01') AND (datarealizacji <= '2013-11-30'));

--zad4.3.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM zamowienia z JOIN klienci k ON z.idklienta = k.idklienta WHERE z.datarealizacji >= current_date - interval '5 years';

--2. 
SELECT k.nazwa AS klienci, k.ulica, k.miejscowosc, p.nazwa AS nazwapudelka FROM zamowienia z JOIN klienci k USING (idklienta) JOIN artykuly a USING(idzamowienia) JOIN pudelka p USING (idpudelka) WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna');

--3. 
SELECT nazwa, ulica, miejscowosc FROM klienci WHERE idklienta IN (SELECT idklienta FROM zamowienia);

--4. 
SELECT k.* FROM klienci k LEFT JOIN zamowienia z ON k.idklienta = z.idklienta WHERE z.idzamowienia IS NULL;

--5. 
SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji 
FROM klienci k 
	LEFT JOIN zamowienia z USING(idklienta) 
WHERE ((z.datarealizacji >= '2013-11-01') AND (datarealizacji <= '2013-11-30'));

--6. 
SELECT k.nazwa AS klienci, k.ulica, k.miejscowosc, p.nazwa AS nazwapudelka, a.sztuk  
FROM zamowienia z 
	JOIN klienci k USING (idklienta) 
	JOIN artykuly a USING(idzamowienia) 
	JOIN pudelka p USING (idpudelka) 
WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna') AND a.sztuk >= 2;

--7. 
SELECT DISTINCT k.nazwa AS klienci, k.ulica, k.miejscowosc, c.orzechy  
FROM zamowienia z 
	JOIN klienci k USING (idklienta) 
	JOIN artykuly a USING(idzamowienia) 
	JOIN zawartosc o USING (idpudelka) 
	JOIN czekoladki c USING (idczekoladki) 
WHERE c.orzechy = 'migdały';

--zad.4.4--------------------------------------------------------------------------------------------------------------
--1.
SELECT p.*, cz.* 
FROM czekoladki cz
	JOIN zawartosc z USING (idczekoladki)
	JOIN pudelka p USING (idpudelka)

--2.
SELECT p.*, cz.* 
FROM czekoladki cz
	JOIN zawartosc z USING (idczekoladki)
	JOIN pudelka p USING (idpudelka)
WHERE p.idpudelka = 'heav';

--3.
SELECT p.*, cz.* 
FROM czekoladki cz
	JOIN zawartosc z USING (idczekoladki)
	JOIN pudelka p USING (idpudelka)
WHERE p.nazwa LIKE '%Kolekcja%';

--zad.4.5--------------------------------------------------------------------------------------------------------------
--1.

--2.

--3.

--4.

--5.

--6.

--7.

--8.

--9.

--zad.4.6--------------------------------------------------------------------------------------------------------------
--1.

--2.

--3.
