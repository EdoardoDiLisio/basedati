-- 1. Quanti sono gli strutturati di ogni fascia?

SELECT posizione, count(*) as numero
FROM persona
GROUP BY posizione;

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

SELECT count(*)
FROM persona p
WHERE p.stipendio >= '40000';

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

SELECT count(nome) as progetti
FROM progetto p
WHERE p.budget >= '50000' and p.fine < CURRENT_DATE; 

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’ ?

SELECT avg(oredurata) as media, max(oredurata) as massimo, min(oredurata) as minimo
FROM attivitaprogetto ap, progetto p
WHERE p.nome = 'Pegasus' and p.id = ap.progetto;

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?

select distinct p.id as id_persona, p.nome, p.cognome, avg(oredurata) as media, min(oredurata) as minimo, max(oredurata) as massimo
from persona p, progetto pr, attivitaprogetto ap
where ap.progetto = pr.id and pr.nome = 'Pegasus' and p.id = ap.persona
group by p.id, p.nome, p.cognome;

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?

select p.id as id_persona, p.nome, p.cognome, sum(oredurata) as ore_didattica
from persona p, attivitanonprogettuale anp
where p.id = anp.persona and anp.tipo = 'Didattica'
group by p.id, nome, cognome;

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?

select avg(stipendio) as media, min(stipendio) as minimo, max(stipendio) as massimo
from persona p
where p.posizione = 'Ricercatore';

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?

select posizione, avg(stipendio) as media, min(stipendio) as minimo, max(stipendio) as massimo
from persona
group by posizione;

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?

select ap.progetto as id_progetto, pr.nome as progetto,  sum(ap.oredurata) as totale_ore
from attivitaprogetto ap, persona p, progetto pr
where p.nome = 'Ginevra' and p.cognome = 'Riva' and p.id = ap.persona and pr.id = ap.progetto
group by ap.progetto, pr.nome;

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?

select distinct ap1.progetto, pr.nome
from attivitaprogetto ap1, attivitaprogetto ap2, progetto pr
where ap1.id <> ap2.id
    and ap1.progetto = ap2.progetto
    and ap1.persona <> ap2.persona
    and ap1.progetto = pr.id;

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?

select distinct p.id, p.nome, p.cognome
from persona p, attivitaprogetto ap1, attivitaprogetto ap2
where p.id = ap1.persona
    and p.id = ap2.persona
    and ap2.progetto <> ap1.progetto
    and p.posizione = 'Professore Associato';