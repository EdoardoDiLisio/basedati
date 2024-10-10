create table Nazione(
    nome varchar not null,
    primary key(nome)
);
create table Regione(
    nome varchar not null,
    nazione varchar not null,
    primary key(nome, nazione),
    foreign key(nazione) references Nazione(nome)
);
create table Città(
    nome varchar  not null,
    regione varchar not null,
    nazione varchar not null,
    primary key(nome, regione, nazione)
);
create table Sede(
    indirizzo Indirizzo not null,
    nome varchar not null,
    id_sede serial primary key not null,
    città varchar not null,
    regione varchar not null,
    nazione varchar not null,
    foreign key (citta, regione, nazione) references Regione (nome, regione, nazione)
);
create table Sala(
    nome varchar not null,
    id_sede integer not null,
    primary key (nome, id_sede),
    foreign key (id_sede) references Sede(id_sede)
);
create table Settore(
    nome varchar not null,
    id_settore serial primary key not null,
    id_sede integer not null,
    sala varchar not null,
    unique(nome, sala, sede),
    foreign key (sala, id_sede) references Sala(nome, id_sede)
);
create table Posto(
    fila integer not null,
    colonna integer not null,
    settore integer not null,
    primary  key (fila, colonna, settore),
    foreign key (settore) references Settore(id_settore)
);
create table Artista(
    nome varchar not null,
    cognome varchar not null,
    nome_arte varchar,
    id_artista serial primary key,
);
create table TipologiaSpettacolo(
    nome varchar primary key not null,
);
create table Genere(
    nome varchar primary key not null
);
create table Spettacolo(
    nome varchar not null,
    durata_minuti integer not null,
    id_spettacolo  serial primary key not null,
    genere varchar not null,
    tipologia_spettacolo varchar not null,
    primary  key (id_spettacolo),
    foreign key (genere) references Genere(nome),
    foreign key (tipologia_spettacolo) references TipologiaSpettacolo(nome)
);
create table  Partecipa(
    id_artista integer not null,
    id_spettacolo integer not null,
    primary key (id_artista, id_spettacolo),
    foreign key (id_artista) references Artista(id_artista),
    foreign key (id_spettacolo) references Spettacolo(id_spettacolo)
);
create table  Evento(
    data  date not null,
    orario  integer not null,
    id_evento serial not null,
    sala varchar not null,
    foreign key (id_spettacolo)  references Spettacolo(id_spettacolo),
    foreign key (sala) references Sala(nome, id_sede)

);

create table Utente(
    nome  varchar not null,
    cognome varchar not null,
    cf cF  primary  key not null
);
create table  Prenotazione(
    id_prenotazione  serial primary key not null,
    instante data not null,
    utente varchar not null,
    id_evento integer not null,
    foreign key (utente) references Utente(cF),
    foreign  key (id_evento) references Evento(id_evento)
);
create table Tariffa(
    prezzo_Denaro not null,
    id_tariffa serial not null
    tipo_tariffa  varchar not null,
    primary  key (id_tariffa, tipo_tariffa),
    foreign key (id_tariffa) references Prenotazione(id_prenotazione)
);
create table PrePosto(
    id_prenotazione integer not null,
    fila integer  not null,
    colonna integer not null,
    settore  integer not null,
    tipo_tariffa  integer not null,
    foreign key (prenotazione) references Prenotazione(prenotazione),
    foreign key (fila, colonna, settore) references Fila(fila, colonna, settore)
);
