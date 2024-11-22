-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’ ?

select wp.id, wp.nome, wp.inizio, wp.fine
from WP wp, Progetto p
where wp.progetto = p.id and p.nome = 'Pegasus';

-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno 
-- una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

select distinct p.nome, p.cognome, p.posizione  
from Persona p, AttivitaProgetto ap, Progetto pr
where ap.progetto = pr.id and pr.nome = 'Pegasus' and ap.persona = p.id
oredr by p.cognome desc; 


-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’?

select p.nome, p.cognome, p.posizione
from Persona p, Progetto pr, AttivitaProgetto ap
where pr.nome = 'Pegasus' and p.id = ap.persona and ap.progetto = pr.id 
group by p.nome, p.cognome, p.posizione
having count(ap.id) > 1; 


-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto almeno una assenza per malattia?

select distinct p.nome, p.cognome, p.posizione
from Assenza ass, Persona p 
where ass.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'  and p.id = ass.persona;

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto più di una assenza per malattia?

select distinct p.nome, p.cognome, p.posizione
from Assenza ass, Persona p 
where ass.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'  and p.id = ass.persona
group by p.nome, p.cognome, p.posizione
having count(ass.tipo) > 1;

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno
-- un impegno per didattica?

select distinct p.nome, p.cognome, p.posizione
from AttivitaNonProgettuale anp, Persona p 
where p.id = anp.persona and anp.tipo = 'Didattica' and p.posizione = 'Ricercatore';

-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
-- impegno per didattica?

select p.nome, p.cognome, p.posizione 
from Persona p, AttivitaNonProgettuale anp
where p.posizione = 'Ricercatore' and anp.tipo = 'Didattica' and p.id = anp.persona
group by p.nome, p.cognome, p.posizione
having count(anp.tipo) > 1;

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali?

select p.nome, p.cognome, p.posizione
from Persona p, AttivitaNonProgettuale anp, AttivitaProgetto ap
where ap.giorno = anp.giorno and p.id = ap.persona and p.id = anp.persona; 

-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
-- attività progettuali che attività non progettuali? Si richiede anche di proiettare il
-- giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
-- entrambe le attività.

select *
from Persona p, AttivitaNonProgettuale anp, AttivitaProgetto ap
where ap.giorno = anp.giorno and p.id = ap.persona and p.id = anp.persona;

-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali?

select distinct p.nome, p.cognome, p.posizione
from Persona p, AttivitaProgetto ap, Assenza a
where p.id = ap.persona and a.giorno = ap.giorno;

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
-- assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
-- nome del progetto, la causa di assenza e la durata in ore della attività progettuale.

select distinct p.nome, p.cognome, pr.nome, ass.giorno, ap.oreDurata as ore, ass.tipo
from Persona p, AttivitaProgetto ap, Assenza ass, Progetto pr 
where p.id = ap.persona and ass.giorno = ap.giorno and p.id = ass.persona and pr.id = ap.progetto;

-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?

select distinct wpa.nome
from WP wpa, WP wpb 
where wpa.nome = wpb.nome and wpa.progetto <> wpb.progetto;