## Data.table really messes with the formatting
library(data.table)
library(dplyr)
library(lubridate)

ks <- fread(file = "./kickstarter8.csv", drop = 1)

  
ks$launched = as.factor(ks$launched) 
ks$deadline = as.factor(ks$deadline) 
ks$goal = as.numeric(ks$goal)
kscountry = as.factor(ks$country)
ks$currency = as.factor(ks$currency)
ks$state = as.factor(ks$state)
ks$country = as.factor(ks$country)
ks$category = as.factor(ks$category)
ks$main_category = as.factor(ks$main_category)
ks$usdpledged = as.numeric(ks$usdpledged)
ks$weekday = wday(ks$deadline, label = TRUE)

# years = unique(year(ks$deadline))
# months = unique(month(ks$deadline))
# weekdays = unique(wday(ks$deadline, label = TRUE))
# hours = unique(hour(ks$deadline))


# write.csv(ks, file = 'kickstarter8.csv')