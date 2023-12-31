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
);

/* Add the species column of the table */
ALTER TABLE animals
ADD COLUMN species VARCHAR
(255);