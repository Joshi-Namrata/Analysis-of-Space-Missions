# Data Exploration

install.packages("tidyverse")
library(tidyverse)

# space_missions <- read.csv(file.choose(),header = TRUE)

View(space_missions)

# Looking at the structure of the data

glimpse(space_missions)

# Looking at first 6 and last 6 rows of data

head(space_missions)
tail(space_missions)

# Looking at the names of the variables

names(space_missions)

# Finding unique observations in company, Rocket, Mission, Rocket status and mission status

unique(space_missions$Company)
unique(space_missions$Rocket)
unique(space_missions$Mission)
unique(space_missions$RocketStatus)
unique(space_missions$MissionStatus)

# Looking at the variable types of Date,Rocket status and Mission Status

class(space_missions$Date)
class(space_missions$RocketStatus)
class(space_missions$MissionStatus)

#Identifying empty values

is_empty(space_missions$Price)

# Identifying duplicate data

space_missions[duplicated(space_missions), ]

View(space_missions[duplicated(space_missions), ]) 

# Looking at the summary of the data

summary(space_missions)