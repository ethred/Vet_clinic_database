CREATE DATABASE vet_clinic;

CREATE TABLE animals (  
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR
(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
(5,2),
PRIMARY KEY
(id)
);

/* Add the species column of the table */
ALTER TABLE animals
ADD COLUMN species VARCHAR
(255);

CREATE TABLE owners
(
    id serial PRIMARY KEY,
    full_name varchar(255),
    age integer
);

/* Create a table named species and make sure that id is set as autoincremented into the PRIMARY KEY */
CREATE TABLE species
(
    id serial PRIMARY KEY,
    name varchar(255)
);

/* Modify the animals table */
ALTER TABLE animals
ALTER COLUMN id
SET DATA TYPE
serial;

/* Remove species column inside the table */
ALTER TABLE animals
DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);

/* Create a table named vets */
CREATE TABLE vets
(
    id serial PRIMARY KEY,
    name varchar(255),
    age integer,
    date_of_graduation date
);

/* Create a "join table" called specializations to handle this relationship */
CREATE TABLE specializations
(
    id serial PRIMARY KEY,
    vet_id integer REFERENCES vets(id),
    species_id integer REFERENCES species(id)
);

/*  Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit */
CREATE TABLE visits
(
    id serial PRIMARY KEY,
    animal_id integer REFERENCES animals(id),
    vet_id integer REFERENCES vets(id),
    visit_date date
);