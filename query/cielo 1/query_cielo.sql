-- Definire in SQL le seguenti interrogazioni, in cui si chiedono tutti risultati distinti:
-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
-- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?
-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con
-- codice ‘CIA’ ?
-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice
-- ‘FCO’ ?
-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’
-- e arrivano all’aeroporto ‘JFK’ ?
-- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atter-
-- rano all’aeroporto ‘JFK’ ?
-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla
-- città di ‘New York’ ?
-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli
-- della compagnia di nome ‘MagicFly’ ?
-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e
-- atterrano ad un qualunque aeroporto della città di ‘New York’ ? Restituire: codice
-- del volo, nome della compagnia, e aeroporti di partenza e arrivo.
-- 10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo
-- voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un
-- qualunque aeroporto della città di ‘New York’ ? Restituire: nome della compagnia,
-- codici dei voli, e aeroporti di partenza, scalo e arrivo.
-- 11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atter-
-- rano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?

-- 1

select codice, comp
from Volo
where durataMinuti > 180;

-- 2

select distinct comp
from volo
where durataMinuti > 180;

-- 3

select codice, comp
from ArrPart
where partenza = 'CIA';

-- 4

select distinct comp
from ArrPart
where arrivo = 'FCO';

-- 5

select codice, comp
from ArrPart
where partenza = 'FCO' and arrivo = 'JFK';

-- 6

select distinct comp
from ArrPart
where partenza = 'FCO' and arrivo = 'JFK';

-- 7

select distinct ArrPart.comp
from LuogoAeroporto A1, LuogoAeroporto A2, ArrPart
where ArrPart.partenza = A1.aeroporto and ArrPart.arrivo = A2.aeroporto and A1.citta = 'Roma' and A2.citta = 'New York';

-- 8

select a.codice, a.nome, l.citta
from ArrPart ap, Aeroporto a, LuogoAeroporto l
where l.aeroporto = ap.partenza and a.codice = ap.partenza and ap.comp = 'MagicFly';

-- 9

select ap.codice, ap.comp, ap.partenza, ap.arrivo
from ArrPart ap, LuogoAeroporto L1, LuogoAeroporto L2
where L1.aeroporto = ap.partenza and L2.aeroporto = ap.arrivo and L1.citta = 'Roma' and L2.citta = 'New York';

-- 10

select v1.comp as compagnia, 
	v1.codice as volo1, 
	v2.codice as volo2, 
	v1.partenza as partenza, 
	v1.arrivo as scalo, 
	v2.arrivo as arrivo
from arrpart v1, arrpart v2, luogoaeroporto lap, luogoaeroporto laa
where v1.arrivo = v2.partenza 
	and v1.comp = v2.comp
	and v1.partenza = lap.aeroporto 
	and v2.arrivo = laa.aeroporto 
	and lap.citta = 'Roma' 
	and laa.citta = 'New York';

-- 11 

select distinct a.comp
from ArrPart a, Compagnia c
where c.nome = a.comp and a.partenza = 'FCO' and a.arrivo = 'JKF';