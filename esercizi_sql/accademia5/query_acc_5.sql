-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome
-- ‘Pegasus’ ?

select w.id, w.nome, w.inizio, w.fine
from WP w, progetto p
where p.nome = 'Pegasus' and p.id = w.progetto;

-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno
-- una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

select distinct p.id, p.nome, p.cognome, p.posizione
from Persona p, attivitaprogetto a, Progetto pr 
where pr.nome = 'Pegasus' and pr.id = a.progetto and a.persona = p.id
order by p.cognome desc;

-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’ ?

select distinct p.id, p.nome, p.cognome, p.posizione
from persona p, attivitaprogetto a, progetto pr
where pr.nome = 'Pegasus' and pr.id = a.progetto and a.persona = p.id
group by p.id, p.nome, p.cognome, p.posizione
having count(a.persona) > 1;

-- Modo corretto di svolgerlo

select distinct s.id, s.nome, s.cognome, s.posizione
from attivitaprogetto a1, attivitaprogetto a2, persona s, progetto p
where a1.id <> a2.id
    and a1.progetto = a2.progetto
    and a1.persona = a2.persona
    and a1.persona = s.id
    and a1.progetto = p.id
    and p.nome = 'Pegasus';

-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto almeno una assenza per malattia?

select distinct p.id, p.nome, p.cognome
from assenza a, persona p
where a.persona = p.id
    and tipo = 'Malattia'
    and posizione = 'Professore Ordinario'


-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto più di una assenza per malattia?

select distinct s.id, s.nome, s.cognome
from persona s, assenza a1, assenza a2
where a1.persona = s.id
    and a1.id <> a2.id
    and a2.persona = s.id
    and a1.tipo = 'Malattia'
    and a2.tipo = 'Malattia'
    and s.posizione = 'Professore Ordinario';

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno
-- un impegno per didattica?

select distinct p.id, p.nome, p.cognome
from persona p, attivitanonprogettuale a
where p.id = a.persona
    and a.tipo = 'Didattica'
    and p.posizione = 'Ricercatore';

-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
-- impegno per didattica?

select distinct p.id, p.nome, p.cognome
from persona p, attivitanonprogettuale a1, attivitanonprogettuale a2
where p.id = a1.persona
    and p.id = a2.persona
    and a1.tipo = 'Didattica'
    and a2.tipo = 'Didattica'
    and a1.id <> a2.id
    and p.posizione = 'Ricercatore';

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali?

select distinct p.id, p.nome, p.cognome
from persona p, attivitaprogetto ap, attivitanonprogettuale anp
where p.id = ap.persona
    and ap.giorno = anp.giorno
    and p.id = anp.persona;

-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali? Si richiede anche di proiettare il
-- giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
-- entrambe le attività.

select p.id, p.nome, p.cognome, pr.nome, anp.tipo, ap.oredurata, anp.oredurata, ap.giorno
from persona p, attivitaprogetto ap, attivitanonprogettuale anp, progetto pr
where p.id = ap.persona
    and ap.giorno = anp.giorno
    and p.id = anp.persona
    and ap.progetto = pr.id;

-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali?

select distinct p.id, p.nome, p.cognome
from persona p, attivitaprogetto ap, assenza a
where p.id = ap.persona
    and a.persona = p.id
    and ap.giorno = a.giorno;

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
-- nome del progetto, la causa di assenza e la durata in ore della attività progettuale.

select distinct p.id, p.nome, p.cognome, pr.nome, ap.giorno, a.tipo, ap.oredurata
from persona p, attivitaprogetto ap, assenza a, progetto pr
where p.id = ap.persona
    and a.persona = p.id
    and ap.giorno = a.giorno
    and pr.id = ap.progetto;

-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?

select distinct w.nome
from wp w, wp v
where w.nome = v.nome
    and w.progetto <> v.progetto;