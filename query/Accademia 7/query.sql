-- 1. Qual è media e deviazione standard degli stipendi per ogni categoria di strutturati?

select posizione, avg(stipendio) as media, stddev(stipendio) as deviazione_standard
from persona
group by posizione;


-- 2. Quali sono i ricercatori (tutti gli attributi) con uno stipendio superiore alla 
-- media della loro categoria?

select id, nome, cognome, posizione, stipendio
from Persona p,
    (select avg(stipendio) as media
    from persona
    where posizione = 'Ricercatore')
where p.stipendio > media and posizione = 'Ricercatore'; 

-- 3. Per ogni categoria di strutturati quante sono le persone con uno stipendio che differisce 
-- di al massimo una deviazione standard dalla media della loro categoria?
with Dati as (
    select posizione, avg(stipendio) as media, stddev(stipendio) as deviazione_standard
    from Persona
    group by posizione
),
filtro as (
    select p.*, Dati.media, Dati.deviazione_standard
    from Persona p

)
select p.posizione, count(p.*) as Conteggio
from Persona p, Dati
where p.stipendio > (Dati.media + Dati.deviazione_standard) or p.stipendio < (Dati.media - Dati.deviazione_standard)
group by p.posizione;

select p.posizione count (p.*) as Conteggio
from Persona p
where p.stipendio >= (
    select avg(stipendio) - stddev (stipendio)
    from Persona
    where posizione = p.posizione
);
-- 4. Chi sono gli strutturati che hanno lavorato almeno 20 ore complessive in attività 
-- progettuali? Restituire tutti i loro dati e il numero di ore lavorate.

select distinct p.*, sum(oreDurata) as ore  
from Persona p, AttivitaProgetto ap 
where p.id = ap.persona 
group by p.id, p.nome, p.cognome, p.posizione, p.stipendiofrom
having sum(oreDurata) > 20;

-- 5. Quali sono i progetti la cui durata è superiore alla media delle durate di tutti i progetti? 
-- Restituire nome dei progetti e loro durata in giorni.

select pr.nome, pr.fine - pr.inizio as Durata
from Progetto pr
where pr.fine - pr.inizio > (
    select avg(fine- inizio) as Media
    from Progetto
);

-- 6. Quali sono i progetti terminati in data odierna che hanno avuto attività di 
-- tipo “Dimostrazione”? Restituire nome di ogni progetto 
-- e il numero complessivo delle ore dedicate a tali attività nel progetto.

select p.nome, sum(ap.oreDurata)
from Progetto p, AttivitaProgetto ap
where ap.tipo = 'Dimostrazione' and ap.progetto = p.id and p.fine < CURRENT_DATE
group by p.nome;

-- 7. Quali sono i professori ordinari che hanno fatto più assenze per malattia del numero 
-- di assenze medio per malattia dei professori associati? Restituire id, nome e 
-- cognome del professore e il numero di giorni di assenza per malattia.

with Conteggio_assenze as (
    select p.id, count(a.giorno) as giorni_malattia
    from Assenza a, Persona p
    where a.persona = p.id and a.tipo = 'Malattia' and p.posizione = 'Professore Associato'
    group by p.id
)
select p.id, p.nome, p.cognome, count(ass.giorno) as giorni_malattia 
from Persona p, Assenza ass, Conteggio_assenze ca
where p.id = ass.persona and p.posizione = 'Professore Ordinario' and ass.tipo = 'Malattia'
group by p.id, p.nome, p.cognome
having count(ass.giorno) > avg(ca.giorni_malattia);