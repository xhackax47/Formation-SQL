DROP DATABASE IF EXISTS smousse;

--
-- On crée la base de données
--
CREATE DATABASE IF NOT EXISTS smousse;
USE smousse;    

--
-- Table des membres
--
DROP TABLE IF EXISTS membres;
CREATE TABLE IF NOT EXISTS membres (
  login VARCHAR(25) NOT NULL,
  motdepasse VARCHAR(16) NOT NULL,
  prenom VARCHAR(30) NOT NULL,
  nom VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  code_postal VARCHAR(5) NOT NULL,
  PRIMARY KEY (login)
);

--
-- Table des groupes
--
DROP TABLE IF EXISTS groupes;
CREATE TABLE IF NOT EXISTS groupes (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(80) NOT NULL,
  description TEXT NOT NULL,
  fondateur VARCHAR(25) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (fondateur) REFERENCES membres (login)
) AUTO_INCREMENT=1;

--
-- Table des centres d'intérêt
--
DROP TABLE IF EXISTS centres_interet;
CREATE TABLE IF NOT EXISTS centres_interet (
  intitule VARCHAR(30) NOT NULL,
  PRIMARY KEY (intitule)
);

--
-- Table d'association : groupes / centres d'intérêts
--
DROP TABLE IF EXISTS assoc_groupe_interet;
CREATE TABLE IF NOT EXISTS assoc_groupe_interet (
  nom_interet VARCHAR(30) NOT NULL,
  id_groupe INT NOT NULL,
  PRIMARY KEY (id_groupe, nom_interet),
  FOREIGN KEY (id_groupe) REFERENCES groupes (id),
  FOREIGN KEY (nom_interet) REFERENCES centres_interet (intitule)
);

--
-- Table d'association : membres / centres d'intérêts
--
DROP TABLE IF EXISTS assoc_membre_interet;
CREATE TABLE IF NOT EXISTS assoc_membre_interet (
  login VARCHAR(25) NOT NULL,
  nom_interet VARCHAR(30) NOT NULL,
  PRIMARY KEY (login,nom_interet),
  FOREIGN KEY (login) REFERENCES membres (login),
  FOREIGN KEY (nom_interet) REFERENCES centres_interet (intitule)
);

--
-- Table des statuts dans un groupe (attente, approuve, banni...)
--
DROP TABLE IF EXISTS statuts_membre_groupe;
CREATE TABLE IF NOT EXISTS statuts_membre_groupe (
  etat VARCHAR(15) NOT NULL,
  PRIMARY KEY (etat)
);

--
-- Table d'association : membres / groupes
--
DROP TABLE IF EXISTS assoc_membre_groupe;
CREATE TABLE IF NOT EXISTS assoc_membre_groupe (
  id_groupe INT NOT NULL,
  login VARCHAR(25) NOT NULL,
  statut VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_groupe,login),
  FOREIGN KEY (id_groupe) REFERENCES groupes (id),
  FOREIGN KEY (login) REFERENCES membres (login),
  FOREIGN KEY (statut) REFERENCES statuts_membre_groupe (etat)
);

--
-- Table des lieux
--
DROP TABLE IF EXISTS lieux;
CREATE TABLE IF NOT EXISTS lieux (
  nom VARCHAR(50) NOT NULL,
  description TEXT NOT NULL,
  adresse VARCHAR(120) NOT NULL,
  ville VARCHAR(50) NOT NULL,
  code_postal VARCHAR(5) NOT NULL,
  latitude FLOAT NOT NULL,
  longitude FLOAT NOT NULL,
  PRIMARY KEY (nom,code_postal)
);

--
-- Table des evenements
--
DROP TABLE IF EXISTS evenements;
CREATE TABLE IF NOT EXISTS evenements (
  id INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  debut DATETIME NOT NULL,
  fin DATETIME,
  id_groupe INT NOT NULL,
  lieu VARCHAR(50) NOT NULL,
  code_postal VARCHAR(5) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_groupe) REFERENCES groupes (id),
  FOREIGN KEY (lieu, code_postal) REFERENCES lieux (nom, code_postal)
) AUTO_INCREMENT=1 ;

-- Table de Ceuxquiontuno

CREATE TABLE IF NOT EXISTS ceuxquiontuno (
  login VARCHAR(25) NOT NULL,
  prenom VARCHAR(30) NOT NULL,
  nom VARCHAR(50) NOT NULL
);

-- Insertion données dans table ceuxquiontuno à partir de la table membres

INSERT INTO ceuxquiontuno
SELECT login, prenom, nom FROM membres m WHERE m.nom LIKE '%o%';

