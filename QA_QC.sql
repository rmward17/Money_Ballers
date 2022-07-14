-- Investigating a known Duplicate uniqueID post data load, pre join
select * from salaries where playerID = 'mantoje01';
select * from batting where stint > 1;
select * from batting where playerID = 'mantoje01';

-- The following uniqueIDs were pulled from a list of 23 that were duplicated in the batting table but unique to the salary table
-- Wanted to check if the batting statistic values were summed correctly when batting and salaries and people tables were joined

select count(*), uniqueID from batting
Group by uniqueID Order by count DESC
;


select * from Batting where uniqueID = '2018ATLtuckepr01';
select * from salary_batting_people where uniqueID = '2018ATLtuckepr01';
select * from salaries where playerID = 'tuckepr01';
select * from people where playerID = 'tuckepr01';

select * from Batting where uniqueID = '2016CLEmartimi02';
select * from salary_batting_people where uniqueID = '2016CLEmartimi02';
select * from salaries where playerID = 'martimi02';
select * from people where playerID = 'martimi02';

select * from Batting where uniqueID = '2018NYAhaleda02';
select * from salary_batting_people where uniqueID = '2018NYAhaleda02';
select * from salaries where playerID = 'haleda02';
select * from people where playerID = 'haleda02';

select * from Batting where uniqueID = '2019LAAmejiaad01';
select * from salary_batting_people where uniqueID = '2019LAAmejiaad01';
select * from salaries where playerID = 'mejiaad01';
select * from people where playerID = 'mejiaad01';

select * from Batting where uniqueID = '1998LANlukema01';
select * from salary_batting_people where uniqueID = '1998LANlukema01';

select * from Salary_Batting where uniqueID = '1996BOSmantoje01';
select * from salary_batting_people where uniqueID = '1996BOSmantoje01';

select count(*) from Salary_Batting where playerID is null;
select * from salaries where playerid is null;
select * from batting where playerid is null;

-- Will statistic values be summed correctly when batting is joined with salaries? Tested on RBIs and a known duplicated uniqueID

select uniqueid, sum(rbi) from batting
where uniqueid = '1996BOSmantoje01'
group by uniqueid;

-- The join resulted in many null values for our batting statistics
-- The following queries are investigating them
Select * from salary_batting_people where games is null;
select count(*) from salary_batting_people where games is null;  -- 996
select count(*) from salary_batting_people_2015 where games is null; -- 3
select * from salary_batting_people_2015 where games is null;
Select count(*) from salary_batting_people where games is null and yearID = '2016'; -- 48
Select * from salary_batting_people where games is null and yearID = '2016';

-- 2015 Examples
select * from batting where playerID = 'carpeda01';
select * from salary_batting_people where playerID = 'carpeda01';
select * from salaries where playerID = 'carpeda01';
select * from people where playerID = 'carpeda01';

select * from batting where playerID = 'willije01';
select * from salary_batting_people where playerID = 'willije01';
select * from salaries where playerID = 'willije01';
select * from people where playerID = 'willije01';

select * from batting where playerID = 'wrighwe01';
select * from salary_batting_people where playerID = 'wrighwe01';
select * from salaries where playerID = 'wrighwe01';
select * from people where playerID = 'wrighwe01';

-- 2016 Example
select * from batting where playerID = 'cappsca01';
select * from salary_batting_people where playerID = 'cappsca01';
select * from salaries where playerID = 'cappsca01';
select * from people where playerID = 'cappsca01';

-- Appears to be just bad data in the salaries table
-- Recommendation: Drop all null records