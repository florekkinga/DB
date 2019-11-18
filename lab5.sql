--zad5.1.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT COUNT(*) as liczba_czekoladek 
FROM czekoladki cz;

--2. 
SELECT COUNT(*) as liczba_czekoladek 
FROM czekoladki cz 
WHERE nadzienie IS NOT NULL;

SELECT COUNT(nadzienie) as liczba_czekoladek 
FROM czekoladki cz;

--3. 
SELECT MAX(z.sztuk) as najwiecej_czekoladek 
FROM pudelka p 
	JOIN zawartosc z USING (idpudelka);

SELECT p.nazwa, z.sztuk 
FROM pudelka p 
	JOIN zawartosc z USING (idpudelka) 
GROUP BY p.nazwa, z.sztuk 
ORDER BY z.sztuk DESC LIMIT 1;

--4. 
SELECT p.nazwa, z.sztuk 
FROM pudelka p 
	JOIN zawartosc z USING (idpudelka) 
GROUP BY p.nazwa, z.sztuk;

--5.
SELECT p.nazwa, SUM(z.sztuk) 
FROM pudelka p 
	JOIN zawartosc z USING (idpudelka) 
	JOIN czekoladki cz USING (idczekoladki)
WHERE cz.orzechy IS NULL
GROUP BY p.nazwa, z.sztuk;

--6.
SELECT p.nazwa, SUM(z.sztuk) 
FROM pudelka p 
	JOIN zawartosc z USING (idpudelka) 
	JOIN czekoladki cz USING (idczekoladki)
WHERE cz.czekolada LIKE 'mleczna'
GROUP BY p.nazwa, z.sztuk;

--zad5.2.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT z.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
GROUP BY z.idpudelka

--2. 
SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM
    czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka
ORDER BY masa DESC
LIMIT 1;

--3.
SELECT AVG(pp.masa)
FROM  (
	SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
	FROM czekoladki cz
    		INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    		INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
	GROUP BY p.idpudelka
	ORDER BY masa DESC
) AS pp;

--4. ???
SELECT z.idpudelka, (SUM(cz.masa*z.sztuk)/SUM(cz.masa)) as srednia_waga_czekoladki
FROM zawartosc z
	JOIN czekoladki cz USING (idczekoladki)
GROUP BY z.idpudelka; 

--zad5.3.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT COUNT(z.datarealizacji) AS liczba_zamowien, z.datarealizacji FROM zamowienia z GROUP BY z.datarealizacji;

--2. 
SELECT COUNT(z.idzamowienia) AS liczba_zamowien FROM zamowienia z;

--3. 
SELECT SUM(p.cena*a.sztuk) AS laczna_wartosc_zamowien 
FROM pudelka p 
	JOIN artykuly a USING (idpudelka);

--4.
SELECT k.idklienta, COUNT(k), c.sm
FROM klienci k 
	INNER JOIN zamowienia z ON k.idklienta = z.idklienta
	INNER JOIN 
	      ( 
		SELECT k.idklienta as idklienta, SUM(a.sztuk * p.cena) as sm FROM klienci k 
		INNER JOIN zamowienia z ON k.idklienta = z.idklienta
		INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia 
		INNER JOIN pudelka p ON a.idpudelka = p.idpudelka GROUP BY k.idklienta 
	      ) c ON k.idklienta = c.idklienta
GROUP BY k.idklienta, c.sm
ORDER BY k.idklienta ASC

--zad5.4.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT cz.nazwa, COUNT(cz.nazwa) as ilosc_pudelek 
FROM 
	czekoladki cz 
	JOIN zawartosc z USING(idczekoladki) 
GROUP BY cz.nazwa 
ORDER BY ilosc_pudelek DESC 
LIMIT 1;

--2. 
SELECT p.nazwa, COUNT(p.nazwa) as ilosc_pudelek 
FROM czekoladki cz 
	JOIN zawartosc z USING(idczekoladki) 
	JOIN pudelka p USING (idpudelka)
WHERE cz.orzechy IS NULL
GROUP BY p.nazwa 
ORDER BY ilosc_pudelek DESC
LIMIT 1;

--3.
SELECT cz.nazwa, COUNT(cz.nazwa) as ilosc_pudelek 
FROM 
	czekoladki cz 
	JOIN zawartosc z USING(idczekoladki) 
GROUP BY cz.nazwa 
ORDER BY ilosc_pudelek ASC
LIMIT 1;

--4.
SELECT p.nazwa, SUM(a.sztuk) as ilosc_zamowien
FROM zamowienia z 
	JOIN artykuly a USING (idzamowienia)
JOIN pudelka p USING (idpudelka)
GROUP BY p.nazwa 
ORDER BY ilosc_zamowien DESC
LIMIT 1;

--zad5.5.--------------------------------------------------------------------------------------------------------------
--1. 
SELECT COUNT(extract(quarter FROM z.datarealizacji)) as ilosc FROM zamowienia z;

--2. 
SELECT extract(month FROM z.datarealizacji), COUNT(*) 
FROM zamowienia z 
GROUP BY extract(year FROM z.datarealizacji), extract(month FROM z.datarealizacji);

--3.
SELECT EXTRACT(week FROM datarealizacji) as w, COUNT(*)
FROM zamowienia 
GROUP BY EXTRACT(year FROM datarealizacji), w;

--4.
SELECT k.miejscowosc, COUNT(z.idzamowienia) as ilosc
FROM zamowienia z 
JOIN klienci k USING(idklienta)
GROUP BY k.miejscowosc;

--zad5.6.--------------------------------------------------------------------------------------------------------------
--1.  
SELECT SUM(sum.masa) FROM (SELECT p.idpudelka, SUM(cz.masa*z.sztuk) as masa
FROM
    czekoladki cz
    INNER JOIN zawartosc z ON cz.idczekoladki = z.idczekoladki
    INNER JOIN pudelka p ON z.idpudelka = p.idpudelka
GROUP BY p.idpudelka) as sum;

--2.
SELECT SUM(szuk * p.cena) FROM artykuly
JOIN pudelka p USING(idpudelka)

--zad5.7.--------------------------------------------------------------------------------------------------------------
--1.
SELECT p.idpudelka, p.nazwa, p.cena-SUM(cz.koszt * z.sztuk) AS zysk 
FROM czekoladki cz
	JOIN zawartosc z USING(idczekoladki)
	JOIN pudelka p USING(idpudelka)
GROUP BY p.idpudelka;

--2.
SELECT SUM(a.sztuk*zysk) 
FROM artykuly a 
	JOIN (
		SELECT p.idpudelka, p.nazwa, p.cena-SUM(cz.koszt * z.sztuk) AS zysk 	
		FROM czekoladki cz
			JOIN zawartosc z USING(idczekoladki)
			JOIN pudelka p USING(idpudelka)
		GROUP BY p.idpudelka
	) pudelkazysk USING (idpudelka);

--3.
SELECT SUM(p.stan*zysk)
FROM pudelka p
	JOIN(
		SELECT p.idpudelka, p.nazwa, p.cena-SUM(cz.koszt * z.sztuk) AS zysk 	
		FROM czekoladki cz
			JOIN zawartosc z USING(idczekoladki)
			JOIN pudelka p USING(idpudelka)
		GROUP BY p.idpudelka
	) pudelkazysk USING(idpudelka);


--zad5.8.--------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE lp START 1;

SELECT nextval('lp') as lp, p.idpudelka FROM pudelka p ORDER BY p.idpudelka ASC;

DROP SEQUENCE lp;