--
-- Table des statuts utilisateurs pour un evenements (interesse, file_dattente, inscrit...)
--
DROP TABLE IF EXISTS statuts_membre_evenement;
CREATE TABLE IF NOT EXISTS statuts_membre_evenement (
  etat VARCHAR(15) NOT NULL,
  PRIMARY KEY (etat)
);

--
-- Table d'association : membres / evenements
--
DROP TABLE IF EXISTS assoc_membre_evenement;
CREATE TABLE IF NOT EXISTS assoc_membre_evenement (
  id_evenement INT NOT NULL,
  login VARCHAR(20) NOT NULL,
  statut VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_evenement,login),
  FOREIGN KEY (id_evenement) REFERENCES evenements (id),
  FOREIGN KEY (login) REFERENCES membres (login),
  FOREIGN KEY (statut) REFERENCES statuts_membre_evenement (etat)
);

-- --------------------------- INSERTION DE VALEURS ----------------------------

INSERT INTO membres (`login`, `motdepasse`, `prenom`, `nom`, `email`, `code_postal`) 
	VALUES
('fred', 'toto', 'Fred', 'Mandrea', 'fred@notanumber.fr', '34400'),
('bono', 'joshua', 'Paul David', 'Hewson', 'bono@u2.com', '06000'),
('tyorke', 'okcomputer', 'Thom', 'Yorke', 'thom@radiohead.co.uk', '34000'),
('bjork', 'sugarcubes', 'Björk', 'Guðmundsdóttir', 'bjork@bjork.com', '75000'),
('lorde', 'greenlight', 'Ella Marija Lani', 'Yelich-O Connor', 'ella@lorde.com', '45550'),
('blini', 'xvft', 'Pauline', 'Carton', 'pauline@u2.com', '06000'),
('parigo', 'paris', 'Parisien', 'DeMerde', 'parisien@merde.com', '75000'),
('marseille', 'marseille', 'Marseillais', 'Forza', 'marseille@forza.com', '13000');


INSERT INTO groupes ( `nom`, `description`, `fondateur`) 
	VALUES 
('Sonorités électroniques', 'Groupe pour les amateurs d\'expérimentations musicales numériques', 'tyorke'),
('Bons sons acoustiques et électriques', 'Pour ceux qui aiment prendre une basse, une batterie et une gratte, brancher le tout et faire du joli bruit !', 'bono'),
('Les amis de Wolfgang', 'Ceux qui aiment bien les instuments à cordes bien synchronisés', 'bjork'),
('Sweet Dreams','Pour les amateurs de sucreries et de weed', 'bono');

INSERT INTO centres_interet (`intitule`) 
	VALUES 
	('Rock'),
	('Pop'),
	('Expérimental'),
	('Progressif'),
	('Jazz'),
	('Classique');

INSERT INTO assoc_groupe_interet (`nom_interet`, `id_groupe`)
	VALUES
	('Rock', '1'),
	('Progressif', '1'),
  ('Pop', '1'),
  ('Pop', '2'),
  ('Expérimental', '2'),
  ('Classique', '3'),
  ('Jazz', '3');

INSERT INTO statuts_membre_groupe (`etat`) VALUES
('Approuvé'),
('En attente'),
('Modérateur'),
('Refusé');

INSERT INTO statuts_membre_evenement (`etat`) VALUES
('Confirmé'),
('Décliné'),
('Intéressé'),
('Liste d\'attente');

INSERT INTO assoc_membre_groupe (`id_groupe`, `login`, `statut`) VALUES 
('2', 'fred', 'Approuvé');

INSERT INTO assoc_membre_interet (`login`, `nom_interet`) VALUES 
('bjork', 'Pop'),
('bjork', 'Classique'),
('fred', 'Pop');

INSERT INTO lieux (`nom`, `description`, `adresse`, `ville`, `code_postal`, `latitude`, `longitude`)
  VALUES
  ('Rockstore', 'Un lieu pour le Rock !', '20 Rue de Verdun', 'Montpellier', '34000', '43.6061888', '3.8812334'),
  ('Le Transbordeur', 'Lieu mythique des concerts indépendants lyonnais.', '3 Boulevard de Stalingrad', 'Villeurbanne', '69100', '45.783808', '4.8605979');

INSERT INTO evenements (`id`, `nom`, `description`, `debut`, `fin`, `id_groupe`, `lieu`, `code_postal`) 
VALUES 
(NULL, 'Du rock au Transbo', 'Le plus grand groupe du monde dans la petite salle de Villeurbanne', '2018-04-18 20:00:00', NULL, '2', 'Le Transbordeur', '69100'),
(NULL, 'Transbo', 'Le plus grand groupe du monde dans la petite salle de Villeurbanne', '2017-04-18 20:00:00', NULL, 2, 'Le Transbordeur', '69100'),
(NULL, 'Du rock', 'Le plus grand groupe du monde dans la petite salle de Villeurbanne', '2016-04-18 20:00:00', NULL, 2, 'Le Transbordeur', '69100'),
(NULL, 'rock', 'Le plus grand groupe du monde dans la petite salle de Villeurbanne', '2016-04-18 20:00:00', NULL, 2, 'Rockstore', '34000');

