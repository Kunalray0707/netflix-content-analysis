-- ============================================
-- DATABASE: Netflix Content Analysis Project
-- ============================================

-- Create Database
CREATE DATABASE netflix_project;

-- Use Database
USE netflix_project;

-- ============================================
-- TABLE CREATION
-- ============================================

-- Create Netflix Table
CREATE TABLE netflix (
    show_id VARCHAR(10) PRIMARY KEY,     -- Unique ID of show
    type VARCHAR(20),                    -- Movie or TV Show
    title TEXT,                          -- Title of content
    director TEXT,                       -- Director name
    cast TEXT,                           -- Cast details
    country VARCHAR(100),                -- Country of origin
    date_added VARCHAR(50),              -- Date added to Netflix
    release_year INT,                    -- Release year
    rating VARCHAR(10),                  -- Age rating
    duration VARCHAR(50),                -- Duration (mins/seasons)
    listed_in TEXT,                      -- Genre/category
    description TEXT                     -- Description of content
);

-- Preview Data
SELECT * FROM netflix LIMIT 10;

-- ============================================
-- ANALYSIS QUERIES
-- ============================================

-- 1. Top 10 Latest Movies
SELECT title, release_year
FROM netflix
WHERE type = 'Movie'
ORDER BY release_year DESC
LIMIT 10;

-- 2. Count Shows by Type (Movies vs TV Shows)
SELECT type, COUNT(*) AS total_shows
FROM netflix
GROUP BY type;

-- 3. Shows in 'Action' Genre
SELECT title, type, release_year
FROM netflix
WHERE listed_in LIKE '%Action%';

-- 4. Top 5 Countries with Most Shows
SELECT country, COUNT(*) AS total_shows
FROM netflix
GROUP BY country
ORDER BY total_shows DESC
LIMIT 5;

-- 5. Top 5 Directors with Most Content
SELECT director, COUNT(*) AS total_shows
FROM netflix
GROUP BY director
ORDER BY total_shows DESC
LIMIT 5;

-- 6. Top 10 TV Shows Released After 2018
SELECT title, release_year
FROM netflix
WHERE type = 'TV Show' AND release_year > 2018
ORDER BY release_year DESC
LIMIT 10;

-- 7. Count Shows Per Genre
SELECT listed_in, COUNT(*) AS total_shows
FROM netflix
GROUP BY listed_in
ORDER BY total_shows DESC
LIMIT 10;

-- 8. Movies Longer Than 150 Minutes
SELECT title, duration
FROM netflix
WHERE type = 'Movie'
AND CAST(SUBSTR(duration,1,LENGTH(duration)-4) AS UNSIGNED) > 150;

-- 9. Shows Added in 2020
SELECT title, date_added
FROM netflix
WHERE YEAR(date_added) = 2020;

-- 10. Top 5 Countries with Most Movies
SELECT country, COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
GROUP BY country
ORDER BY total_movies DESC
LIMIT 5;

-- 11. TV Shows Containing 'Stranger' in Title
SELECT title, type
FROM netflix
WHERE type = 'TV Show' AND title LIKE '%Stranger%';

-- 12. Shows with Rating PG-13 or Higher
SELECT title, rating
FROM netflix
WHERE rating IN ('PG-13','R','NC-17');

-- 13. Count Shows Per Release Year
SELECT release_year, COUNT(*) AS total_shows
FROM netflix
GROUP BY release_year
ORDER BY release_year;

-- 14. Shows with Multiple Genres Including Drama
SELECT title, listed_in
FROM netflix
WHERE listed_in LIKE '%Drama%' AND listed_in LIKE '%,%';

-- 15. Directors with Only One Show
SELECT director, COUNT(*) AS total_shows
FROM netflix
GROUP BY director
HAVING total_shows = 1
ORDER BY director;
