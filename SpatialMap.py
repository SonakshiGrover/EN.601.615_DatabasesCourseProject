# code for building heatmap and scatter plot


import gmplot
import pandas as pd


df = pd.read_csv("heatmapData.csv")
Latitude_newlist = df.Latitude 

Longitude_newlist = df.Longitude

gmap = gmplot.GoogleMapPlotter(39.066,-76.622,10)
 
 
# heatmap plot 

gmap.heatmap(Latitude_newlist , Longitude_newlist) 
  
# scatter plot
#gmap.scatter(Latitude_newlist,Longitude_newlist , c='r',marker=True)

gmap.apikey = "Your_API_KEY" # please enter your API key here 

gmap.draw("mymap.html") 