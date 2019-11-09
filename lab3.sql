--zad.3.1--------------------------------------------------------------------------------------------------------------
--1. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE (datarealizacji >= '2013-11-12') AND (datarealizacji <= '2013-11-20');

--2. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE (datarealizacji >= '2013-12-01') AND (datarealizacji <= '2013-12-06') OR (datarealizacji >= '2013-12-15') AND (datarealizacji <= '2013-12-20');

--3. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE (datarealizacji >= '2013-12-01') AND (datarealizacji <= '2013-12-31');

--4. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE extract
(month from datarealizacji) = 11 AND extract(year from datarealizacji) = 2013; 

--5. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE extract
(month from datarealizacji) in (11, 12) AND extract(year from datarealizacji) = 2013;

--6. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE extract (day from datarealizacji) in (17, 18, 19);

--7. 
SELECT idzamowienia, idklienta, datarealizacji FROM public.zamowienia WHERE extract(week from datarealizacji) in (46, 47);

--zad.3.2--------------------------------------------------------------------------------------------------------------
--1. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa like 'S%';

--2. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa like 'S%i';

--3. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa like 'S% m%';

--4. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa SIMILAR TO '(A|B|C)%';

--5. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa ILIKE '%orzech%';

--6. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa ILIKE 'S%m%';

--7. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa ILIKE '%truskawki%' OR nazwa ILIKE '%maliny%';

--8. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa NOT SIMILAR TO '([D-K]|S|T)%';

--9. 
SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE 'Słod%';

--10. 
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa NOT LIKE '% %';

--zad.3.3--------------------------------------------------------------------------------------------------------------
--1. 
SELECT miejscowosc FROM public.klienci WHERE miejscowosc SIMILAR TO '(% )+%';

--2. 
SELECT nazwa FROM public.klienci WHERE telefon SIMILAR TO '0%';

--3. 
SELECT nazwa FROM public.klienci WHERE telefon SIMILAR TO '[0-9]{3} [0-9]{3} [0-9]{3}';

--zad.3.4--------------------------------------------------------------------------------------------------------------
--1. 
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24)
UNION
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24);

--2. 
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35)
EXCEPT 
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35);

--3. 
((SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24)
INTERSECT
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24))
UNION
((SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35)
INTERSECT
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35));

--4. 
((SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24)
INTERSECT
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24));

--5. 
((SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35)
EXCEPT 
((SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24) 
UNION
(SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.29 AND 0.35)));

--zad.3.5--------------------------------------------------------------------------------------------------------------
--1.
SELECT idklienta FROM public.klienci
EXCEPT
SELECT distinct idklienta FROM public.zamowienia;

--2. 
SELECT idpudelka FROM pudelka
EXCEPT
SELECT idpudelka FROM artykuly;
