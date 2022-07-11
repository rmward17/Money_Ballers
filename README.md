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
    * I dropped PRIMARY KEY and FOREIGN KEY from the code for the batting table
  * uniqueID was not created for the player table
    * playerID was used as the PRIMARY KEY
#### Question(s)
* How will this be handled in the join(s)?          

### Import CSVs
* Right click each table and click Import/Export csv
* Don't forget to check the Header button and comma as the delimiter
* Don't forget to check the columns tab that all columns are listed
* If you get an error, and have to change something to the table structure and have to recreate the table, don't forget to Drop the table first
