-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?

select a.nome, a.codice, count(distinct ap.comp)
from aeroporto a, arrpart ap
where a.codice = ap.arrivo or a.codice = ap.partenza
group by a.codice, a.nome;

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?

select count(*) as num_voli
from volo v, arrpart ap
where v.codice = ap.codice and ap.partenza = 'HTR' and v.durataminuti >= 100;

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella quale opera?

select la.nazione, count(distinct la.aeroporto)
from luogoaeroporto la, arrpart ap
where ap.comp = 'Apitalia' and (ap.arrivo = la.aeroporto or ap.partenza = la.aeroporto)
group by la.nazione;

-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla compagnia ‘MagicFly’ ?

select avg(durataminuti) as media, min(durataminuti) as minimo, max(durataminuti) as massimo
from volo
where comp = 'MagicFly';

-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?

select a.codice as codice_aeroporto, a.nome as nome_aeroporto, min(annofondaz)
from aeroporto a, compagnia c, arrpart ap
where (ap.arrivo = a.codice or ap.partenza = a.codice)
group by a.codice, a.nome;  

-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?

select l1.nazione as nazione, count(distinct l2.nazione) as raggiungibili
from ArrPart ap, LuogoAeroporto l1, LuogoAeroporto l2
where ap.partenza = l1.aeroporto and ap.arrivo = l2.aeroporto and l1.nazione <> l2.nazione
group by l1.nazione;

-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?

select distinct ap.partenza as codice, a.nome as nome, avg(v.durataminuti)
from arrpart ap, aeroporto a, volo v
where ap.codice = v.codice and ap.comp = v.comp and ap.partenza = a.codice
group by ap.partenza, a.nome;

-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire dal 1950?

select comp, sum(durataMinuti) as durata_tot
from volo v, compagnia c
where v.comp = c.nome and c.annoFondaz >= 1950
group by comp;

-- 9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?

select a.codice, a.nome
from arrpart ap, aeroporto a 
where ap.arrivo = a.codice or ap.partenza = a.codice
group by a.nome, a.codice
having count(distinct ap.comp) = 2;

-- 10. Quali sono le città con almeno due aeroporti?

select la.citta as città
from luogoaeroporto as la
group by la.citta
having count(citta) >= 2;

-- 11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6 ore?

select v.comp
from volo v
group by v.comp
having avg(durataminuti) > 360;

-- 12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100 minuti?

select v.comp
from volo v
group by v.comp
having min(v.durataminuti) > 100;