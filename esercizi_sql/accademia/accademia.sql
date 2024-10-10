--CREAZIONE DATABASE

create database Accademia_3;

--CREAZONE DOMINIO

create type Strutturato as enum ('Ricercatore','Professore Associato','Professore Ordinario');

create type Lavoro_Progetto as enum ('Ricerca e Sviluppo','Dimostrazione','Management','Altro');

create type Lavoro_Non_Progettuale as enum ('Didattica','Ricerca','Missione','Incontro Dipartimentale','Incontro Accademico','Altro');

create type CausaAssenza as enum ('Chiusura Universitaria', 'Maternita', 'Malattia');

create domain PosInteger as integer check (value >= 0);

create domain StringaM as varchar(100);

create domain Numero_ore as integer check (value >= 0 and value <= 8);

create domain Denaro as real check (value >= 0);

--CREAZIONE TABELLA

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
    budget Denaro not null,
    primary key (Id),
    unique (Nome),
    check (Fine>Inizio)
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
    foreign key (Progetto) references Progetto (Id)
);

create table Attività_Progetto (
    Id PosInteger not null,
    Persona PosInteger not null,
    Progetto PosInteger not null,
    WP PosInteger not null,
    Giorno date not null,
    Tipo Lavoro_Progetto not null,
    Ore_Durata Numero_ore not null,
    primary key (Id),
    foreign key (Persona) references Persona(Id),
    foreign key (Progetto, WP) references  WP(Progetto, Id)
);

create table Attività_Non_Progettuale (
    Id PosInteger not null,
    Persona PosInteger not null,
    Tipo Lavoro_Non_Progettuale not null,
    Giorno date not null,
    Ore_Durata Numero_ore not null,
    primary key (Id),
    foreign key (Persona) references Persona(Id)
);

create table Assenza (
    Id PosInteger not null,
    Persona PosInteger not null,
    Tipo CausaAssenza not null,
    Giorno date not null,
    primary key (Id),
    unique (Persona, Giorno),
    foreign key (Persona) references Persona(Id)
);