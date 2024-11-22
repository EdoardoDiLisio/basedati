--1

select distinct cognome
from Persona;

--2

select *
from Persona
where posizione = 'Ricercatore';

--3

select * 
from Persona
where posizione = 'Professore Associato' and cognome like 'V%';

--4

select *
from Persona
where posizione <> 'Ricercatore' and cognome like 'V%';

--5

select *
from Progetto
where fine < CURRENT_DATE;

--6

select nome
from Progetto
order by inizio asc;

--7

select nome
from WP 
order by nome asc;

--8

select distinct tipo
from Assenza;

--9

select distinct tipo
from AttivitaProgetto;

--10

select distinct giorno
from AttivitaNonProgettuale
where tipo = 'Didattica';


