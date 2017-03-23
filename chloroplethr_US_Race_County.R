###### Settings
library(choroplethr)
library(acs)
library(ggplot2)
setwd("C:/Github/DataBlog")

###### API key
# Need to go to http://api.census.gov/data/key_signup.html to set API key
api.key.install("95147043cfb3460867a1fc678808514e4a3d04fc")

###### Basic ACS Table IDs 
# B19301 = Per Capita Income
# B01003 = Population

###### Plotting
## Basic by State
state_choropleth_acs(tableId="B19301")
state_choropleth_acs(tableId="B19301") +
  labs(title="US 2011 Per Capita Income by State")

## Per Capita Income by County
county_choropleth_acs(tableId="B19301")
county_choropleth_acs(tableId="B19301",state_zoom="california")

## Population by County by Ethnicity
county_choropleth_acs(tableId="B01003")+labs(title="Total US Population by County (2011)")
county_choropleth_acs(tableId="B02008")+labs(title="US Population by County (2011) - White")
county_choropleth_acs(tableId="B02009")+labs(title="US Population by County (2011) - Black ")
county_choropleth_acs(tableId="B02011")+labs(title="US Population by County (2011) - Asian")
county_choropleth_acs(tableId="B03001")+labs(title="US Population by County (2011) - Hispanic")

###### Animated Choropleth
df_2015<-get_acs_data(tableId="B19301",map="county",endyear=2015)
df_2014<-get_acs_data(tableId="B19301",map="county",endyear=2014)
df_2013<-get_acs_data(tableId="B19301",map="county",endyear=2013)
df_2012<-get_acs_data(tableId="B19301",map="county",endyear=2012)
df_2011<-get_acs_data(tableId="B19301",map="county",endyear=2011)
df_2010<-get_acs_data(tableId="B19301",map="county",endyear=2010)

choro_list<-list()
choro_list[[1]]<-county_choropleth(df_2010$df)
choro_list[[2]]<-county_choropleth(df_2011$df)
choro_list[[3]]<-county_choropleth(df_2012$df)
choro_list[[4]]<-county_choropleth(df_2013$df)
choro_list[[5]]<-county_choropleth(df_2014$df)
choro_list[[6]]<-county_choropleth(df_2015$df)

choroplethr_animate(choro_list)

# Changing colors
county_choropleth_acs(tableId="B19301") +
  scale_fill_brewer(palette=3)
# Number of bins
county_choropleth_acs(tableId="B19301",num_colors=4) 
county_choropleth_acs(tableId="B19301",num_colors=1)  # continuous

###### Set fixed bounds so this makes more sense

###### Do this off of percent_change from 2010..

