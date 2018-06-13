library(tidyverse)
library(lubridate)


download.file("https://ndownloader.figshare.com/files/2292169", "data/portal_data_joined.csv")

survey <- read.csv("data/portal_data_joined.csv")

sex <- factor(c("male", "female", "female", "male"))
lvls <- factor(c("high", "medium", "low"), levels = c("low", "medium", "high"))

as.character(sex)

sex <- survey$sex
levels(sex) <- c("Undetermined","Female", "Male")
plot(factor(sex, levels = c("Female", "Male", "Undetermined")))


survey <- read.csv("data/portal_data_joined.csv", stringsAsFactors = TRUE)

# Add date column
survey$date <- ymd(paste(survey$year, survey$month, survey$day,sep="-"))

missing_date <- survey[which(is.na(survey$date)), c("year", "month", "day")]


