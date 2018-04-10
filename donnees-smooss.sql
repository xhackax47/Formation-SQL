INSERT INTO `centres_interet` (`intitule`) 
	VALUES 
	('Rock'),
	('Pop'),
	('Expérimental'),
	('Progressif'),
	('Jazz'),
	('Classique');

INSERT INTO `assoc_groupes_interet` (`nom_interet`, `id_groupe`)
	VALUES
	('Rock', '1'),
	('Progressif', '1'),
  ('Pop', '1'),
  ('Pop', '2'),
  ('Expérimental', '2'),
  ('Classique', '3'),
  ('Jazz', '3');

INSERT INTO `etats_membres_groupes` (`etat`) VALUES
('Approuvé'),
('En attente'),
('Modérateur'),
('Refusé');

INSERT INTO `etats_membres_event` (`etat`) VALUES
('Confirmé'),
('Décliné'),
('Intéressé'),
('Liste d\'attente');

INSERT INTO `assoc_membres_groupes` (`id_groupe`, `login`, `statut`) VALUES 
('2', 'formation1', 'Approuvé');

INSERT INTO `assoc_membre_interet` (`login`, `nom_interet`) VALUES 
('formation1', 'Pop'),
('formation2', 'Classique'),
('formation3', 'Pop');

INSERT INTO `lieux` (`nom`, `description`, `adresse`, `ville`, `code_postal`, `latitude`, `longitude`)
  VALUES
  ('Rockstore', 'Un lieu pour le Rock !', '20 Rue de Verdun', 'Montpellier', '34000', '43.6061888', '3.8812334'),
  ('Le Transbordeur', 'Lieu mythique des concerts indépendants lyonnais.', '3 Boulevard de Stalingrad', 'Villeurbanne', '69100', '45.783808', '4.8605979');

INSERT INTO `evenements` (`id`, `nom`, `description`, `debut`, `fin`, `id_groupe`, `lieu`, `code_postal`) VALUES (NULL, 'Du rock au Transbo', 'Le plus grand groupe du monde dans la petite salle de Villeurbanne', '2018-04-18 20:00:00', NULL, '2', 'Le Transbordeur', '69100');

INSERT INTO `assoc_membres_events` (`id_evenement`, `login`, `statut`) VALUES ('1', 'formation1', 'Confirmé');
