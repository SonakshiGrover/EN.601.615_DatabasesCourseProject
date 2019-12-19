# EN.601.615_DatabasesCourseProject


This project focuses on the analysis of crime in Baltimore City. We propose to analyze different kinds of databases such as crime records, census demographics, education, religious buildings, libraries, police stations, homeless shelters in the city and gain insights from them. 


## Getting Started

Please follow these instructions to get the project running on your local machine. 

### Prerequisites

You need to install python and mysql server. Install mysql workbench. Anaconda would be best to install python since we are using pandas and gmplot in our code base.  The bash script is also using wget package for downloading the data from the urls but our .sh script automatically installs it. 


### Steps: 

1. Run the createSchema.sql file - This is for setting up the schema for the project's database. We are using server name as 	"localhost", user name as " root", password as "yes" and database as "projectdb" in our code. Please change them 			accordingly. 

		On MySQL workbench -  open the file and run it.
		On terminal - $ mysql -u username password < "createSchema.sql"  

2. Run the import-SQL.sh - This is for populating the database. The import-SQL.sh file will take a few minutes (~30 min) to  	run since its downloading the .csv files from their urls on data.baltimorecity.gov/api/ and then is populating the entire 	 database. Some of the relations have more than a million rows, so it will take some time to run. You can save on time by 	 directly accessing the csv files in /Data folder in the project folder. That already has the csv files saved in it.


		chmod +x import-SQL.sh
		./import-SQL.sh


3. Run Queries.sql -  This is for running all the SQL queries

		On MySQL workbench -  open the file and run it.
		On terminal - $ mysql -u username password < "createSchema.sql"  

4. Run SpatialMap.py - This file takes in the input from the file heatmapData.csv (which has the output from query Q1 in 	   Queries.sql) and plots a heatmap. 

		python SpatialMap.py  
 
   The script produces a .html file in the project folder which can be viewed in any browser. Also, you'll have to replace the gmap API key in the script with your key. 
   
 Here is the heatmap we get for the crimecounts in Baltimore City - 

 ![Heatmap showing the spread of crimes in Baltimore City](https://raw.githubusercontent.com/SonakshiGrover/EN.601.615_DatabasesCourseProject/master/HeatMap_output/heatmap.png)
 
## Discussion on the questions we explored along with their outputs:

1. List the number of reported crimes for the year 2017, 2018, 2019 for each of the police districts in Baltimore City

In the first section of our analysis, we looked into the prevalence of crime in Police Districts and Neighborhoods within the Baltimore City Limits. First, we looked at the number of crimes reported in each of the 9 Police Districts, for the years 2017,2018 and 2019. Figure -1 shows the results from extracting that data. On the x-axis are the names of the police districts and the number of crimes reported are represented on the y-axis.   
img

For the year 2019 Figure-2 shows the percentages of crime reported in each of the nine police districts.

img

Next, we wanted to identify the police districts performing the best in reducing crime - we analyzed the percentage drop in crime. Figure-3 has the years on the x-axis and the fractions in decimals on the y-axis. All the points are represented as a percentage of crimes reported in 2017.

img

The crime reports displayed a downward trend from 2017 to 2019. Crime reduced considerably in all the police districts - Northeast having the best results in overall crime reduction. Figure-3 best shows that aforementioned point by comparing Northeast with Southwest and Western. For the year 2019, district crime reports as a percentage of total crimes reported in Baltimore were calculated - they ranged from 8% to 14%. Northeast district is the police district with highest counts of crimes reported for years 2017, 2018 and 2019 and western district stands as the district with least counts. An interesting insight was that the districts did not shifted in the crime report rankings for all the three years we observed in our analysis.


2 images

We have built a heat map for analysing the spread and intensity of crimes in Baltimore City. 
This gives a better understanding of the presence of crime in different neighbourhoods of Baltimore. 







## Authors

Sonakshi Grover (sgrover3@jhu.edu) </br>
Sai Rajarishi Ulapu (sulapu1@jhu.edu)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

We would like to thank Professor David Yarowsky for guiding us in this project.




