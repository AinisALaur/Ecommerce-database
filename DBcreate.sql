CREATE TABLE Administratorius(
    id SMALLINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1);
    vardas VARCHAR(20) not null;
    el_adresas VARCHAR(60) not null;
    tel_nr VARCHAR(15) not null;
);

CREATE TABLE Uzsakymas(
    id SMALLINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1);
    uzsakovo_id INT not null;
    statusas VARCHAR(20) default 'Gautas';
    pateikimo_data TIMESTAMP not null;
    patvirtino_admin INT not null;
    patvirtinimo_data TIMESTAMP not null;
);

CREATE TABLE Preke(
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1);
    pavadinimas VARCHAR(20) not null;
    kategorija VARCHAR(20) not null;
    kaina DECIMAL(10, 2) not null;
    akcija DECIMAL(5, 2) default 0;
    sukure_admin INT not null;
    likutis INT default 0;
);

CREATE TABLE Krepselis(
    prekes_id INT PRIMARY KEY;
    uzsakymo_id INT PRIMARY KEY;
    kiekis INT not null;
    dabartine_kaina DECIMAL(10, 2) not null;
);

CREATE TABLE Uzsakovas(
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 0 INCREMENT BY 1);
    vardas VARCHAR(20) not null;
    pavarde VARCHAR(20) not null;
    el_adresas VARCHAR(60) not null;
    tel_nr VARCHAR(15) not null;
    miestas VARCHAR(15) not null;
    gatve VARCHAR(15) not null;
    namo_nr INT not null;
);