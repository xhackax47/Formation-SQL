-- Si la base existe on la vire et création base de données (DB) smooss et Definition base courante (utilisée)

DROP DATABASE IF EXISTS smooss;
CREATE DATABASE smooss;
USE smooss;

-- Si la table existe on la vire et création table avec attributs

-- TABLE MEMBRES
DROP TABLE IF EXISTS membres;
CREATE TABLE IF NOT EXISTS membres(
    login VARCHAR(25) NOT NULL,
    motdepasse VARCHAR(16) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    code_postal VARCHAR(5) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (login)
);

-- TABLE CENTRES_INTERET

DROP TABLE IF EXISTS centres_interet;
CREATE TABLE IF NOT EXISTS centres_interet(
    intitule VARCHAR(30) NOT NULL,
    PRIMARY KEY (intitule)
);

-- TABLE GROUPES

DROP TABLE IF EXISTS groupes;
CREATE TABLE IF NOT EXISTS groupes(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    fondateur VARCHAR(25) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (fondateur) REFERENCES membres(login)  
) AUTO_INCREMENT = 1;

-- TABLE LIEUX

DROP TABLE IF EXISTS lieux;
CREATE TABLE IF NOT EXISTS lieux(
    nom VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    adresse VARCHAR(200) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    code_postal VARCHAR(5) NOT NULL,
    pays VARCHAR(50),
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    PRIMARY KEY(nom, code_postal)
);

-- TABLE EVENTS

DROP TABLE IF EXISTS events;
CREATE TABLE IF NOT EXISTS events(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    debut DATETIME NOT NULL,
    fin DATETIME,
    organisateur VARCHAR(25) NOT NULL,
    lieu_nom VARCHAR(100) NOT NULL,
    lieu_cp VARCHAR(5) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (organisateur) REFERENCES membres(login),
    FOREIGN KEY (lieu_nom, lieu_cp) REFERENCES lieux(nom, code_postal)

) AUTO_INCREMENT = 1;



-- TABLE DES ETATS MEMBRE PAR RAPPORT AUX EVENEMENTS (invité,accepté,refusé,attente....)

DROP TABLE IF EXISTS etats_membres_event;
CREATE TABLE IF NOT EXISTS etats_membres_event(
    intitule VARCHAR(15) NOT NULL,
    PRIMARY KEY (intitule)
);

-- TABLE DES ETATS MEMBRE PAR RAPPORT AUX GROUPES (invité,accepté,refusé,attente....)

DROP TABLE IF EXISTS etats_membres_groupes;
CREATE TABLE IF NOT EXISTS etats_membres_groupes(
    intitule VARCHAR(15) NOT NULL,
    PRIMARY KEY (intitule)
);



/* ASSOCIATIONS */

-- TABLE ASSOC MEMBRE / CENTRE_INTERETS

DROP TABLE IF EXISTS assoc_membre_interet;
CREATE TABLE IF NOT EXISTS assoc_membre_interet(
    login VARCHAR(25) NOT NULL,
    nom_interet VARCHAR(30) NOT NULL,
    PRIMARY KEY (login, nom_interet),
    FOREIGN KEY (login) REFERENCES membres(login),
    FOREIGN KEY (nom_interet) REFERENCES centres_interet(intitule)    
);

-- TABLE ASSOC GROUPES / CENTRE_INTERETS

DROP TABLE IF EXISTS assoc_groupes_interet;
CREATE TABLE IF NOT EXISTS assoc_groupes_interet(
    id_groupe INT NOT NULL,
    nom_interet VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_groupe, nom_interet),
    FOREIGN KEY (id_groupe) REFERENCES groupes(id),
    FOREIGN KEY (nom_interet) REFERENCES centres_interet(intitule)    
);

-- TABLE ASSOC EVENTS / CENTRE_INTERETS

DROP TABLE IF EXISTS assoc_events_interet;
CREATE TABLE IF NOT EXISTS assoc_events_interet(
    id_events INT NOT NULL,
    nom_interet VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_events, nom_interet),
    FOREIGN KEY (id_events) REFERENCES events(id),
    FOREIGN KEY (nom_interet) REFERENCES centres_interet(intitule)    
);

-- TABLE ASSOC MEMBRES / EVENTS

DROP TABLE IF EXISTS assoc_membres_events;
CREATE TABLE IF NOT EXISTS assoc_membres_events(
    id_events INT NOT NULL,
    login_membre VARCHAR(25) NOT NULL,
    etat VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_events, login_membre),
    FOREIGN KEY (id_events) REFERENCES events(id),
    FOREIGN KEY (login_membre) REFERENCES membres(login),
    FOREIGN KEY (etat) REFERENCES etats_membres_event(intitule) 
);    

-- TABLE ASSOC MEMBRES / GROUPES

DROP TABLE IF EXISTS assoc_membres_groupes;
CREATE TABLE IF NOT EXISTS assoc_membres_groupes(
    id_group INT NOT NULL,
    login_membre VARCHAR(25) NOT NULL,
    etat VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_group, login_membre),
    FOREIGN KEY (id_group) REFERENCES groupes(id),
    FOREIGN KEY (login_membre) REFERENCES membres(login),
    FOREIGN KEY (etat) REFERENCES etats_membres_groupes(intitule) 
);

-- MODIFICATIONS DE DONNEES SQL

-- Insertion de données dans table 

/*

-- Ajouter ligne dans table membres --

INSERT INTO membres (login, motdepasse, prenom, nom, email, code_postal)
VALUE 
('formation', 'Formation01', 'Samy', 'Chaabi', 'xhackax47@gmail.com', '13003'),
('formation2', 'Formation01', 'Samy2', 'Chaabi2', 'xhackax47@gmail.com', '13003'),
('formation3', 'Formation01', 'Samy3', 'Chaabi3', 'xhackax47@gmail.com', '13003'),
('formation4', 'Formation01', 'Samy4', 'Chaabi4', 'xhackax47@gmail.com', '13003'),
('formation5', 'Formation01', 'Samy5', 'Chaabi5', 'xhackax47@gmail.com', '13003'),
('formation6', 'Formation01', 'Samy6', 'Chaabi6', 'xhackax47@gmail.com', '13003');

*/

-- Ajouter ligne dans table groupes --

/* 

INSERT INTO groupes (id, nom, fondateur) VALUES (12, 'test 12', 'formation'); 

INSERT INTO groupes (nom, description, fondateur) 
VALUES 
('GROUPE 12', 'Groupe de travail sur le chiffre 12', 'formation'), 
('GROUPE 13', 'Groupe de travail sur le chiffre 13', 'formation2'), 
('GROUPE 14', 'Groupe de travail sur le chiffre 14', 'formation3'); 
*/


-- Vider une table

/*  
TRUNCATE TABLE membres
TRUNCATE TABLE groupes
*/


