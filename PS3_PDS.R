##### Political Data Science
##### Problem Set 3
##### Jin Kim

#start out clean
rm(list=ls())

##### 1
#calling packages
library(ggplot2)
library(readr)

#retrieving data
primaryPolls <- read.csv('https://jmontgomery.github.io/PDS/Datasets/president_primary_polls_feb2020.csv', stringsAsFactors = F)
primaryPolls$start_date <- as.Date(primaryPolls$start_date, "%m/%d/%Y")

#subset by relevant states and candidates
March3States <- c("Alabama", "Arkansas", "California", "Colorado", "Maine", "Massachusetts", "Minnesota", "North Carolina", "Oklahoma", "Tennessee", "Texas", "Utah", "Vermont", "Virginia")
primaryPolls1 <- primaryPolls[primaryPolls$state %in% March3States, ]
relevantCandidates <- c("Amy Klobuchar", "Bernard Sanders", "Elizabeth Warren", "Joseph R. Biden Jr.", "Michael Bloomberg", "Pete Buttigieg", "Tom Steyer")
primaryPolls1 <- primaryPolls1[primaryPolls1$candidate_name%in% relevantCandidates, ]

#putting them all on the same map
graph0 <- ggplot(data=primaryPolls1)+
  scale_shape_manual(values=1:nlevels(primaryPolls1$candidate_name))+
  geom_smooth(mapping = aes(x=start_date, y=pct, color=candidate_name))
graph0
#overall, Warren and Biden's popularity is going down. Sanders is rising.
#Bloomberg is also rising, but his confidence interval is very large due to missing data.
#Buttigieg seems more steady, and Klobuchar and Steyer is slightly rising.

#plotting by candidates in minimal theme, different axis, and customized legend name
graph1 <- ggplot(data=primaryPolls1)+
  scale_shape_manual(values=1:nlevels(primaryPolls1$candidate_name))+
  geom_smooth(mapping = aes(x=start_date, y=pct, color=candidate_name)) + 
  geom_point(mapping = aes(x=start_date, y=pct, color=candidate_name), alpha=.4) +
  facet_wrap(~ candidate_name, nrow=2) +
  theme_minimal() +
  labs(x = "Dates", y = "Poll Percentage") + 
  ylim(-10, 50) + 
  scale_colour_discrete(name="Relevant\nCandidates")
graph1
#this allows us to see where the observations for each candidate lie.
#we can note the difference of poll frequencies among candidates.



##### 2
rm(list = ls())
#reload data as tibble
library(tidyverse)
primaryPolls <- read_csv('https://jmontgomery.github.io/PDS/Datasets/president_primary_polls_feb2020.csv')
primaryPolls$start_date <- as.Date(primaryPolls$start_date, "%m/%d/%Y")
primaryPolls2 <- primaryPolls

#subset the data set for relevant candidates with state polls
sub.pP2 <- primaryPolls2 %>%
  filter(candidate_name %in% c("Amy Klobuchar", "Bernard Sanders", "Elizabeth Warren", "Joseph R. Biden Jr.", "Michael Bloomberg", "Pete Buttigieg", "Tom Steyer"))

#new dataset with one row for each candidate-state dyad
pivot.pP2 <- sub.pP2 %>%
  pivot_wider(names_from = start_date, values_from = pct)

#compare size
object.size(sub.pP2)
object.size(pivot.pP2)
object.size(reorg.pP2) < object.size(pivot.pP2)
#the new dataset has a much larger data size


##### 3
library(fivethirtyeight)
library(tidyverse)
polls <- read_csv('https://jmontgomery.github.io/PDS/Datasets/president_primary_polls_feb2020.csv')
Endorsements <- endorsements_2020





##### 4