INSERT INTO assoc_membre_evenement (`id_evenement`, `login`, `statut`) 
VALUES 
(1, 'lorde', 'Confirmé'),
(2, 'lorde', 'Confirmé'),
(3, 'lorde', 'Confirmé'),
(4, 'lorde', 'Confirmé');


/*

-- Faire recherche email fondateur avec id 2 avec produit scalaire --

SELECT email FROM membres, groupes
WHERE membres.login = groupes.fondateur
AND groupes.id = 2;

-- Faire recherche email fondateur avec id 2 en joignant 2 tables --

SELECT email FROM membres JOIN groupes
ON membres.login = groupes.fondateur
WHERE groupes.id = 2;

-- Faire recherche email fondateur avec id 2 par Requete imbriquée --

SELECT email FROM membres,
WHERE login = (SELECT fondateur FROM groupes WHERE id = 2);

-- Faire recherche email des fondateurs en produit scalire et sans doublons

SELECT DISTINCT email FROM membres, groupes
WHERE membres.login = groupes.fondateur;

-- Faire recherche email des fondateurs en joignant 2 tables et sans doublons --

SELECT DISTINCT email FROM membres JOIN groupes
ON membres.login = groupes.fondateur;

-- Faire recherche des interets de Björg en joignant 3 tables (CI, AMI, M) --

SELECT ci.intitule 
FROM centres_interet ci 
JOIN assoc_membre_interet ami 
ON ci.intitule = ami.nom_interet 
JOIN membres m 
ON m.login = ami.login 
WHERE prenom = 'Björk';

-- Faire recherche groupes partageant interet avec utilisateur nom = 'Mandrea' avec utilisation alias (AS) --

1ere methode

SELECT m.nom AS user, g.nom AS groupe,ci.intitule AS interet 
FROM membres m
JOIN assoc_membre_interet ami ON m.login = ami.login
JOIN centres_interet ci ON ami.nom_interet = ci.intitule
JOIN assoc_groupe_interet agi ON agi.nom_interet = ci.intitule
JOIN groupes g ON g.id = agi.id_groupe
WHERE m.nom ='Mandrea';

2nd methode

SELECT gp.nom
FROM membres m
JOIN assoc_membre_interet ami ON m.login = ami.login
NATURAL JOIN assoc_groupe_interet agi
JOIN groupes gp ON gp.id = agi.id_groupe
WHERE m.nom ='Mandrea';

-- AGREGATION SQL

-- Agrégation des codes postaux dans la table membre

SELECT code_postal, count(*) FROM membres GROUP BY code_postal;



-- On cherche a connaitre pour le membre 'lorde' le nombre de concerts par salle auquel il a assistés a la date d'aujourd'hui.

SELECT COUNT(lieu), lieux.nom
FROM lieux
JOIN evenements e ON lieux.nom = e.lieu
JOIN assoc_membre_evenement ame ON e.id = ame.id_evenement
JOIN membres m ON ame.login = m.login
WHERE m.login = 'lorde'
AND e.debut < CURRENT_DATE
GROUP BY lieu; 

-- Créer et utiliser une Procédure stockée 

DROP PROCEDURE IF EXISTS ajouteMembre;
DELIMITER //
CREATE PROCEDURE ajouteMembre(IN inLogin VARCHAR(25), IN inPrenom VARCHAR(50))
BEGIN
    INSERT INTO membres
    (login, prenom)

    VALUES
    (inLogin, inPrenom);

END; //
    DELIMITER ;

CALL ajouteMembre('Denver', 'le Dernier Dinosaure');

-- Deuxieme procedure avec transaction

DROP PROCEDURE IF EXISTS ajouteMembre2;
DELIMITER //
CREATE PROCEDURE ajouteMembre2(
    IN inLogin VARCHAR(25),
    IN inPrenom VARCHAR(30),
    IN inLogin2 VARCHAR(25),
    IN inPrenom2 VARCHAR(30)
    )
BEGIN
  DECLARE exit handler for sqlexception
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;
    INSERT INTO `membres` (`login`, `prenom`) VALUES (inLogin, inPrenom);
    INSERT INTO `membres` (`login`, `prenom`) VALUES (inLogin2, inPrenom2);
    COMMIT;
END; //
    DELIMITER ;

CALL ajouteMembre2('Babe', 'le Cochon', 'Tonerre', 'Etalon');

*/