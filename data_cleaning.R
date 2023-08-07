# Data Cleaning

# Creating a copy of this dataset to clean

space_missions_cleaned <- space_missions

# Replacing blank values in dataset with NA values

space_missions_cleaned[space_missions_cleaned == ""] <- NA

# Finding out variables containing NA values

space_missions_cleaned %>%
  select(Company,Date,Time, Price) %>%
  filter(!complete.cases(.)) %>% 
  View()

# OR

sum(is.na(space_missions_cleaned))

sum(is.na(space_missions_cleaned$Company))
sum(is.na(space_missions_cleaned$Location))
sum(is.na(space_missions_cleaned$Date))
sum(is.na(space_missions_cleaned$Time))
sum(is.na(space_missions_cleaned$Rocket))
sum(is.na(space_missions_cleaned$Mission))
sum(is.na(space_missions_cleaned$RocketStatus))
sum(is.na(space_missions_cleaned$Price))
sum(is.na(space_missions_cleaned$MissionStatus))


# Changing column names from camel case to lower case

colnames(space_missions_cleaned) <- tolower(colnames(space_missions_cleaned))


# Adding underscores in a few of the columns for better visibility

colnames(space_missions_cleaned) <- gsub("rocketstatus","rocket_status",
                                         gsub("missionstatus","mission_status",
                                              colnames(space_missions_cleaned)))


# Looking at the summary of the data before further cleaning

summary(space_missions_cleaned)

# Changing the variable types

space_missions_cleaned <- space_missions_cleaned %>% 
  mutate(date = as_date(date)) %>% 
  mutate(rocket_status= as.factor(rocket_status)) %>% 
  mutate(mission_status= as.factor(mission_status)) %>% 
  glimpse()

# Creating levels for the rocket status and mission status

levels(space_missions_cleaned$rocket_status)
levels(space_missions_cleaned$mission_status)

# Removing duplicate data(with 1 duplicated row found above)

space_missions_cleaned <- space_missions_cleaned[!duplicated(space_missions_cleaned), ]

# Checking the summary again

summary(space_missions_cleaned)









