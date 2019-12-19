#!/bin/bash

# **** bash file for populating the database with values ***********************************************

#********* Installing wget package *********************************************************************

echo "installing wget...."
brew list wget || brew install wget


#********* TABLE 1: importing neighbourhood ***********************************************************************
echo "downloading neighbourhood data"
wget -O neighbourhood.csv "https://data.baltimorecity.gov/api/views/yp84-wh4q/rows.csv?accessType=DOWNLOAD" 

echo "populating neighbourhood table ..."

{
	read 
	while IFS=, read column1 column2 column3 column4 column5 column6 column7 column8 column9 column10 column11 column12 column13 column14 column15 column16 column17 column18 column19 column20 column21 column22 column23 column24 column25 column26 column27 column28 
    do
    	echo "INSERT INTO Neighbourhood (Name,PopulationMale,PopulationFemale,AvgHouseholdSize, MedianHouseholdIncome,HHBelowPovertyLine,ChildrenBelowPovertyLine ) VALUES ('$column1', '$column3','$column4', '$column20', '$column21', '$column27','$column28' );"
       
    done 
}  < neighbourhood.csv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";

 
#********* TABLE 2: importing crime ***********************************************************************

echo "downloading crime data"
wget -O crime.csv "https://data.baltimorecity.gov/api/views/wsfq-mvij/rows.csv?accessType=DOWNLOAD" 

echo "first 10 lines of "
head -10 crime.csv

echo "populating crime table ..."


{
	read 
	i=1
	while IFS=, read column1 column2 column3 column4 column5 column6 column7 column8 column9 column10 column11 column12 column13 column14 column15 column16
    do
    	
     	A="$(cut -d'/' -f1 <<<"$column1")"
     	
     	B="$(cut -d'/' -f2 <<<"$column1")"
     	
     	C="$(cut -d'/' -f3 <<<"$column1")"


     	if [[ ${C} == 2014 ]]; then
            break
		fi
     	
     	echo "INSERT IGNORE INTO Crime (Crime_Date,Crime_time,CrimeCode,Location, Description,PoliceDistrict,Neighbourhood, Longitude, Latitude) VALUES ('${C}-${A}-${B}', '$column2','$column3', '$column4', '$column5', '$column9','$column10','$column11','$column12');"
        i=$((i + 1)) 
   done 
} < crime.csv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";




#********* TABLE 3: importing Police Stations ***********************************************************************

echo "downloading Police data"
wget -O police.csv "https://data.baltimorecity.gov/api/views/6kkw-bck6/rows.csv?accessType=DOWNLOAD&bom=true&format=true" 

echo "first 10 lines of "
head -10 police.csv

echo "populating police table ..."


{
	read 
	
	while IFS=, read column1 column2 column3 column4 column5 column6 column7 
    do
    	if [ $column1 != 'Baltimore' ]; then
     	echo "INSERT IGNORE INTO PoliceStation (Name, Type, ZipCode, Neighbourhood,CouncilDistrict, PoliceDistrict,Location) VALUES ('$column1','$column2', '$column3', '$column4', '$column5','$column6','$column7');"
        fi

    done 
} < police.csv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";



#********* TABLE 4: importing Education ***********************************************************************

echo "downloading Education data"
wget -O education.csv "https://data.baltimorecity.gov/api/views/f9ua-ivaj/rows.csv?accessType=DOWNLOAD" 

echo "first 10 lines of "
head -10 education.csv

echo "populating education table ..."


{
	read 
	
	while IFS=, read column1 column2 column3 column4 column5 column6 column7 column8 column9 column10 column11 column12 column13 column14 column15 column16 column17 column18 column19 column20 column21 column22 column23 column24 column25 column26 column27 column28 column29 column30 column31 column32 column33 column34 column35 column36 column37 column38 column39 column40 column41 column42 column43 column44 column45 column46 column47 column48 column49 column50 column51 column52 column53 column54 column55 column56 column57 column58 column59 column60 column61 column62 column63 column64 column65 column66 column67 column68 column69 column70 column71 column72 column73 column74 column75 column76 column77 column78 column79 column80 column81 column82 column83 column84 column85 column86 column87 column88 column89 column90 column91 column92 column93 column94 column95 column96 column97 column98 column99 column100 column101 column102 column103 column104 column105 column106 column107 column108 column109 column110 column111 column112
    do
     	echo "INSERT IGNORE INTO Education (Neighbourhood, completed11, completed12) VALUES ('$column1','$column106', '$column107');"
     
    done 
} < education.csv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";




