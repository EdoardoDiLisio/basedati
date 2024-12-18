create table Nazione(
    nome varchar not null,
    primary key(nome)
);

create table Regione(
    nome varchar not null,
    nazione varchar not null,
    primary key(nome, nazione)
    foreign key (nazione) references Nazione(nome)
);

create table Citta(
    nome varchar not null,
    regione varchar not null,
    nazione varchar not null,
    primary key(nome, regione, nazione),
    foreign key (regione, nazione) references Regione(nome, nazione)
);

create table Sede(
    indirizzo Indirizzo not null,
    nome varchar not null,
    id_sede serial primary key not null,
    citta varchar not null,
    regione varchar not null,
    nazione varchar not null,
    foreign key (citta, regione, nazione) references Regione(nome, regione, nazione)
);

create table Sala(
    nome varchar not null,
    id_sede integer not,
    primary key(nome, id_sede),
    foreign key (id_sede) references Sede(id_sede)
);

create table Settore(
    nome varchar not null,
    id_settore serial primary key not null,
    sala varchar not null,
    sede integer not null,
    unique(nome, sala, sede),
    foreign key (sala, sede) references Sala(nome, id_sede) 
);

create table Posto(
    fila integer not null,
    colonna integer not null,
    settore integer not null,
    primary key(fila, colonna, settore),
    foreign key (settore) references Settore(id_settore)
);

create table Artista(
    nome varchar not null,
    cognome varchar not null,
    nome_arte varchar,
    id_artista serial primary key
);

create table TipologiaSpettacolo(
    nome varchar primary key not null
);

create table Genere(
    nome varchar primary key not null
);

-- essendo 1* e 0* l'associazione tra spettacolo e artista, devo creare una tabella a parte (artistaspettacolo)
-- mentre tra tipologiaspettacolo e genere l'associazione è 0* e 1 

create table Spettacolo(
    nome varchar not null,
    durata_minuti integer not null,
    id_spettacolo serial primary key not null,
    genere varchar not null,
    tipologia_spettacolo varchar not null,
    primary key (id_spettacolo)
    foreign key (genere) references Genere(nome),   
    foreign key (tipologia_spettacolo) references TipologiaSpettacolo(nome)
    -- v.incl id_artista occorre in Partecipa(spettacolo)              
);
-- QUANDO HO DUE FOREIGN KEY PROVENIENTI DA DUE TABELLE DIVERSE DEVO DIVINDERLE 
-- E LAVORARLE SEPARATAMENTE COME IN SPETTACOLO

create table Partecipa(
    id_artista integer not null,
    id_spettacolo integer not null,
    primary key (id_artista, id_spettacolo),
    foreign key (id_artista) references Artista(id_artista),
    foreign key (id_spettacolo) references Spettacolo(id_spettacolo)
);

create table Evento(
    data data not null,
    orario time not null,
    id_evento serial not null,
    sala varchar not null,
    id_spettacolo integer not null,
    sede varchar not null,
    foreign key(id_spettacolo) references Spettacolo(id_spettacolo),
    foreign key (sala, sede) references Sala(nome, id_sede)
);

create table Utente(
    nome varchar not null,
    cognome varchar not null,
    cf CF primary key not null 
);

create table Prenotazione(
    id_prenotazione serial primary key not null,
    istante data not null,
    utente CF not null,
    id_evento integer not null,
    foreign key (utente) references Utente(cf),
    foreign key (id_evento) references Evento(id_evento) 
);

create table TipoTariffa(
    nome varchar primary key not null
);

create table Tariffa(
    prezzo Denaro not null,
    tipo_tariffa varchar not null,
    settore integer not null,
    evento integer not null,
    primary key (tipo_tariffa, settore, evento)
    foreign key (tipo_tariffa) references TipoTariffa(nome),
    foreign key (settore) references Settore(id_settore),
    foreign key (evento) references Evento(id_evento)
);

create table PrePosto(
    id_prenotazione integer not null,
    fila integer not null, 
    colonna integer not null,
    settore integer not null,
    tipo_tariffa varchar not null,
    primary key (prenotazione, fila, colonna, settore)
    foreign key (id_prenotazione) references Prenotazione(id_prenotazione),
    foreign key (fila, colonna, settore) references Posto(fila, colonna, settore)
    foreign key (tipo_tariffa) references TipoTariffa(nome)
);