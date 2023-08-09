# Analysis of Space-Missions

## Introduction

This project is completed using **R** to **explore**, **clean**, **manipulate** and **analyze** the **space missions** dataset from **Maven Analytics** Data Playground. 

It also includes **visualizations** to represent the trends in the completed space missions from **1957 to 2022**.

![successful_launches_of_countries](https://github.com/Joshi-Namrata/Analysis-of-Space-Missions/assets/128434472/46b95a8b-e19e-4c93-9efd-02671293e3a3)

![successful_launches_trends_of_russia_and_usa](https://github.com/Joshi-Namrata/Analysis-of-Space-Missions/assets/128434472/f25fea78-83f2-497e-811a-0518bb90e4b0)

![top_5_rockets_russia](https://github.com/Joshi-Namrata/Analysis-of-Space-Missions/assets/128434472/96e86e7e-46e6-4f17-bcb4-d4abf4a972df)


### Project link

 [R Project](https://joshi-namrata.github.io/Analysis-of-Space-Missions/)

 ### Dataset link

 [Space Missions Dataset](https://mavenanalytics.io/data-playground?page=2&pageSize=5)

 ## Questions Explored

1. Which countries have had the most successful space missions? Has it always been that way?

2. How have the rocket launches trended across time? Has mission success rate increased?

3. Which rocket has been used for the most space missions? Is it still active?


## Skills Used

1. **Data Exploration**
   * Looked at the structure of the data including the type of data in the variables and their names using various functions.
   * Checked for unique and duplicate observations.
  
2. **Data Cleaning**
   * Replaced blank values in the dataset with NA values.
   * Changed variable names for readability and consistency.
   * Assigned correct data type for each variable including creating levels for some of the factors data types.
   * Removed Duplicate observations.
  
3. **Data Manipulation**
   * Created new columns of **Country** and **Year** by extracting data from the exisiting columns.
   * Found and replaced data in the new columns to the correct data based on the exisiting information in the dataset and the online reasearch for accuracy and consistency.
  
4. **Data Analysis and Visualization**
   * Performed calculations including sum, average and percentages to take a closer look at the data to find trends and patterns to answer the above questions.
   * Created appropriate visualizations with customizations supporting the analysis to show the trends in the data.
   * Created functions to automate the process of analysis and visualization to avoid repetitions and save time.
  
## Key Findings

1. Russia, USA, Kazakhstan, China and France are the top 5 countries which had the most successful space missions.

2. Russia and USA had relatively higher number of successful rocket launches than the other countries.

3. Russia had higher number of successful launches than USA from 1968 to 1990 but the trend changes later from 1990 to 2022 where USA had more successful launches than Russia.

4. There is an interesting trend in the total space missions from 1957- 2022 where total number of space missions increased and decreased over time as seen from the line chart.

   + Increased from 1957- 1975 : Mainly due to space race between USA and Soviet Union with rise in increased federal support and funding resulting in increased launches during that time frame. The race however ended in 1975 with the first cooperative launch of Apollo-Soyuz mission. [(Muir-Harmony, 2017)](https://oxfordre.com/americanhistory/view/10.1093/acrefore/9780199329175.001.0001/acrefore-9780199329175-e-274)

   + Decreased from 1975- 2005 : Possibly due increased cost of launching big satellites making space missions very costly. In addition to the increased cost, there was reduction in federal space funding to NASA after the space race which further slowed the space mission launches. [(Seck, N, 2012)](https://phys.org/news/2012-08-space-armstrong.html)

    + Increased from 2005- 2022 : Due to increased commercialization, technological advancements and building of smaller space crafts with missions becoming cost and fuel efficient. This helped more countries initiate their space missions.[(Louise Fox, L. S., West, D. M., Onder, H., &amp; Katharine Kelley, J. B, 2023, June 24)](https://www.brookings.edu/articles/how-space-exploration-is-fueling-the-fourth-industrial-revolution/)

5. The average mission success rate increased with the start of the launches in 1957 and until 1980 due to space race between Soviet Union and USA as described above but then has been steady in the later years.

6. The rocket used for the most space missions is Cosmos-3M (11K65M) of Russia and it is Retired.


## Lessons Learnt

1. Exploring the data was so helpful to learn about the data types and observations before starting the cleaning process.
2. Cleaning the data is the most critical step which consumed most of my time but I was ensured that the data I was working with was accurate and consistent.
3. Manipulating the data got me excited to organize my data according to the questions I was trying to answer.
4. Analyzing and visualizing the data was the most fun part as I was able to aggregate the data to answer specific questions and observe those trends in different visuals for clarity.
5. Creating functions in R automated my process to keep my work tidy and avoid repetitions.
6. Creating markdown files and exploring different formats helped me organize my project in one place.

I throughly enjoyed working with this interesting dataset in R to analyze it and find useful trends. 

**If you have reached here, I would like to thank you for taking the time to read it and appreciate any of your valuable feedback for it.**


## References

1. Muir-Harmony, T. (2017, February 27). The Space Race and American Foreign Relations. Oxford Research Encyclopedia of American History. Retrieved 8 Aug. 2023, from https://oxfordre.com/americanhistory/view/10.1093/acrefore/9780199329175.001.0001/acrefore-9780199329175-e-274.
   
2. Seck, N. (2012, August 26). Space race, on a budget, was not how Armstrong saw it. Phys.org. https://phys.org/news/2012-08-space-armstrong.html

3. Louise Fox, L. S., West, D. M., Onder, H., &amp; Katharine Kelley, J. B. (2023, June 24). How space exploration is fueling the Fourth Industrial Revolution. Brookings. https://www.brookings.edu/articles/how-space-exploration-is-fueling-the-fourth-industrial-revolution/



   
