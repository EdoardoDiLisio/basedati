-- CREAZIONE DATABASE--

create database Accademia_3;

-- CREAZIONE DOMINIO --

create type Strutturato as enum ('Ricercatore', 'Professore Associato', 'Professore Ordinario');

create type Lavoro_Progetto as enum ('Ricerca e sviluppo', 'Dimostrazione', 'Management', 'Altro');

create type Lavoro_Non_Progettuale as enum ('Didattica', 'Ricerca', 'Missione', 'Incontro Dipartimentale', 'Incontro Accademico', 'Altro');

create type Causa_Assenza as enum ('Chiusura universitaria', 'Maternità', 'Malattia');

create domain PosInteger as integer check (value >= 0);

create domain StringaM as varchar(100);

create domain Numero_Ore as integer check (value >= 0 and value <= 8);

create domain Denaro as real check (value >= 0);

-- CREAZIONE TABELLE --

create table Persona (
    Id PosInteger not null,
    Nome StringaM not null,
    Cognome StringaM not null,
    Posizione Strutturato not null,
    Stipendio Denaro not null,
    primary key (Id)
);

create table Progetto (
    Id PosInteger not null,
    Nome StringaM not null,
    Inizio date not null,
    Fine date not null,
    Budget Denaro not null,
    primary key (Id),
    unique (Nome),
    check (Fine > Inizio)
);

create table WP (
    Progetto PosInteger not null,
    Id PosInteger not null,
    Nome StringaM not null,
    Inizio date not null,
    Fine date not null,
    primary key (Progetto, Id),
    unique (Progetto, Nome),
    check (Fine > Inizio),
    foreign key (Progetto) references Progetto(Id)
);

create table AttivitaProgetto (
    Id PosInteger not null,
    persona PosInteger not null,
    progetto PosInteger not null,
    Wp PosInteger not null,
    Giorno date not null,
    Tipo Lavoro_Progetto not null,
    oreDurata Numero_Ore not null,
    foreign key (persona) references Persona(Id),
    foreign key (progetto, Wp) references WP(progetto, Id),
    primary key (Id) 
);

create table AttivitaNonProgettuale (
    id PosInteger not null,
    persona PosInteger not null,
    tipo Lavoro_Non_Progettuale not null,
    giorno date not null,
    oreDurata Numero_Ore not null,
    primary key (id),
    foreign key (persona) references Persona(Id) 
);

create table Assenza (
    id PosInteger not null,
    persona PosInteger not null,
    tipo Causa_Assenza not null,
    giorno date not null,
    unique (persona, giorno),
    primary key (id),
    foreign key (persona) references Persona(Id)
);