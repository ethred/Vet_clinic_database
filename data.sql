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

/* Inserted the data of the following to tables*/
INSERT INTO vets
    (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');


INSERT INTO specializations
    (vet_id, species_id)
VALUES
    ((SELECT id
        FROM vets
        WHERE name = 'William Tatcher'), (SELECT id
        FROM species
        WHERE name = 'Pokemon')),
    ((SELECT id
        FROM vets
        WHERE name = 'Stephanie Mendez'), (SELECT id
        FROM species
        WHERE name = 'Digimon')),
    ((SELECT id
        FROM vets
        WHERE name = 'Stephanie Mendez'), (SELECT id
        FROM species
        WHERE name = 'Pokemon')),
    ((SELECT id
        FROM vets
        WHERE name = 'Jack Harkness'), (SELECT id
        FROM species
        WHERE name = 'Digimon'));


INSERT INTO visits
    (animal_id, vet_id, visit_date)
VALUES
    ((SELECT id
        FROM animals
        WHERE name = 'Agumon'), (SELECT id
        FROM vets
        WHERE name = 'William Tatcher'), '2020-05-24'),
    ((SELECT id
        FROM animals
        WHERE name = 'Agumon'), (SELECT id
        FROM vets
        WHERE name = 'Stephanie Mendez'), '2020-07-22'),
    ((SELECT id
        FROM animals
        WHERE name = 'Gabumon'), (SELECT id
        FROM vets
        WHERE name = 'Jack Harkness'), '2021-02-02'),
    ((SELECT id
        FROM animals
        WHERE name = 'Pikachu'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2020-01-05'),
    ((SELECT id
        FROM animals
        WHERE name = 'Pikachu'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2020-03-08'),
    ((SELECT id
        FROM animals
        WHERE name = 'Pikachu'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2020-05-14'),
    ((SELECT id
        FROM animals
        WHERE name = 'Devimon'), (SELECT id
        FROM vets
        WHERE name = 'Stephanie Mendez'), '2021-05-04'),
    ((SELECT id
        FROM animals
        WHERE name = 'Charmander'), (SELECT id
        FROM vets
        WHERE name = 'Jack Harkness'), '2021-02-24'),
    ((SELECT id
        FROM animals
        WHERE name = 'Plantmon'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id
        FROM animals
        WHERE name = 'Plantmon'), (SELECT id
        FROM vets
        WHERE name = 'William Tatcher'), '2020-08-10'),
    ((SELECT id
        FROM animals
        WHERE name = 'Plantmon'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2021-04-07'),
    ((SELECT id
        FROM animals
        WHERE name = 'Squirtle'), (SELECT id
        FROM vets
        WHERE name = 'Stephanie Mendez'), '2019-09-29'),
    ((SELECT id
        FROM animals
        WHERE name = 'Angemon'), (SELECT id
        FROM vets
        WHERE name = 'Jack Harkness'), '2020-10-03'),
    ((SELECT id
        FROM animals
        WHERE name = 'Angemon'), (SELECT id
        FROM vets
        WHERE name = 'Jack Harkness'), '2020-11-04'),
    ((SELECT id
        FROM animals
        WHERE name = 'Boarmon'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2019-01-24'),
    ((SELECT id
        FROM animals
        WHERE name = 'Boarmon'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2019-05-15'),
    ((SELECT id
        FROM animals
        WHERE name = 'Boarmon'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2020-02-27'),
    ((SELECT id
        FROM animals
        WHERE name = 'Boarmon'), (SELECT id
        FROM vets
        WHERE name = 'Maisy Smith'), '2020-08-03'),
    ((SELECT id
        FROM animals
        WHERE name = 'Blossom'), (SELECT id
        FROM vets
        WHERE name = 'Stephanie Mendez'), '2020-05-24'),
    ((SELECT id
        FROM animals
        WHERE name = 'Blossom'), (SELECT id
        FROM vets
        WHERE name = 'William Tatcher'), '2021-01-11');