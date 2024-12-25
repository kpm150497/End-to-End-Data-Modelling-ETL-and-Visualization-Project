CREATE DATABASE dbProjectGroup2;

USE dbProjectGroup2;

CREATE SCHEMA dbIMDB_0NF;

-- DROP TABLE dbIMDB_0NF.imdb_data;

CREATE TABLE dbIMDB_0NF.imdb_data
(
	movie_title					VARCHAR(88)	NOT NULL, 
	title_year					NUMERIC		NOT NULL, 
	genres						VARCHAR(64)	NOT NULL, 
	color						VARCHAR(16), 
	aspect_ratio				NUMERIC, 
	duration					NUMERIC		NOT NULL, 
	language					VARCHAR(10), 
	country						VARCHAR(20)	NOT NULL, 
	plot_keywords				VARCHAR(149), 
	budget						NUMERIC, 
	gross						NUMERIC, 
	movie_facebook_likes		NUMERIC		NOT NULL, 
	cast_total_facebook_likes	NUMERIC		NOT NULL, 

	movie_imdb_link				VARCHAR(52)	NOT NULL, 
	facenumber_in_poster		NUMERIC, 
	content_rating				VARCHAR(9), 
	num_critic_for_reviews		NUMERIC, 
	num_user_for_reviews		NUMERIC, 
	num_voted_users				NUMERIC		NOT NULL, 
	imdb_score					NUMERIC		NOT NULL, 
	
	director_name				VARCHAR(32)	NOT NULL, 
	director_facebook_likes		NUMERIC		NOT NULL, 
	
	actor_1_name				VARCHAR(32)	NOT NULL, 
	actor_1_facebook_likes		NUMERIC		NOT NULL, 
	
	actor_2_name				VARCHAR(32), 
	actor_2_facebook_likes		NUMERIC, 
	
	actor_3_name				VARCHAR(32), 
	actor_3_facebook_likes		NUMERIC
);

BULK INSERT dbIMDB_0NF.imdb_data
FROM 'F:\Kunal\Cards\Masters\University\Sem1\MSDA3040_Fundamentals_Data_Engineering\Project\01_Data_Cleaning\IMDB_movie_dataset_Clean.csv'
WITH
(
	FORMAT		= 'CSV',
	FIRSTROW	= 2
);

-- Checking (movie_title) for Candidate Key
SELECT	COUNT(movie_title)			FROM dbIMDB_0NF.imdb_data;
SELECT	COUNT(DISTINCT movie_title)	FROM dbIMDB_0NF.imdb_data;

-- Checking (movie_title, title_year) for Candidate Key
SELECT	COUNT(CONCAT(movie_title, '-', title_year))				FROM dbIMDB_0NF.imdb_data;
SELECT	COUNT(DISTINCT CONCAT(movie_title, '-', title_year))	FROM dbIMDB_0NF.imdb_data;

-- Checking Duplicate Movie_Titles
SELECT	*
FROM	dbIMDB_0NF.imdb_data
WHERE	movie_title		IN	(
								SELECT	movie_title
								FROM	dbIMDB_0NF.imdb_data
								GROUP BY movie_title
								HAVING COUNT(1) > 1
								)
ORDER BY 1, 2;

-- One-to-One relation between (movie_title, title_year) and movie_imdb_link
SELECT	COUNT(COL1)				COUNT_KEYS, 
		COUNT(DISTINCT COL1)	COUNT_DISTINCT_KEYS, 
		COUNT(COL2)				COL2_COUNT_KEYS, 
		COUNT(DISTINCT COL2)	COL2_COUNT_DISTINCT_KEYS
FROM	(
			SELECT	DISTINCT	CONCAT(movie_title, '-', title_year) COL1, 
								movie_imdb_link	COL2
			FROM	dbIMDB_0NF.imdb_data
		) AS A;

-- Validating Functional Dependency between director_name, director_facebook_likes
SELECT	COUNT(COL1)				COL1_COUNT_KEYS, 
		COUNT(DISTINCT COL1)	COL1_COUNT_DISTINCT_KEYS, 
		COUNT(COL2)				COL2_COUNT_KEYS, 
		COUNT(DISTINCT COL2)	COL2_COUNT_DISTINCT_KEYS
FROM	(
			SELECT	DISTINCT	director_name COL1, 
								director_facebook_likes	COL2
			FROM	dbIMDB_0NF.imdb_data
		) AS A;
		
-- Validating Functional Dependency between Actor's Name, Actor's Facebook Likes
SELECT	COUNT(COL1)				COL1_COUNT_KEYS, 
		COUNT(DISTINCT COL1)	COL1_COUNT_DISTINCT_KEYS, 
		COUNT(COL2)				COL2_COUNT_KEYS, 
		COUNT(DISTINCT COL2)	COL2_COUNT_DISTINCT_KEYS
FROM	(
			SELECT	DISTINCT	actor_2_name COL1, 
								actor_2_facebook_likes	COL2
			FROM	dbIMDB_0NF.imdb_data
		) AS A;
