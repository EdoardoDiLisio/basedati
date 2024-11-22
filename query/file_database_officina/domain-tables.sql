create table Nazione (
    nome varchar not null,
    primary key(nome)
);

create table Regione(
    nome varchar not null,
    nazione varchar not null,
    primary key (nome, nazione),
    foreign key nazione references Nazione(nome)
);

create table Citta(
    nome varchar not null,
    regione varchar not null,
    nazione varchar not null,
    primary key(nome, regione, nazione),
    foreign key (regine) references Regione(nome, nazione)
);


create table Officina(
    nome varchar not null,
    indirizzo Indirizzo not null,
    id integer not null,
    primary key (id)
);

create table Riparazione(
    codice integer not null,
    inizio timestamp not null,
    riconsegna timestamp,
    officina varchar not null,
    primary key(codice),
    foreign key (officina) references Officina(id)
);


create table TipoVeicolo(
    nome varchar not null,
    primary key(nome)
);


create table Marca(
    nome varchar not null,
    primary key (nome)
);

create table Modello(
    nome varchar not null,
    tipoVeicolo varchar not null,
    marca varchar not null,
    primary key(nome, marca)
    foreign key(tipoVeicolo) references TipoVeicolo(nome),
    foreign key(marca) references Marca(nome)
);


create table Veicolo(
    targa Targa not null,
    immatricolazione integer not null,
    modello varchar not null,
    cliente CodFis not null,
    marca varchar not null,
    primary key(targa),
    foreign key(modello, marca) references Modello(nome, marca),
    foreign key(cliente) references Cliente(persona)
);


create table Cliente(
    persona CodFis not null,
    primary key(persona),
    foreign key(persona) references Persona(cf)
    v.incl.persona occorre in Veicolo(cliente)
);


create table Persona(
    cf CodFis not null,
    nome varchar not null,
    indirizzo Indirizzo not null,
    telefono varchar not null,
    primary key(cf)
);


create table Staff(
    persona CodFis not null,
    primary key(persona),
    foreign key(persona) references Persona(cf)
);


create table Direttore(
    nascita date not null,
    staff CodFis not null,
    persona CodFis not null,
    primary key (staff, persona),
    foreign key(staff) references Staff(persona)
);


create table Dipendente(
    staff CodFis not null,
    persona CodFis not null,
    primary key (staff, persona),
    foreign key(staff) references Staff(persona)
);