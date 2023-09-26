INSERT INTO animals
    (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals
    (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
    ('Charmander', '2020-02-08', 0, false, -11, NULL),
    ('Plantmon', '2021-11-15', 2, true, -5.7, NULL),
    ('Squirtle', '1993-04-02', 3, false, -12.13, NULL),
    ('Angemon', '2005-06-12', 1, true, -45, NULL),
    ('Boarmon', '2005-06-07', 7, true, 20.4, NULL),
    ('Blossom', '1998-10-13', 3, true, 17, NULL),
    ('Ditto', '2022-05-14', 4, true, 22, NULL);

/* Inserted the data of the following 6 entities */
INSERT INTO owners
    (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species
    (name)
VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id
FROM species
WHERE name = 'Digimon')
    ELSE (SELECT id
FROM species
WHERE name = 'Pokemon')
END;

/* Modify the inserted animals to include owner information */
-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';

-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond';

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester';