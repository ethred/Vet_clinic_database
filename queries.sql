/* Find all animals whose name ends in "mon". */
SELECT *
FROM animals
WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019. */
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts. */
SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu". */
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

/* Find all animals that are neutered. */
SELECT *
FROM animals
WHERE neutered = true;

/* Find all animals not named Gabumon. */
SELECT *
FROM animals
WHERE name != 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*  Set the species column to unspecified. */
BEGIN;
    UPDATE animals SET species = 'unspecified'
    ;
    select name, species
    from animals;
    ROLLBACK;

    /* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. */
    BEGIN;
        UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
        /* Update the animals table by setting the species column to pokemon for all animals that don't have species already set. */
        UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
        SELECT *
        FROM animals;
        COMMIT;
        SELECT *
        FROM animals;

        /* Delete and rollback the transaction on the animals table. */
        BEGIN;
            DELETE FROM animals;
            SELECT *
            FROM animals;
            ROLLBACK;
            SELECT *
            FROM animals;

            /* Add another transaction inside the table. */
            BEGIN;
                -- Delete all animals born after Jan 1st, 2022.
                DELETE FROM animals WHERE date_of_birth > '2022-01-01';
                -- Create a savepoint for the transaction.
                SAVEPOINT my_savepoint;
            -- Update all animals' weight to be their weight multiplied by -1.
            UPDATE animals SET weight_kg = weight_kg * -1;
            SELECT *
            FROM animals;
            -- Rollback to the savepoint
            ROLLBACK
            TO my_savepoint;
        -- Update all animals' weights that are negative to be their weight multiplied by -1.
        UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
        SELECT *
        FROM animals;
        -- Commit the transaction
        COMMIT;

        -- How many animals are there?
        SELECT COUNT(*)
        FROM animals;
        -- How many animals have never tried to escape?
        SELECT COUNT(*)
        FROM animals
        WHERE escape_attempts = 0;
        -- What is the average weight of animals?
        SELECT AVG(weight_kg)
        FROM animals;
        -- Who escapes the most, neutered or not neutered animals?
        SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
        FROM animals
        GROUP BY neutered;
        -- What is the minimum and maximum weight of each type of animal?
        SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
        FROM animals
        GROUP BY species;
        -- What is the minimum and maximum weight of each type of animal?
        SELECT species, AVG(escape_attempts) AS avg_escape_attempts
        FROM animals
        WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
        GROUP BY species;


        /* Write queries to answer the requirements based on the instruction. */

        SELECT animals.name, species.name AS species
        FROM animals
            JOIN species ON animals.species_id = species.id
            JOIN owners ON animals.owner_id = owners.id
        WHERE owners.full_name = 'Melody Pond';


        SELECT animals.name, species.name AS species
        FROM animals
            JOIN species ON animals.species_id = species.id
        WHERE species.name = 'Pokemon';


        SELECT owners.full_name, animals.name AS animal_name
        FROM owners
            LEFT JOIN animals ON owners.id = animals.owner_id;


        SELECT species.name AS species, COUNT(animals.id) AS animal_count
        FROM species
            LEFT JOIN animals ON species.id = animals.species_id
        GROUP BY species.name;


        SELECT animals.name AS digimon_name
        FROM animals
            JOIN species ON animals.species_id = species.id
            JOIN owners ON animals.owner_id = owners.id
        WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';


        SELECT animals.name AS animal_name
        FROM animals
            JOIN owners ON animals.owner_id = owners.id
        WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

        SELECT owners.full_name, COUNT(animals.id) AS animal_count
        FROM owners
            LEFT JOIN animals ON owners.id = animals.owner_id
        GROUP BY owners.full_name
        ORDER BY animal_count DESC
        LIMIT 1;

 /* Write queries to answer the following requirements. */
SELECT animals.name AS animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;


SELECT COUNT(DISTINCT visits.animal_id) AS animal_count
FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';


SELECT vets.name AS vet_name, species.name AS specialty
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;


SELECT animals.name AS animal_name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';


SELECT animals.name AS animal_name, COUNT(visits.id) AS visit_count
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;


SELECT animals.name AS animal_name, MIN(visits.visit_date) AS first_visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name;


SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;


SELECT COUNT(visits.id) AS mismatched_specialty_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.vet_id IS NULL;


SELECT species.name AS recommended_specialty, COUNT(visits.id) AS visit_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC
LIMIT 1;