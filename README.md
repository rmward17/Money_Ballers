# Money_Ballers

## Notes

### Database Create
* Created using pgAdmin
* Created on the PostgreSQL 11 server
* Created with the name "Money_Ballers

### Create tables
* Open Query tool under Money_Ballers database
* Run SQL code found in money_ballers_db_create_jr.sql
* Code includes Create table script for each of 3 tables and select statements to check post csv import that all of the data was imported
* 3 tables:
  * salaries
  * batting
  * people
* Datatypes for dates were created as VARCHAR and VARCHAR sizes were determined based roughly on how many characters each field needed to hold
  * Data did not load with the DATE data type. 
  * We can "ALTER TABLE ALTER COLUMN" fairly easily to set all the Dates to the correct datatype.
* Created a uniqueID field that concatenated playerID, yearID, and teamID so that it could be used as the PRIMARY KEY
  * This sufficed for the salaries table
  * This uniqueID was still not unique in the batting table
    * PRIMARY KEY and FOREIGN KEY Deleted from the code for the batting table
  * uniqueID was not created for the player table
    * playerID was used as the PRIMARY KEY
#### Question(s)
* How will this be handled in the join(s)?
By using aggregate function SUM(), the batting statistics can be summed for UniqueIDs in the salaries table that are duplicated in the batting table
* Should we revisit the ERD?

### Import CSVs
* Right click each table and click Import/Export csv
* Don't forget to check the Header button and comma as the delimiter
* Don't forget to check the columns tab that all columns are listed
* If you get an error, and have to change something to the table structure and have to recreate the table, don't forget to Drop the table first

### Join Tables
* Join batting table to salaries table, using aggregate SUM() for statistic fields (RBI, Games, At bats, etc)
* Join people table to the resulting table
* Run any necessary Quality assurance or Quality control check queries

### Export as csv
* Export table as a whole
* Export a subset of the table for testing and training, in this case 2015

### Known Data Issues
* Null values for batting statistics
 * Appears the salaries table may have some bad data
   * Salaries table has incorrect teamID for a given year (ie Salaries has a player playing for the Braves in 2015, but batting says they played for the Braves in 2014)
   * Wrong year(s) altogether (ie salaries table has a player playing from 2013-2015 when the batting table has stats from 1999-2002 and people table says Final Game was 2002
* Null record count:
  * Total: 996 of 26428
  * 2015: 3 of 817
  * 2016: 48 of 853
* What do we do with records with null statistics? 
  * Delete
  * Keep and do nothing
  * Keep and assign values
  * Keep and modify data
* Another note about uniqueIDs: It appears that many of the duplicated uniqueIDs don't even have a record in the salaries table
