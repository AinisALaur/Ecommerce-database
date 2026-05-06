CREATE TABLE Administratorius(
    id SMALLINT PRIMARY KEY 
        GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1),
    vardas VARCHAR(20) not null,
    el_adresas VARCHAR(60) not null,
    tel_nr VARCHAR(15) not null
);

CREATE TABLE Preke(
    id INTEGER PRIMARY KEY 
        GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1),
    pavadinimas VARCHAR(20) not null,
    kategorija VARCHAR(20) not null,
    kaina DECIMAL(10, 2) not null,
    akcija DECIMAL(5, 2) default 0,
    sukure_admin INT not null,
    likutis INT default 0,

    CONSTRAINT kaina_tinkama_preke
        CHECK (kaina > 0),
    
    CONSTRAINT akcija_tinkama_preke
        CHECK (akcija >= 0 AND akcija <= 100),

    CONSTRAINT likutis_tinkamas_preke
        CHECK (likutis >= 0),

    CONSTRAINT i_admin_preke
        FOREIGN KEY (sukure_admin)
        REFERENCES Administratorius ON DELETE NO ACTION
                                    ON UPDATE CASCADE 
);

CREATE TABLE Uzsakovas(
    id INTEGER PRIMARY KEY 
        GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1),
    vardas VARCHAR(20) not null,
    pavarde VARCHAR(20) not null,
    el_adresas VARCHAR(60) not null,
    tel_nr VARCHAR(15) not null,
    miestas VARCHAR(15) not null,
    gatve VARCHAR(15) not null,
    namo_nr INT not null,

    CONSTRAINT namo_nr_tinakamas_uzsakovas
        CHECK (namo_nr > 0)
);

CREATE TABLE Uzsakymas(
    id SMALLINT PRIMARY KEY 
        GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1),
    uzsakovo_id INT not null,
    statusas VARCHAR(20) default 'Gautas',
    pateikimo_data TIMESTAMP not null,
    patvirtino_admin INT,
    patvirtinimo_data TIMESTAMP,

    CONSTRAINT statusas_tinkamas_uzsakymas
        CHECK (statusas in ('Gautas', 'Vykdomas', 'Baigtas')),

    CONSTRAINT data_tinkama_uzsakymas
        CHECK (patvirtinimo_data > pateikimo_data),

    CONSTRAINT i_admin_uzsakymas
        FOREIGN KEY (patvirtino_admin)
        REFERENCES Administratorius ON DELETE NO ACTION
                                    ON UPDATE CASCADE, 
    
    CONSTRAINT i_uzsakovas_uzsakymas
        FOREIGN KEY (uzsakovo_id)
        REFERENCES Uzsakovas ON DELETE NO ACTION
                             ON UPDATE CASCADE
);

CREATE TABLE Krepselis(
    prekes_id INT NOT NULL,
    uzsakymo_id INT NOT NULL,
    PRIMARY KEY (prekes_id, uzsakymo_id),
    kiekis INT not null,
    dabartine_kaina DECIMAL(10, 2) not null,

    CONSTRAINT kiekis_tinkamas_krepselis
        CHECK (kiekis > 0),

    CONSTRAINT kaina_tinkama_krepselis
        CHECK (dabartine_kaina > 0),


    CONSTRAINT i_preke_krepselis
        FOREIGN KEY (prekes_id)
        REFERENCES Preke ON DELETE NO ACTION
                         ON UPDATE CASCADE, 

    CONSTRAINT i_uzsakymas_krepselis
        FOREIGN KEY (uzsakymo_id)
        REFERENCES Uzsakymas ON DELETE NO ACTION
                             ON UPDATE CASCADE
);