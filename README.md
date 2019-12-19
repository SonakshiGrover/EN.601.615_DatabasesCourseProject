# EN.601.615_DatabasesCourseProject


This project focuses on the analysis of crime in Baltimore City. We propose to analyze different kinds of databases such as crime records, census demographics, education, religious buildings, libraries, homeless shelters and vacant buildings in the city and gain insights from them. 


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
   
   
   A screenshot for one of the above commands are - 
   
    ![](screenshot3.png)
    
   
Here is the heatmap we get for the crimecounts in Baltimore City - 

 ![Heatmap showing the spread of crimes in Baltimore City](https://raw.githubusercontent.com/SonakshiGrover/EN.601.615_DatabasesCourseProject/master/HeatMap_output/heatmap.png)
 

## Some key insights we got from the results of our queries( A detailed discussion with all the output pics are in the Discussion section of the project report)

1.An interesting insight was that the districts did not shifted in the crime report rankings for all the three years we observed in our analysis.

2.An important insight was that Greater Charles Village/Charles Village, the neighborhood closest to the campus and located south of campus, had the highest numbers in crime reports for the last five years. 

3.Greater Charles Village ranks 6th in Baltimore which was a surprising insight considering this neighborhood is partially patrolled by University security. 

4.The most reported crime in Baltimore is Larceny followed by Common assault, Burglary, Larceny from Auto and Aggravated Assault.

5. We found that there is a negative correlation between the percentage of children below the poverty line and the crime counts in a district. Surprisingly, we observed that - as the crime counts increased in a district, the %  of children below the poverty line decreased. 

6. The graph suggests that there is no correlation between the number of crimes reported in a neighborhood with the number of vacant buildings in that neighborhood. 

7. The number of religious buildings can explain less that 1% of the variance in number of crimes reported, hence we see an almost flat trend line in the graph. 

8. It was too small of a sample set to carry out any analysis and we also arrived to a conclusion that there wasn’t any existing correlation between these two factors.




## Authors

Sonakshi Grover (sgrover3@jhu.edu) </br>
Sai Rajarishi Ulapu (sulapu1@jhu.edu)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

We would like to thank Professor David Yarowsky for guiding us in this project.




