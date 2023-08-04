# Data Analysis and Visualizations

# To find the countries with the most successful space missions

space_missions_processed %>% 
  filter(mission_status == "Success") %>% 
  count(country, sort = TRUE) %>% 
  arrange(desc(n))

# Plot of the above findings

space_missions_processed %>% 
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


# Looking at mission status distribution over total launches per country

space_missions_processed %>%
  select(country,mission_status)%>%
  group_by(country,mission_status) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  ggplot(aes(x = fct_reorder(country, count), y = count, fill = mission_status)) +
  geom_bar(stat = "identity") +
  labs(title = "Mission Status of Space launches",
    x = "Country name",
    y = "Number of launches"
  ) +
  coord_flip() 


# Rocket launches across time

space_missions_processed %>% 
  group_by(year) %>% 
  summarise(count = n()) %>% 
  View()

# Successful rocket launches over time

space_missions_processed %>% 
  filter(mission_status == "Success") %>% 
  group_by(year) %>% 
  summarise(count = n()) %>% 
  View()

# Plotting the findings

space_missions_processed %>%
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



# Finding average mission success rate over time

# Looking at the distribution of mission status per country in a table

table(space_missions_processed$country,space_missions_processed$mission_status)

# Looking at distribution of mission status per country by year
  
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


# Mission success rate over time

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
  


# Looking at average success rate per country( Doesn't look that great)

mission_status %>% 
  group_by(country) %>% 
  summarise(mean_success_rate = round(mean(success_rate))) %>% 
  ggplot(aes(x= reorder(country,mean_success_rate), y = mean_success_rate, fill = country )) +
  geom_col(width = 0.5) +
  geom_text(aes(label = mean_success_rate), vjust = -0.2)+
  labs(x = " Country",
       y= "Average Success Rate",
       title = "Average success Rate Per Country",
       Subtitle = "1957 to 2022" ) +
  theme_classic() +
  theme(axis.line = element_line(color = "gray"),
        axis.text.x = element_text(color = "gray", size = 12, hjust = 1),
        axis.text.y = element_text(color = "gray"),
        axis.title = element_text(color = "gray"),
        panel.background = element_rect(fill = "white"), 
        panel.grid.major = element_line(color = "gray"), 
        legend.position = "none") +
  coord_flip()
  


# Trying something new (dumbell plot) (Look further into it)

install.packages("ggalt")
library(ggalt)


space_missions_processed %>%
  filter(mission_status == "Success") %>% 
  group_by(country,year) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(y = reorder(country, -count),
             x = year,
             xend = year)) +  
  geom_dumbbell(size = 1.2,
                size_x = 3, 
                size_xend = 3,
                colour = "grey", 
                colour_x = "blue", 
                colour_xend = "indianred3") +
  theme_minimal() + 
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.5)) +
  labs(caption = "Data Source: Maven Analytics: Space Missions Dataset")


# Looking at the rockets used by all the countries for space missions 

space_missions_processed %>%
  count(country, rocket, rocket_status, sort = TRUE) %>%
  arrange(desc(n))


#Creating a function for automation and avoiding duplication

rockets_by_country <- function(country_name){
  space_missions_processed %>%
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



# Plotting top 5 rockets used for space missions by the above countries

space_missions_processed %>%
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
  space_missions_processed %>%
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



# Adding rocket status

top_five_countries_rockets <- space_missions_processed %>%
  filter(country %in% c("Russia", "USA", "Kazakhstan", "China", "France")) %>%
  group_by(country, rocket) %>%
  summarise(launch_count = n()) %>% 
  slice_max(launch_count, n = 5)


top_five_countries_rockets <- top_five_countries_rockets %>% 
  mutate(rocket_status = space_missions_processed$rocket_status)

top_five_countries_rockets <- cbind(space_missions_processed$rocket_status)


# Tried it but doesn't work( Getting all the rockets and not top 5)

space_missions_processed %>%
  filter(country == "China") %>% 
  group_by(rocket, rocket_status) %>%
  summarise(cnt = n()) %>% 
  slice_max(cnt, n = 5) %>% 
  ggplot(aes(x = reorder(rocket, -cnt), y = cnt, color = rocket_status)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = cnt), vjust = -0.5) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(x = "Rockets", y = "Number of launches")




