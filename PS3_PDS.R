##### Political Data Science
##### Problem Set 3
##### Jin Kim

#start out clean
rm(list=ls())

##### 1
#calling ggplot2 & readr
library(ggplot2)
library(readr)

#retrieving data
primaryPolls <- read.csv('https://jmontgomery.github.io/PDS/Datasets/president_primary_polls_feb2020.csv', stringsAsFactors = F)
primaryPolls$start_date <- as.Date(primaryPolls$start_date, "%m/%d/%Y")

#subset by relevant states and candidates
March3States <- c("Alabama", "Arkansas", "California", "Colorado", "Maine", "Massachusetts", "Minnesota", "North Carolina", "Oklahoma", "Tennessee", "Texas", "Utah", "Vermont", "Virginia")
primaryPolls <- primaryPolls[primaryPolls$state %in% March3States, ]
relevantCandidates <- c("Amy Klobuchar", "Bernard Sanders", "Elizabeth Warren", "Joseph R. Biden Jr.", "Michael Bloomberg", "Pete Buttigieg", "Tom Steyer")
primaryPolls <- primaryPolls[primaryPolls$candidate_name%in% relevantCandidates, ]

#plotting by candidates 
graph1 <- ggplot(data=primaryPolls)+
  scale_shape_manual(values=1:nlevels(primaryPolls$candidate_name))+
  geom_smooth(mapping = aes(x=start_date, y=pct, color=candidate_name)) + 
  geom_point(mapping = aes(x=start_date, y=pct, color=candidate_name), alpha=.4) +
  facet_wrap(~ candidate_name, nrow=2)
graph1

#plotting in minimal theme
graph1 <- graph1 + theme_minimal()
graph1

#plotting with different axis labels
graph1 <- graph1 + labs(x = "Dates", y = "Poll Percentage") + ylim(-10, 50) 
graph1

#plotting with customized legend name ("Relevant Candidates")
graph1 <- graph1 + scale_colour_discrete(name="Relevant\nCandidates")
graph1



##### 2

#subset the data with candidates who had at least 5 polls in one state
test <- primaryPolls %>%
  select(state, candidate_name, pct) %>%
  group_by(candidate_name, state) %>%
  mutate(count = n()) %>%
  filter(count >= 5) %>%
  arrange(state, candidate_name, desc(pct))
candidate.names <- levels(as.factor(test$candidate_name))

#subset the data by candidates using a for loop
#create a null list
candidate_list <- NULL
for (i in candidate.names){
  subset.i <- test[test$candidate_name==i, ]
  candidate_list[[i]] <- subset.i
}

Klobuchar <- candidate_list[[1]]


head(candidate_list)


##### 3
library(fivethirtyeight)
library(tidyverse)
polls <- read_csv('https://jmontgomery.github.io/PDS/Datasets/president
_primary_polls_feb2020.csv')
Endorsements <- endorsements_2020