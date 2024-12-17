CREATE TABLE Socio (
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    cf VARCHAR(16) PRIMARY KEY
);

CREATE TABLE Varco (
    codice INT PRIMARY KEY
);

CREATE TABLE Zona (
    nome VARCHAR(50) PRIMARY KEY,
    capienza INT NOT NULL CHECK (capienza > 0)
);

CREATE TABLE Accesso (
    id SERIAL PRIMARY KEY,  
    inizio TIMESTAMP NOT NULL, 
    direzione VARCHAR(3) CHECK (direzione IN ('in', 'out')), 
    cf_socio VARCHAR(16) NOT NULL, 
    codice_varco INT NOT NULL, 
    FOREIGN KEY (cf_socio) REFERENCES Socio(cf) ON DELETE CASCADE,
    FOREIGN KEY (codice_varco) REFERENCES Varco(codice) ON DELETE CASCADE
);


CREATE TABLE Raggiunge (
    codice_varco INT NOT NULL, 
    nome_zona VARCHAR(50) NOT NULL,
    direzione VARCHAR(3) NOT NULL CHECK (direzione IN ('in', 'out')), 
    PRIMARY KEY (codice_varco, nome_zona),
    FOREIGN KEY (codice_varco) REFERENCES Varco(codice) ON DELETE CASCADE,
    FOREIGN KEY (nome_zona) REFERENCES Zona(nome) ON DELETE CASCADE
);