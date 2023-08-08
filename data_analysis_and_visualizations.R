# Data Analysis and Visualizations

# To find the countries with the most successful space missions

space_missions_transformed %>% 
  filter(mission_status == "Success") %>% 
  count(country, sort = TRUE) %>% 
  arrange(desc(n))

# Plotting the countries with the number of successful missions

space_missions_transformed %>% 
  filter(mission_status == "Success") %>% 
  group_by(country) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>% 
  ggplot(aes(x = fct_reorder(country, -count), y= count))+
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = -0.2) +
  labs(title = "Countries With Successful Space Missions",
       x= "Country Name",
       y = "Number of successful launches") +
  theme(axis.text.x = element_text(angle = 60, vjust = 0.5, hjust = 0.5)) 


# Looking at the distribution of mission status per country in a table

table(space_missions_transformed$country,space_missions_transformed$mission_status)


# Plotting mission status distribution across total space missions of top 5 countries

space_missions_transformed %>%
  filter(country %in% c("USA", "Russia", "Kazakhstan", "China", "France")) %>% 
  group_by(country,mission_status) %>%
  summarise(count = n())%>%
  slice_max(count, n = 5) %>% 
  ggplot(aes(x = fct_reorder(country, -count), y = count, fill = mission_status)) +
  geom_bar(stat = "identity")+
  labs(title = "Mission Status of Space launches",
       x = "Country",
       y = "Number of launches") 


# Rocket launches across time

space_missions_transformed %>% 
  group_by(year) %>% 
  summarise(count = n()) %>% 
  View()


# Plotting the total rocket launches from 1957- 2022.

space_missions_transformed %>%
  group_by(year) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = year, y = count)) +
  geom_line(color = "indianred3") +
  geom_point(color = "indianred3")+
  geom_smooth() +
  labs(x = "Launch Year", 
       y = "Number of Rocket Launches", 
       title = "Rocket Launches across time",
       subtitle = "1957 to 2022") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.5)) +
  labs(caption = "Data Source: Maven Analytics: Space Missions Dataset")


# Looking at successful rocket launches of countries over time

space_missions_transformed %>% 
  filter(mission_status == "Success") %>% 
  group_by(country,year) %>% 
  summarise(count = n()) %>% 
  View()


# Plotting successful launches of Russia and USA from 1957- 2022

space_missions_transformed %>%
  filter(mission_status == "Success" & country %in% c("Russia", "USA")) %>% 
  group_by(country,year) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = year, y = count, color = country)) +
  geom_line() +
  geom_point()+
  scale_color_manual(name = "Country",
                     values = c("darkgreen","indianred3"))+
  labs(x = "Launch Year", 
       y = "Number of Rocket Launches", 
       title = "Successful Rocket Launches of Russia and USA",
       subtitle = "1957 to 2022") +
  theme_minimal() +
  theme(legend.position = "right",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.5)) +
  labs(caption = "Data Source: Maven Analytics: Space Missions Dataset")


# Finding average mission success rate over time

# First creating a new data frame to look at the number and status of mission launches by country and year

mission_status <- space_missions_transformed %>%
  group_by(country, year, mission_status) %>%
  summarise(count = n())
  
  
# Reshaping the above data from long to wide format(This will help giving us better picture of the individual mission status per country and year)

mission_status <- mission_status %>%
  pivot_wider(names_from = mission_status,values_from = count)
  

# Replacing NA values with 0

mission_status <- mission_status %>%
  replace_na(list("Success" = 0, "Failure" = 0, "Prelaunch Failure" = 0, "Partial Failure" = 0))


# Changing the variable names to lower case for better readability

colnames(mission_status)<- tolower(colnames(mission_status)) 


# Adding underscores for further readability

colnames(mission_status) <-  gsub("prelaunch failure", "prelaunch_failure",
       gsub("partial failure", "partial_failure",
            colnames(mission_status)))


# Adding one new column of success rate

mission_status <- mission_status %>%
  mutate(success_rate = (success/sum(success, failure, prelaunch_failure, partial_failure)) * 100)


# Plotting Average mission success rate of the total launches by year from 1957-2022

mission_status %>% 
  group_by(year) %>% 
  summarise(mean_success_rate = mean(success_rate)) %>% 
  ggplot(aes(x = year, y = mean_success_rate)) +
  geom_line(color = "indianred3")+
  geom_point(color = "indianred3")+
  geom_smooth() +
  labs(x = "Launch Year", 
       y = "Average Success Rate", 
       title = "Success Rate Over Time",
       subtitle = "1957 to 2022") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.5)) +
  labs(caption = "Data Source: Maven Analytics: Space Missions Dataset")
  

