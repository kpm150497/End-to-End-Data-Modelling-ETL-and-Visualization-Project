-- Create new database with name imdb_data
CREATE DATABASE imdb_data;

-- Use database imdb_data
USE imdb_data;

-- Create new schema dbimdb
CREATE SCHEMA dbimdb;

-- Use database imdb_data
USE imdb_data;

-- DDL for actor_info table
CREATE TABLE dbimdb.actor_info
(
	actor_name				VARCHAR(40)		NOT NULL,
	actor_facebook_likes	INT				NOT NULL,
	CONSTRAINT	PK_actor_info
				PRIMARY KEY (actor_name)						/* Primary Key */
);

-- DDL for director_info table
CREATE TABLE dbimdb.director_info
(
	director_name				VARCHAR(40)		NOT NULL,
	director_facebook_likes		INT				NOT NULL,
	CONSTRAINT	PK_director_info
				PRIMARY KEY (director_name)						/* Primary Key */
);

-- DDL for imdb_movie_page table
CREATE TABLE dbimdb.imdb_movie_page
(
	movie_imdb_link				VARCHAR(100)	NOT NULL,
	facenumber_in_poster		INT,
	content_rating				VARCHAR(10),
	num_critic_for_reviews		INT,
	num_user_for_reviews		INT,
	num_voted_users				INT				NOT NULL,
	imdb_score					NUMERIC(10, 4)	NOT NULL,
	CONSTRAINT	PK_imdb_movie_page
				PRIMARY KEY (movie_imdb_link)					/* Primary Key */
);

-- DDL for movie_info table
CREATE TABLE dbimdb.movie_info
(
	movie_title					VARCHAR(100)	NOT NULL,
	title_year					INT				NOT NULL,
	color						VARCHAR(20),
	aspect_ratio				NUMERIC(22, 4),
	duration_in_mins			INT				NOT NULL,
	language					VARCHAR(20),
	country						VARCHAR(20)		NOT NULL,
	budget						NUMERIC(22, 4),
	gross						NUMERIC(22, 4),
	movie_facebook_likes		INT				NOT NULL,
	cast_total_facebook_likes	INT				NOT NULL,
	movie_imdb_link				VARCHAR(100)	NOT NULL,
	director_name				VARCHAR(40)		NOT NULL,
	actor_1_name				VARCHAR(40)		NOT NULL,
	actor_2_name				VARCHAR(40),
	actor_3_name				VARCHAR(40),
	CONSTRAINT	PK_movie_info
				PRIMARY KEY (movie_title, title_year),			/* Primary Key */
	CONSTRAINT	FK_movie_info_imdb_movie_page
				FOREIGN KEY (movie_imdb_link)
				REFERENCES dbimdb.imdb_movie_page (movie_imdb_link), 
	CONSTRAINT	FK_movie_info_director_info
				FOREIGN KEY (director_name)
				REFERENCES dbimdb.director_info (director_name), 
	CONSTRAINT	FK_movie_info_actor1_info
				FOREIGN KEY (actor_1_name)
				REFERENCES dbimdb.actor_info (actor_name), 
	CONSTRAINT	FK_movie_info_actor2_info
				FOREIGN KEY (actor_2_name)
				REFERENCES dbimdb.actor_info (actor_name), 
	CONSTRAINT	FK_movie_info_actor3_info
				FOREIGN KEY (actor_3_name)
				REFERENCES dbimdb.actor_info (actor_name), 
	CONSTRAINT	CHK_Title_Year
				CHECK (title_year	>= 1900	AND	title_year	<=2100)
);

-- DDL for movie_genres table
CREATE TABLE dbimdb.movie_genres
(
	movie_title					VARCHAR(100)	NOT NULL,
	title_year					INT				NOT NULL,
	genre						VARCHAR(80)		NOT NULL,
	CONSTRAINT	PK_movie_genres
				PRIMARY KEY (movie_title, title_year, genre),	/* Primary Key */
	CONSTRAINT	FK_movie_genres_movie_info
				FOREIGN KEY	(movie_title, title_year)
				REFERENCES dbimdb.movie_info (movie_title, title_year)
);

-- DDL for movie_plot table
CREATE TABLE dbimdb.movie_plot
(
	movie_title					VARCHAR(100)	NOT NULL,
	title_year					INT				NOT NULL,
	plot_keywords				VARCHAR(150)	NOT NULL,
	CONSTRAINT	PK_movie_plot
				PRIMARY KEY (movie_title, title_year, plot_keywords), 	/* Primary Key */
	CONSTRAINT	FK_movie_plot_movie_info
				FOREIGN KEY (movie_title, title_year)
				REFERENCES dbimdb.movie_info (movie_title, title_year)
);

