--QUERY 1

SELECT DISTINCT V.comp
FROM Volo AS V JOIN ArrPart AS AP ON V.codice = AP.codice AND V.comp = AP.comp
JOIN LuogoAeroporto AS LA ON AP.arrivo = LA.aeroporto
WHERE LA.citta = 'New York';

--QUERY 2

SELECT C.nome, AVG(V.durataMinuti) AS DurataMedia
FROM Compagnia AS C 
JOIN Volo AS V ON C.nome = V.comp
GROUP BY C.nome;

--QUERY 3

SELECT A.nome, LA.citta
FROM Aeroporto AS A JOIN LuogoAeroporto AS LA ON A.codice = LA.aeroporto
WHERE LA.nazione = 'Germania';

--QUERY 4

SELECT C.nome, C.annoFondaz
FROM Compagnia AS C JOIN Volo AS V ON C.nome = V.comp
WHERE V.durataMinuti < 180;

--QUERY 5

SELECT COUNT(C.nome)
FROM Compagnia AS C
WHERE C.annoFondaz IS NOT NULL;

--QUERY 6

SELECT C.annoFondaz AS AnnoFondazione, COUNT(*) AS NumeroCompagnie
FROM Compagnia AS C
WHERE C.annoFondaz IS NOT NULL
GROUP BY C.annoFondaz;

--QUERY 7

SELECT DISTINCT V1.comp, V1.codice, V2.codice
FROM Volo AS V1 
JOIN ArrPart AS AP1 ON V1.codice = AP1.codice AND V1.comp = AP1.comp
JOIN Volo AS V2 ON V1.comp = V2.comp
JOIN ArrPart AS AP2 ON V2.codice = AP2.codice AND V2.comp = AP2.comp 
WHERE AP1.partenza = 'ROM' AND AP2.arrivo = 'NYC'
AND AP1.arrivo = AP2.partenza
AND V1.durataMinuti + V2.durataMinuti <= 360;

--QUERY 8

SELECT COUNT(*)
FROM (
    SELECT DISTINCT V1.codice, V2.codice
    FROM Volo AS V1
    JOIN ArrPart AS AP1 ON V1.codice = AP1.codice AND V1.comp = AP1.comp
    JOIN Volo AS V2 ON V1.comp = V2.comp
    JOIN ArrPart AS AP2 ON V2.codice = AP2.codice AND V2.comp = AP2.comp
    WHERE AP1.partenza = 'ROM' AND AP2.arrivo = 'NYC'
    AND AP1.arrivo = AP2.partenza
    AND V1.durataMinuti + V2.durataMinuti < 360
) AS CoppieVoli;

--QUERY 9

SELECT V1.comp, V1.codice, V2.codice
FROM Volo AS V1
JOIN ArrPart AS AP1 ON V1.codice = AP1.codice AND V1.comp = AP1.comp
JOIN Volo AS V2 ON V1.comp = V2.comp
JOIN ArrPart AS AP2 ON V2.codice = AP2.codice AND V2.comp = AP2.comp
JOIN LuogoAeroporto AS LA ON AP1.arrivo = LA.aeroporto
WHERE AP1.partenza = 'ROM' AND AP2.arrivo = 'NYC'
AND AP1.arrivo = AP2.partenza
AND V1.durataMinuti + V2.durataMinuti < 360
AND LA.nazione = 'Olanda' 
ORDER BY V1.comp ASC;

--QUERY 10

SELECT MAX(C.annoFondaz) AS AnnoUltimaCompagnia
FROM Compagnia AS C;