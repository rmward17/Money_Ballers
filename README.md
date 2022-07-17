# Money_Ballers

## Presentation:

- Selected Topic: Our team is analyzing MLB player statistics including but not limited to: RBIs, Hits, On Base Percentage, Batting Average, Wins, Doubles, Triples, Home Runs, and position, to predict average salaries and determine if and how players are being over or under compensated within 10% of the predicted salary
- Reasoning: We selected this topic because our team has a few baseball fans and there is plenty of baseball data out there. It is one sport that has been analyzed many times and there are many data science resources out there to help inspire and guide us during our project.
- Data sources: In our search for data, we went to Kaggle.com and there we found a plethora of baseball data and even other similar projects to what we are aiming to do. We found multiple .csv files from 1985 – 2016 on salary data and player stats including pitching and batting stats
- Data exploration: Using tableau and excel, we looked at all of the data available and built a few visualization to understand what data we had, how we could combine our multiple soures of data, and facilitated disucssions on how exactly we wanted to approach our topic and questions
- Questions we are attempting to answer:
1. What are the primary factors in determining a high or low salary?
2. Does inflation have an impact on MLB salaries over time?
3. How accurate will our ML model outputs be compared to the actual data and predicting the following year’s salary?

-	Potential Future areas of scope:
    -	Comparing rookie data to draft rankings
    - Predicting likelihood of injury
    -	Predicting likelihood of Hall of Fame level success

- Communication Protcol: 
  -	Primary communication platform: Slack 
  -	Primary technology to be used: PgAdmin, Google Colab, Tableau
  -	Send a slack message to the group about what you are working on in the GitHub and on what branch
  -	Send a follow up message when you are done working on the branch
  -	Decide as a group when a branch is ready to merged to the main
  -	Evenly divide work left over from scheduled class time and schedule an extra meeting session if need be
  -	If you are struggling with your work, ask for help sooner rather than later 
  -	If you have an idea, please share that idea!!
 
[Presentation Slides](https://docs.google.com/presentation/d/1f5lwUxhIlIqjeIY4Z7r7QsO3mZk6pMc8NXe4Id-lalA/edit#slide=id.gd5b15f0a3_5_26)

## Database
* Created using pgAdmin
* Created on the PostgreSQL 11 server
* Created with the name "Money_Ballers

### ERD
An ERD diagram was created. See ERD below.

![ERDatabaseTable.png](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/ERD/ERBDatabaseTable.png)

### Create tables
* Open Query tool under Money_Ballers database
* Run SQL code found in money_ballers_db_create.sql. This can be viewed by clicking the link below.

 [Create Database: Money_Ballers](https://github.com/rmward17/Money_Ballers/blob/0126ba196d332f99e92eb8d4c00673529df415e4/Database/money_ballers_db_create.sql)
 
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
* The sql code can be viewed following the below link. 

[Create Database: Money_Ballers](https://github.com/rmward17/Money_Ballers/blob/0126ba196d332f99e92eb8d4c00673529df415e4/Database/money_ballers_db_create.sql)

* Run any necessary Quality assurance or Quality control check queries
* Some sample queries can be found in the sql code below.

[QA_QC Queries](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Database/QA_QC.sql)

### Export as csv
* Export table as a whole. The CSV can be downloaded by following the link below.

[Salary_Batting_People](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Database/salary_batting_people.csv)

* Export a subset of the table for testing and training, in this case 2015. The CSV can be viewed or downloaded following the link below.

[Salary_Batting_People_2015](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Database/salary_batting_people_2015.csv)

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

## Machine Learning: 
* First we created a diagram of our Machine Learning Process. This can be viewed below.

![Money_ballers_ML_DIAGRAM.drawio.png](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Money_ballers_ML_DIAGRAM.drawio.png)

* Then we created an outline showing what features will be included as the y variable and X variables. Download word document to view Outline or view raw by following the link below.
   
[Machine Learning Outline](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Machine%20Learning%20Model%20OUTLINE.docx)

* We will investigate 4 different Machine Learning techniques. Multiple Linear Regression and Random Forest will be of particular interest but we wanted to create K Means and Neural Network models for comparison. Follow the links below to view the code. They are currently a work in progress and not complete.

[Multiple Linear Regression](https://github.com/rmward17/Money_Ballers/blob/main/Machine%20Learning/MultipleLinearRegression_Draft2.ipynb)

Notes:
- The data is set up well for this model however, the R-Squared is very low after the first attempt (version = Draft2). Next steps are to analyze the parameters currently in the model to see which ones may not be statistically significant and also review the paramters we left out that could potentially bring up the R-Squared value.

[Random Forest](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Final_Project_Notebooks/RandomForest_Draft1.ipynb)

[KMeans](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Final_Project_Notebooks/KMeans_Draft1.ipynb)

[Neural Network](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Final_Project_Notebooks/NN_Draft1.ipynb)

* The work will be done in Google-Colab