# Looking at the rockets used by all the countries for space missions 

space_missions_transformed %>%
  count(country, rocket, rocket_status, sort = TRUE) %>%
  arrange(desc(n))


#Creating a function to look at individual country rockets for automation 

rockets_by_country <- function(country_name){
  space_missions_transformed %>%
    filter(country == country_name) %>% 
    count(rocket, rocket_status, sort = TRUE) %>%
    arrange(desc(n))
}

# Looking at rockets used by top 5 countries for the missions

rockets_by_country("Russia")

rockets_by_country("USA")

rockets_by_country("Kazakhstan")

rockets_by_country("China")

rockets_by_country("France")



# Creating a new data frame to save the top 5 rockets used by each of the top 5 countries for their missions

top_five_rockets <- space_missions_transformed %>%
  filter(country %in% c("Russia", "USA", "Kazakhstan", "China", "France")) %>%
  group_by(country, rocket) %>%
  summarise(launch_count = n()) %>% 
  slice_max(launch_count, n = 5)


# Plotting top 5 rockets used for space missions by the above countries

space_missions_transformed %>%
  filter(country %in% c("Russia", "USA", "Kazakhstan", "China", "France")) %>%
  group_by(country, rocket) %>%
  summarise(cnt = n()) %>% 
  slice_max(cnt, n = 5) %>% 
  ggplot(aes(x = reorder(rocket, -cnt), y = cnt)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = cnt), vjust = -0.5) +
  facet_wrap(~country, ncol = 2, scales = "free_x") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "Rockets", y = "Number of launches")


# Creating a function to plot top 5 rockets of a country to automate the process

plot_top_five_rockets <- function(country_name){
  space_missions_transformed %>%
    filter(country %in% c(country_name)) %>%
    group_by(country, rocket) %>%
    summarise(cnt = n()) %>% 
    slice_max(cnt, n = 5) %>% 
    ggplot(aes(x = reorder(rocket, -cnt), y = cnt)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = cnt), vjust = -0.5) +
    facet_wrap(~country, ncol = 2, scales = "free_x") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(x = "Rockets", y = "Number of launches")
}

# Looking at top 5 rockets used by each of the top 5 countries 

plot_top_five_rockets("Russia")

plot_top_five_rockets("USA")

plot_top_five_rockets("Kazakhstan")

plot_top_five_rockets("China")

plot_top_five_rockets("France")

  
# Adding rocket status to the above plots

# Creating a function to plot top 5 rockets and indicate their status for each country to automate the process

plot_rocket_status <- function(country_name, rocket_name1, rocket_name2, rocket_name3,rocket_name4, rocket_name5){
  space_missions_transformed %>%
    filter(country == country_name & rocket %in% c(rocket_name1,rocket_name2, rocket_name3, rocket_name4, rocket_name5)) %>% 
    group_by(rocket, rocket_status) %>%
    summarise(cnt = n()) %>% 
    slice_max(cnt, n = 5) %>% 
    ggplot(aes(x = reorder(rocket, -cnt), y = cnt, fill = rocket_status)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = c("Active" = "darkgreen", "Retired" = "indianred3"))+
    geom_text(aes(label = cnt), vjust = -0.5) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))+
    labs(title =  "Top 5 Rocket Launches",
      subtitle = country_name,
      x = "Rockets", 
      y = "Number of launches")
}

# Looking at top 5 rocket status of Russia, USA, Kazakhstan, China and France


plot_rocket_status("Russia","Cosmos-3M (11K65M)","Voskhod", "Cosmos-2I (63SM)", "Tsyklon-3", "Molniya-M /Block ML")

plot_rocket_status("USA", "Falcon 9 Block 5","Delta II 7925", "Atlas-SLV3 Agena-D","Atlas V 401", "Space Shuttle Discovery")

plot_rocket_status("Kazakhstan", "Voskhod", "Tsyklon-2","Soyuz U", "Molniya","Vostok-2")

plot_rocket_status("China", "Long March 2C", "Long March 2D","Long March 3B/E","Long March 4B", "Long March 4C")

plot_rocket_status("France", "Ariane 5 ECA", "Ariane 44L", "Ariane 44LP", "Vega", "Ariane 5 G")


# Space Launch locations 

# Creating a function for distinct locations by country

distinct_locations_by_country <- function(country_name){
  space_missions_transformed %>% 
    filter(country == country_name) %>% 
    distinct(location)
}

# Looking at space launch locations by top 5 countries

distinct_locations_by_country("Russia")

distinct_locations_by_country("USA")

distinct_locations_by_country("Kazakhstan")

distinct_locations_by_country("China")

distinct_locations_by_country("France")





