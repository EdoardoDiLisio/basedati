-- 1. Quali sono le compagnie che hanno voli che atterrano in
-- un qualche aeroporto di New York

SELECT DISTINCT V.comp
FROM Volo AS V JOIN ArrPart AS AP ON V.codice = AP.codice AND V.comp = AP.comp
JOIN LuogoAeroporto AS LA ON AP.arrivo = LA.aeroporto
WHERE LA.citta = 'New York';

-- 2. Qual è la durata media di un volo di ogni compagnia
-- (restituire nome della compagnia e durata media dei suoi
-- voli)

SELECT C.nome, AVG(V.durataMinuti) AS DurataMedia
FROM Compagnia AS C 
JOIN Volo AS V ON C.nome = V.comp
GROUP BY C.nome;

-- 3. Quali sono gli aeroporti (restituire, nome e città) situati in
-- Germania

SELECT A.nome, LA.citta
FROM Aeroporto AS A JOIN LuogoAeroporto AS LA ON A.codice = LA.aeroporto
WHERE LA.nazione = 'Germania';

-- 4. Quali sono le compagnie (restituire nome e anno di
-- fondazione) che hanno voli di durata di meno di 3 ore

SELECT C.nome, C.annoFondaz
FROM Compagnia AS C JOIN Volo AS V ON C.nome = V.comp
WHERE V.durataMinuti < 180;

-- 5. Quante sono le compagnie aeree di cui si conosce l’anno
-- di fondazione

SELECT COUNT(C.nome)
FROM Compagnia AS C
WHERE C.annoFondaz IS NOT NULL;

-- 6. Quante sono le compagnie aeree fondate ogni anno. Per
-- ogni anno nel quale è stata fondata almeno una
-- compagnia, restituire l’anno e il numero di compagnie
-- fondate in quell’anno

SELECT C.annoFondaz AS AnnoFondazione, COUNT(*) AS NumeroCompagnie
FROM Compagnia AS C
WHERE C.annoFondaz IS NOT NULL
GROUP BY C.annoFondaz;

-- 7. Quali sono i piani di volo con un cambio che collegano
-- Roma a New York in al più 6 ore (escludendo il tempo del
-- cambio)

SELECT DISTINCT V1.comp, V1.codice, V2.codice
FROM Volo AS V1 
JOIN ArrPart AS AP1 ON V1.codice = AP1.codice AND V1.comp = AP1.comp
JOIN Volo AS V2 ON V1.comp = V2.comp
JOIN ArrPart AS AP2 ON V2.codice = AP2.codice AND V2.comp = AP2.comp 
WHERE AP1.partenza = 'ROM' AND AP2.arrivo = 'NYC'
AND AP1.arrivo = AP2.partenza
AND V1.durataMinuti + V2.durataMinuti <= 360;

-- 8. Quanti sono, in totale, i piani di volo con un cambio (con
-- entrambi i voli della stessa compagnia) che collegano
-- Roma a New York in meno di 6 ore

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

-- 9. Quali sono i piani di volo con un cambio in Olanda e voli
-- della stessa compagnia che collegano Roma a New York in
-- meno di 6 ore di volo (escludendo il tempo di cambio).
-- Ordinare i voli per nome della compagnia crescente

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

-- 10. Qual è l’anno nel quale è stata fondata l’ultima
-- compagnia aerea presente nel db

SELECT MAX(C.annoFondaz) AS AnnoUltimaCompagnia
FROM Compagnia AS C;