# Money_Ballers

## Presentation:

### Selected Topic

Our team is analyzing MLB player statistics including but not limited to: RBIs, Hits, On Base Percentage, Batting Average, Wins, Doubles, Triples, Home Runs, and position, to predict average salaries and determine if and how players are being over or under compensated within 10% of the predicted salary

### Reasoning

We selected this topic because our team has a few baseball fans and there is plenty of baseball data out there. It is one sport that has been analyzed many times and there are many data science resources out there to help inspire and guide us during our project.

### Data sources

In our search for data, we went to Kaggle.com and there we found a plethora of baseball data and even other similar projects to what we are aiming to do. We found multiple .csv files from 1985 – 2016 on salary data and player stats including pitching and batting stats

### Data exploration

Using tableau and excel, we looked at all of the data available and built a few visualization to understand what data we had, how we could combine our multiple soures of data, and facilitated disucssions on how exactly we wanted to approach our topic and questions

### Questions we are attempting to answer

1. What are the primary factors in determining a high or low salary?
2. Does inflation have an impact on MLB salaries over time?
3. How accurate will our ML model outputs be compared to the actual data and predicting the following year’s salary?

### Potential Future areas of scope

    - Comparing rookie data to draft rankings
    - Predicting likelihood of injury
    - Predicting likelihood of Hall of Fame level success

### Communication Protcol

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

### ERD

An ERD diagram was created. See ERD below.

![ERDatabaseTable.png](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/ERD/ERBDatabaseTable.png)

### Create tables

* Open Query tool under Money_Ballers database
* Run SQL code found in money_ballers_db_create.sql. This can be viewed by clicking the link below.

 [Create Database: Money_Ballers](https://github.com/rmward17/Money_Ballers/blob/e3921e05cd7f61ebc547a60939888403a79eac8b/Database/money_ballers_db_create.sql)
 
* Code includes Create table script for each of 5 tables and select statements to check post csv import that all of the data was imported
* 5 tables:
  * salaries
  * batting
  * fielding
  * pitching
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
* Join fielding table to the resulting table
* Join people table to the resulting table
* The sql code can be viewed following the below link. 

[Create Database: Money_Ballers](https://github.com/rmward17/Money_Ballers/blob/e3921e05cd7f61ebc547a60939888403a79eac8b/Database/money_ballers_db_create.sql)

* Run any necessary Quality assurance or Quality control check queries
* Some sample queries can be found in the sql code below.

[QA_QC Queries](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Database/QA_QC.sql)

### Export as csv
* Export table as a whole. The CSV can be downloaded by following the link below.

[Salary_Batting_Fielding_People](https://github.com/rmward17/Money_Ballers/blob/860c5216bff0dd6fe8cab959b6bb00c498a8c2f6/Machine%20Learning/Practice_Code/salary_batting_fielding_people.csv)

* Export a subset of the table for testing and training, in this case 2015. The CSV can be viewed or downloaded following the link below.

[Salary_Batting_Fielding_People_2015](https://github.com/rmward17/Money_Ballers/blob/860c5216bff0dd6fe8cab959b6bb00c498a8c2f6/Machine%20Learning/Practice_Code/salary_batting_fielding_people_2015.csv)

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

We also have 58 known outliers. 

![image](https://user-images.githubusercontent.com/98041751/179867298-29947f3a-ebe9-4cfc-a9bf-74ca38109805.png)





## Machine Learning: 
* First we created a diagram of our Machine Learning Process. This can be viewed below.

![Money_ballers_ML_DIAGRAM.drawio.png](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Money_ballers_ML_DIAGRAM.drawio.png)

* Then we created an outline showing what features will be included as the y variable and X variables. Download word document to view Outline or view raw by following the link below.
   
[Machine Learning Outline](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Machine%20Learning%20Model%20OUTLINE.docx)

* We will investigate 4 different Machine Learning techniques. Multiple Linear Regression and Random Forest and Decision Tree Regression will be of particular interest but we wanted to create K Means and Neural Network models for comparison. Follow the links below to view the code. They are currently a work in progress and not complete.

[Multiple Linear Regression](https://github.com/rmward17/Money_Ballers/blob/main/Machine%20Learning/MultipleLinearRegression_Draft2.ipynb)

[Multiple Linear Regression No Pitchers](https://github.com/rmward17/Money_Ballers/blob/2ebde0dd252cf2ea68f865847ef986725a65cb12/Practice_Code/MultipleLinearRegression_No_Pitchers.ipynb)
Notes:
- The data is set up well for this model however, the R-Squared is very low after the first attempt (version = Draft2). Next steps are to analyze the parameters currently in the model to see which ones may not be statistically significant and also review the paramters we left out that could potentially bring up the R-Squared value.

[Desicion Tree Models](https://github.com/rmward17/Money_Ballers/blob/10ecd8ba714ed73f5c81c98f0b2f27f0eb240b3f/Machine%20Learning/TreeModels_Draft3.ipynb)

Notes:
- When we ran the multiple linear regression model, the R-Squared value was very low. Since this is not ideal, we tried 2 different decision tree regression models. One is a Decision Tree Regressor and the other is a Random Forest. Originally, the accuracy scores were not that great but we back into the data and took out the pitchers as their salaries are not effected by the batting statistics that we use. Once those were removed, we re ran both models again and the accuracy scores were much better. We ran tested and trained these models on 2014 batting data with 2015 salaries so the next task is to run the model on 2015 batting stats and then compare them to the 2016 salary data. 

[KMeans](https://github.com/rmward17/Money_Ballers/blob/03d626009cb9c1acfb0e189765eee00ecdee2296/Practice_Code/KMeans_no_pitching_data.ipynb)

[Neural Network](https://github.com/rmward17/Money_Ballers/blob/b0e811df45e91b197d8bbeee2e54c713f865b28a/Machine%20Learning/Final_Project_Notebooks/NN_Draft1.ipynb)

* The work will be done in Google-Colab

## Dashboard

Please follow the link below to view our Dashboard of results. It was created using Tableau and contains 3 tabs. 

A) Cover and Title page
B) Initial Analysis
The initial analysis contains 4 charts:
    * Top Salaries by Team
    * Top Salaries by Player
    * Salaries plotted aginst Homeruns and RBIs
    * Salries plotted against Age
C) Machine Learning Analysis
    * 2 Correlation Analyses showing the various feature data items and how they each correlate with salary
    * 2 Residual plots
    * Top 10 Overpaid Players
    * Top 10 Underpaid Players
    
[Dashboard](https://public.tableau.com/views/MONEY_BALLERS_DASH/SALARYSTORY2?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)