#********* TABLE 5: importing HomelessShelter ***********************************************************************

echo "downloading HomelessShelter data"
wget -O HomelessShelter.tsv "https://data.baltimorecity.gov/api/views/hyq3-8sxr/rows.tsv?accessType=DOWNLOAD" 

echo "first 10 lines of "
head -10 HomelessShelter.tsv

echo "populating HomelessShelter table ..."


{
	read 
	
	while IFS=$'\t' read column1 column2 column3 column4 column5 column6 column7
	
	do

		
		if [ "$column1" != 'Baltimore, MD"' ]; then
		
		  echo "INSERT IGNORE INTO HomelessShelter (Name, type, zipCode, neighbourhood, councilDistrict, policeDistrict, Location) VALUES (\"$column1\",'$column2', '$column3', '$column4', '$column5', '$column6', '$column7');"
		fi
		
	done 
} < HomelessShelter.tsv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";


#********* TABLE 6: importing VacantBuilding ***********************************************************************

echo "downloading VacantBuilding data"
wget -O VacantBuilding.tsv "https://data.baltimorecity.gov/api/views/qqcv-ihn5/rows.tsv?accessType=DOWNLOAD&bom=true" 

echo "first 10 lines of "
head -10 VacantBuilding.tsv

echo "populating VacantBuilding table ..."


{
	read 
	i=1
	while IFS=$'\t' read column1 column2 column3 column4 column5 column6 column7 column8 column9 
	    do
	    	A="$(cut -d'/' -f1 <<<"$column5")"
     	
        	B="$(cut -d'/' -f2 <<<"$column5")"
     	
        	C="$(cut -d'/' -f3 <<<"$column5")"
        
        

     	echo "INSERT IGNORE INTO VacantBuilding (ReferenceID, Block, Lot, BuildingAddress, NoticeDate, Neighbourhood, PoliceDistrict) VALUES ('$column1','$column2', '$column3', '$column3', '${C}-${A}-${B}', \"$column6\", '$column7');"
         
         i=$((i + 1)) 
    done 
} < VacantBuilding.tsv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";



#********* TABLE 7: importing ReligiousBuildings ***********************************************************************

echo "downloading ReligiousBuildings data"
wget -O ReligiousBuildings.tsv "https://data.baltimorecity.gov/api/views/kbdc-bpw3/rows.tsv?accessType=DOWNLOAD&bom=true" 

echo "first 10 lines of "
head -10 ReligiousBuildings.tsv

echo "populating ReligiousBuildings table ..."


{
	read 
	i=1
	while IFS=$'\t' read column1 column2 column3 column4 column5 column6 column7
	do
	    	
        
        if [ "$column1" != 'Baltimore, MD"' ]; then
			
		
     	echo "INSERT IGNORE INTO ReligiousBuildings (Name, Type, ZipCode, Neighbourhood, PoliceDistrict) VALUES (\"$column1\",'$column2', '$column3', \"$column4\", '$column6');"
        
	
        fi 
        i=$((i + 1)) 


    done 
} < ReligiousBuildings.tsv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";



#********* TABLE 8: importing Libraries ***********************************************************************


echo "downloading Libraries data"
wget -O Libraries.tsv "https://data.baltimorecity.gov/api/views/tgtv-wr5u/rows.tsv?accessType=DOWNLOAD&bom=true" 

echo "first 10 lines of "
head -10 Libraries.tsv

echo "populating Libraries table ..."


{
	read 
	i=1
	while IFS=$'\t' read column1 column2 column3 column4 column5 column6
	do
	    	
        
        if [ "$column1" != 'Baltimore, MD"' ]; then
			
		
     	echo "INSERT IGNORE INTO Libraries (Name, ZipCode, Neighbourhood, PoliceDistrict) VALUES (\"$column1\",'$column2', \"$column3\", '$column5');"
        
	
        fi 
        i=$((i + 1)) 


    done 
} < Libraries.tsv | /usr/local/mysql/bin/mysql -h "localhost" -u "root" "-pyes" "projectdb";






