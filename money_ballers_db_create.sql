-- Drop table before recreating table
Drop table salaries;
-- Create salaries table
CREATE TABLE salaries (
	uniqueID VARCHAR(25) NOT NULL,
	yearID VARCHAR(4) NOT NULL,
	teamID VARCHAR(3) NOT NULL,
	lgID VARCHAR (2) NOT NULL,
    	playerID VARCHAR(25),
	salary INT,
	PRIMARY KEY (uniqueID)
	);

-- After importing csv, check that data imported correctly
select count(*) from salaries; -- Looking for 26428
select * from salaries;

-- Drop table before recreating table
Drop table batting;
-- Create batting table
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

-- After importing csv, check that data imported correctly
select count(*) from batting; -- Looking for 48241
select * from batting;

-- Drop table before recreating table
Drop table people;
-- Create people table
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

-- After importing csv, check that data imported correctly
select count(*) from people; -- Looking for 20370
select * from people;

-- Alter datatypes code goes below (Dates are datatype VARCHAR) 
-- ALTER TABLE salaries
-- ALTER COLUMN yearid YEAR;

-- Create a 2015 salaries table
-- Drop table before recreating table
Drop table salaries_2015;
SELECT *
INTO salaries_2015
FROM salaries
WHERE yearid = '2015';
-- Check data
select * from salaries_2015;
select count(*) from salaries_2015;

-- Drop table before recreating table
Drop table batting_2015;
-- Create a 2015 batting table
SELECT *
INTO batting_2015
FROM batting
WHERE yearid = '2015';
-- Check data
select * from batting_2015;
select count(*) from batting_2015;

-- Create a 2015 People table; this table is not necesary
-- SELECT *
-- INTO people_2015
-- FROM people
-- WHERE yearid = '2015';
-- select * from people_2015;

-- Drop table before recreating table
Drop table Salary_Batting;
-- Join salaries and batting
SELECT s.uniqueID,
	s.yearID,
	s.teamID,
	s.lgID,
    	s.playerID,
	s.salary,
	sum(b.stint) stint, --do we need this; It's ordinal, I think, as to where the player was 1st, 2nd, 3rd, etc
	sum(b.games) games, 
	sum(b.at_bats) bats,
	sum(b.runs) runs,
	sum(b.hits) hits,
	sum(b.doubles) doubles,
	sum(b.triples) triples,
	sum(b.homeruns) homeruns,
	sum(b.rbi) rbi,
	sum(b.stolen_bases) stolen_bases,
	sum(b.caught_stealing) caught_stealing,
	sum(b.walks) walks, 
	sum(b.strike_outs) strike_outs,
	sum(b.international_walks) international_walks,
	sum(b.hit_by_pitch) hit_by_pitch,
	sum(b.sacrifice_bunt) sacrifice_bunt,
	sum(b.sacrifice_flies) sacrifice_flies,
	sum(b.hit_into_double_plays) hit_into_double_plays
INTO Salary_Batting
From salaries as s
Left Join batting as b 
On s.uniqueID = b.uniqueID
Group By s.uniqueID
Order By s.uniqueID;
-- Check Data
select count(*) from Salary_Batting;

-- Drop table before recreating table with code below
Drop table Salary_Batting_People;
-- Join Salary_Batting with people
SELECT sb.uniqueID,
	sb.yearID,
	sb.teamID,
	sb.lgID,
    	sb.playerID,
	sb.salary,
	sb.games,
	sb.bats,
	sb.runs,
	sb.hits,
	sb.doubles,
	sb.triples,
	sb.homeruns,
	sb.rbi,
	sb.stolen_bases,
	sb.caught_stealing,
	sb.walks,
	sb.strike_outs,
	sb.international_walks,
	sb.hit_by_pitch,
	sb.sacrifice_bunt,
	sb.sacrifice_flies,
	sb.hit_into_double_plays,
	ppl.birthYear,
	ppl.birthMonth,
	ppl.birthDay,
	ppl.birthCountry,
    	ppl.birthState,
	ppl.birthCity,
	ppl.deathYear,
	ppl.deathMonth,
	ppl.deathDay,
	ppl.deathCountry,
	ppl.deathState,
	ppl.deathCity,
	ppl.nameFirst,
	ppl.nameLast,
	ppl.nameGiven,
	ppl.weight,
	ppl.height,
	ppl.bats bats_hand,
	ppl.throws throws_hand,
	ppl.debut,
	ppl.finalGame,
	ppl.retroID,
	ppl.bbrefID
INTO Salary_Batting_People
From salary_batting as sb
Left Join people as ppl 
On sb.playerID = ppl.playerID;
-- Check Data
select count(*) from Salary_Batting_People;

-- Drop table before recreating table with code below
Drop table Salary_Batting_People_2015;
-- Create table of 2015 salary_batting_people merged dataset
SELECT *
INTO salary_batting_people_2015
FROM salary_batting_people
WHERE yearid = '2015';
-- Check data
select count(*) from salary_batting_people_2015; -- should match the salaries_2015 table





