-- Definire in SQL le seguenti interrogazioni, in cui si chiedono tutti risultati distinti:
-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi
-- aeroporti?
-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno
-- 100 minuti?
-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione
-- nella quale opera?
-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla
-- compagnia ‘MagicFly’ ?
-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli
-- aeroporti?
-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più
-- voli?
-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?
-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate
-- a partire dal 1950?
-- 9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?
-- 10. Quali sono le città con almeno due aeroporti?
-- 11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6
-- ore?
-- 12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100
-- minuti?

--1--
select a.codice, a.nome, count(distinct ap.comp) num_compagnie
from Aeroporto a, ArrPart ap, ArrPart ap2
where a.codice = ap.arrivo and a.codice = ap2.partenza
group by a.codice;

--2--
select count(*) numeroVoli
from Volo v, ArrPart ap
where v.codice = ap.codice
and ap.partenza = 'HTR' and v.durataMinuti >= 100;

--3--
select la.nazione, count(distinct la.aeroporto) numeroAeroporti
from ArrPart ap, LuogoAeroporto la, ArrPart ap2
where ap.arrivo = la.aeroporto and ap2.partenza = la.aeroporto
and ap2.comp = 'Apitalia'
group by la.nazione;

--4--
select avg(v.durataMinuti) durataMedia, max(v.durataMinuti) durataMassima, min(v.durataMinuti) durataMinima
from Volo v
where v.comp = 'MagicFly';

--5--
select a.codice, a.nome, min(c.annofondaz) annoFondazione
from Aeroporto a, ArrPart ap, Compagnia c
where a.codice = ap.arrivo and ap.comp = c.nome
group by (a.codice, a.nome);

--6--
select la.nazione, count(distinct la.nazione) nazioniRaggiungibili
from ArrPart ap, LuogoAeroporto la
where ap.partenza = la.aeroporto
group by la.nazione;

--7--
select ap.partenza, a.nome, avg(v.durataMinuti) durataMedia
from Volo v, ArrPart ap, Aeroporto a
where v.codice = ap.codice and a.codice = ap.partenza
group by (ap.partenza, a.nome);

--8--
select c.nome, sum(v.durataMinuti) durataTotale
from Compagnia c, Volo v
where c.nome = v.comp
and c.annofondaz >= 1950
group by c.nome;

--9--
select a.codice, a.nome
from Aeroporto a, ArrPart ap
where a.codice = ap.partenza
group by (a.codice, a.nome)
having count(distinct ap.comp) = 2;

--10--
select la.citta
from LuogoAeroporto la
group by la.citta
having count(distinct la.aeroporto) >= 2;

--11--
select v.comp
from Volo v
group by v.comp
having avg(v.durataMinuti) > 360;

--12--
select v.comp
from Volo v
group by v.comp
having min(v.durataMinuti) > 100;
query_cielo2.sql
Visualizzazione di query_cielo2.sql.