-- Active: 1747400426333@@127.0.0.1@5432@conservation_db@public

SELECT * from rangers;

SELECT * from species;

SELECT * from sightings

UPDATE sightings
set
    sighting_time = '2024-05-12 16:20:00'
where
    sighting_id = 2

-- problem 1

INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem 2

SELECT count(DISTINCT (species_id)) as unique_species_count
from sightings

-- problem 3

SELECT * from sightings where location ILIKE '%pass%'

-- problem 4

SELECT ra.name as name, count(si.ranger_id) as total_sightings
from sightings si
    JOIN rangers ra on ra.ranger_id = si.ranger_id
GROUP BY
    ra.name

-- problem 5

SELECT sp.common_name
from sightings si
    right JOIN species sp on sp.species_id = si.species_id
where
    si.species_id is NULL;

-- problem 6

SELECT sp.common_name, si.sighting_time, ra.name
from
    sightings si
    left JOIN rangers ra on ra.ranger_id = si.ranger_id
    left JOIN species sp on sp.species_id = si.species_id
ORDER BY si.sighting_time DESC
LIMIT 2

-- probelm 7

UPDATE species
SET
    status = 'Historic'
where
    extract(
        YEAR
        from discovery_date
    ) < 1800

-- problem 8


SELECT
    sighting_id,
  
    case
      WHEN extract(hour from sighting_time)<12 THEN 'Morning'
      WHEN extract(HOUR FROM sighting_time)>=12 and extract(hour from sighting_time)<17 then 'Afternoon'
      WHEN extract(HOUR from sighting_time)>=17 then 'Evening'
      
      else '!'

    end as time_of_day

from sightings
ORDER BY sighting_id

-- problem 9

DELETE from  rangers

    WHERE ranger_id in (
        SELECT ran.ranger_id from rangers ran
        LEFT JOIN sightings sig on ran.ranger_id=sig.ranger_id
        WHERE sig.ranger_id is NULL

    )
   
