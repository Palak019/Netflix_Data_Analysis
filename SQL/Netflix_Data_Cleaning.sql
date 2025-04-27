--Schema
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

select * from netflix;

--Delete Unnecessary Columns
ALTER TABLE netflix
DROP COLUMN description;

ALTER TABLE netflix
DROP COLUMN casts;

ALTER TABLE netflix
DROP COLUMN show_id;

ALTER TABLE netflix
DROP COLUMN director;

-- Check how many NULLs in each column
SELECT 
    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS null_type,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS null_date_added,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS null_duration,
	SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
	SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS null_release_year,
	SUM(CASE WHEN listed_in IS NULL THEN 1 ELSE 0 END) AS null_listed_in
FROM netflix;

--Find duplicates
SELECT 
    type,
    title,
    country,
    date_added,
    duration,
    rating,
    release_year,
    listed_in,
    COUNT(*) AS duplicate_count
FROM netflix
GROUP BY 
    type,
    title,
    country,
    date_added,
    duration,
    rating,
    release_year,
    listed_in
HAVING COUNT(*) > 1;

--Finding missing values
SELECT
    SUM(CASE WHEN type = '' THEN 1 ELSE 0 END) AS missing_type,
    SUM(CASE WHEN title = '' THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN country = '' THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN date_added = '' THEN 1 ELSE 0 END) AS null_date_added,
    SUM(CASE WHEN duration = '' THEN 1 ELSE 0 END) AS null_duration,
    SUM(CASE WHEN rating = '' THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS null_release_year,  -- only NULL check
    SUM(CASE WHEN listed_in = '' THEN 1 ELSE 0 END) AS null_listed_in
FROM netflix;

--Replace NULL with "Unknown"
UPDATE netflix
SET country = COALESCE(country, 'Unknown');

--handle null values
-- Step 1: Calculate Average Movie Duration
WITH movie_avg AS (
    SELECT ROUND(AVG(CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER))) AS avg_duration
    FROM netflix
    WHERE type = 'Movie' 
      AND duration IS NOT NULL 
      AND duration != ''
)
-- Step 2: Update Movies and TV Shows in one go
UPDATE netflix
SET duration = CASE
    WHEN (duration IS NULL OR duration = '') AND type = 'Movie'
        THEN (SELECT CONCAT(avg_duration, ' min') FROM movie_avg)
    WHEN (duration IS NULL OR duration = '') AND type = 'TV Show'
        THEN '1 Season'
    ELSE duration
END;

DELETE FROM netflix
WHERE date_added IS NULL OR date_added = '';

--Rename columns
ALTER TABLE netflix
RENAME COLUMN type TO content_type;

ALTER TABLE netflix
RENAME COLUMN rating TO age_rating;

ALTER TABLE netflix
RENAME COLUMN listed_in TO genre;

--Correct data type
ALTER TABLE netflix
ALTER COLUMN date_added TYPE DATE
USING TO_DATE(date_added, 'Month DD, YYYY');











