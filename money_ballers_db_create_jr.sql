CREATE TABLE salaries (
	uniqueID VARCHAR(25) NOT NULL,
	yearID VARCHAR(4) NOT NULL,
	teamID VARCHAR(3) NOT NULL,
	lgID VARCHAR (2) NOT NULL,
    playerID VARCHAR(25),
	salary INT,
	PRIMARY KEY (uniqueID)
	);
select count(*) from salaries; -- Looking for 26428
select * from salaries;
-- Drop table salaries;

CREATE TABLE batting (
	uniqueID VARCHAR(25) NOT NULL,
	playerID VARCHAR(25),
	yearID VARCHAR(4) NOT NULL,
	stint INT NOT NULL,
	teamID VARCHAR(3) NOT NULL,
	lgID VARCHAR (2) NOT NULL,
    games INT NOT NULL,
	at_bats INT NOT NULL,
	runs INT NOT NULL,
	hits INT NOT NULL,
	doubles INT NOT NULL,
	triples INT NOT NULL,
	homeruns INT NOT NULL,
	RBI INT NOT NULL,
	stolen_bases INT NOT NULL,
	caught_stealing INT NOT NULL,
	walks INT NOT NULL,
	strike_outs INT NOT NULL,
	international_walks INT,
	hit_by_pitch INT,
	sacrifice_bunt INT,
	sacrifice_flies INT,
	hit_into_double_plays INT
	);
select count(*) from batting; -- Looking for 48241
select * from batting;
-- Drop table batting;

CREATE TABLE people (
	playerID VARCHAR(25) NOT NULL,
	birthYear VARCHAR(4),
	birthMonth VARCHAR(2),
	birthDay VARCHAR(2),
	birthCountry VARCHAR(50),
    birthState VARCHAR(50),
	birthCity VARCHAR(50),
	deathYear VARCHAR(4),
	deathMonth VARCHAR(2),
	deathDay VARCHAR(2),
	deathCountry VARCHAR(50),
	deathState VARCHAR(50),
	deathCity VARCHAR(50),
	nameFirst VARCHAR(50),
	nameLast VARCHAR(50),
	nameGiven VARCHAR(50),
	weight INT,
	height INT,
	bats VARCHAR(10),
	throws VARCHAR(10),
	debut DATE,
	finalGame DATE,
	retroID VARCHAR(25),
	bbrefID VARCHAR(25),
	PRIMARY KEY (playerID)
	);

select count(*) from people; -- Looking for 20370
select * from people;
-- Drop table people;

-- Alter datatypes code goes below
-- ALTER TABLE salaries
-- ALTER COLUMN yearid YEAR;
