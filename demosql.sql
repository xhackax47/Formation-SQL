DROP TABLE users;
DROP TABLE cities;  


CREATE TABLE cities 
(
  id INT PRIMARY KEY NOT NULL,
  nom varchar(70),
  pays varchar(50) 
);

CREATE TABLE users 
(
  id INT PRIMARY KEY NOT NULL,
  nom varchar(100),
  prenom varchar(255),
  email varchar(512),
  date_naissance date,
  city INT,
  FOREIGN KEY (city) REFERENCES cities(id)
);

-- ALTER TABLE users ADD COLUMN city INT;

-- ALTER TABLE users ADD CONSTRAINT FK_CityUser FOREIGN KEY (city) REFERENCES cities(id);