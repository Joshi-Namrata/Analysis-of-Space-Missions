# Data Processing

#Making a copy of the cleaned dataset for further processing

space_missions_processed <- space_missions_cleaned

#Extracting the country from the location

space_missions_processed <- space_missions_processed %>% 
  mutate(country = word(location, -1))

# Looking at unique countries

unique(space_missions_processed$country)

# Counting the number of missions per country

space_missions_processed %>% count(country, sort =T)

# Extracting the locations without the proper country name to understand it better

space_missions_processed%>%
  select(country, location)%>%
  filter(country %in% c("Ocean", "Sea", "Canaria", "Facility", "Site")) %>% 
  View()


space_missions_processed%>%
  select(location, country, company, rocket) %>%
  filter(country == "Zealand") %>% 
  View()



#Renaming the country names based on other location information found above

space_missions_processed <-
  space_missions_processed %>% mutate(
    country = case_when(
      location =="K-407 Submarine, Barents Sea Launch Area, Barents Sea"|
        # OR
        location == "K-496 Submarine, Barents Sea Launch Area, Barents Sea"|
        # OR
        location =="K-84 Submarine, Barents Sea Launch Area, Barents Sea" ~ "Barents Sea",
      location == "LP Odyssey, Kiritimati Launch Area, Pacific Ocean" ~ "Pacific Ocean",
      location == "LP-41, Kauai, Pacific Missile Range Facility" ~ "Range Facility",
      location == "Tai Rui Barge, Yellow Sea" |
        # OR
      location == "DeBo 3 Barge, Yellow Sea" ~ "Yellow Sea",
      location == "Launch Plateform, Shahrud Missile Test Site" ~ "Shahrud Missile Test Site",
      TRUE ~ word(location, -1)
    )
  )


# Checking the name of the rocket to understand which country launched it.

space_missions_processed%>%
  select(location, country, company, rocket) %>%
  filter(country == "Canaria") %>% 
  View()

# Rechecking the unique countries list

unique(space_missions_processed$country)


# Changing the names of some of the country names to their appropriate countries based on the location info, rocket name

space_missions_processed <- space_missions_processed %>%
  mutate(
    country = str_replace(country, "Canaria", replacement = "USA"),
    country = str_replace(country, "Barents Sea", replacement = "Russia"),
    country = str_replace(country, "Yellow Sea", replacement = "China"),
    country = str_replace(country, "Range Facility", replacement = "USA"),
    country = str_replace(country, "Shahrud Missile Test Site", replacement = "Iran"),
    country = str_replace(country, "Zealand", replacement = "New Zealand")
  )

space_missions_processed %>% count(country, sort = T)










