--1--
select codice, comp
from Volo
where durata > 180;

--2--
select distinct comp
from Volo
where durata > 180;

--3--
select codice, comp
from ArrPart
where partenza = 'CIA';

--4--
select comp
from ArrPart
where arrivo ='FCO';


--5--
select codice, comp
from ArrPart
where partenza ='FCO' 
and arrivo ='JFK';

--6--
select distinct comp
from ArrPart
where partenza ='FCO' 
and arrivo ='JFK';

--7--
select distinct a.comp
from ArrPart a, LuogoAeroporto l1, LuogoAeroporto l2 
where l1.aeroporto = a.partenza and l2.aeroporto = a.arrivo
and l1.citta = 'Roma' and l2.citta = 'New York';

--8--
select a.codice, a.nome, l.citta
from ArrPart ap, Aeroporto a, LuogoAeroporto l
where l.aeroporto = ap.partenza and a.codice = ap.partenza
and ap.comp = 'MagicFly';

--9--
select ap.codice, ap.comp, ap.partenza, ap.arrivo
from ArrPart ap, LuogoAeroporto l1, LuogoAeroporto l2
where l1.aeroporto = ap.partenza and l2.aeroporto = ap.arrivo
and l1.citta = 'Roma' and l2.citta = 'New York';

--10--

select ap.codice, ap.comp, ap.partenza, ap.arrivo


--11--

select DISTINCT a.comp
from  ArrPart ap, Compagnia c
where c.nome = a.comp
and a.partenza = 'FCO' and a.arrivo = 'JFK';