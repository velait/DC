library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

# choose columns
select(surveys, plot_id, species_id, weight)

# choose rows
filter(surveys, year == 1995)


species_sml <- surveys %>% filter(weight < 5) %>%  select(species_id, sex, weight)


# Using pipes, subset the surveys data to include individuals collected before 1995 and retain only the columns year, sex, and weight.

surveys %>% filter(year < 1995) %>%  select(year, sex, weight)

# MUTATE: create new columns based on old columns
surveys %>% mutate(weight_kg = weight/1000) %>% head()

# Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.

surveys %>% mutate(hindfoot_half = hindfoot_length / 2) %>% select(species_id, hindfoot_half) %>%  filter(hindfoot_half < 30 & !is.na(hindfoot_half))


# Split-Apply-Combine: mean weight and hind feet length for each sexes

# one group
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE), mean_hindfeet = mean(hindfoot_length, na.rm = TRUE))

# two groups
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# arrange by minimum weight
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%
  arrange(desc(mean_weight))


## Count
surveys %>% count(sex, sort=TRUE)

surveys %>%  count(sex, species) %>%  arrange(species, desc(n))


# How many individuals were caught in each plot_type surveyed?
surveys %>% count(plot_type)


# Use group_by() and summarize() to find the mean, min, and max hindfoot length for each species (using species_id). Also add the number of observations (hint: see ?n).

surveys %>% filter(hindfoot_length >= 0) %>%  group_by(species_id) %>% summarize(mean(hindfoot_length), min(hindfoot_length), max(hindfoot_length), n = n())


# What was the heaviest animal measured in each year? Return the columns year, genus, species_id, and weight.

survey_summary <- surveys %>% filter(weight >= 0) %>% group_by(year) %>% filter(weight == max(weight)) %>%  select(year, genus, species_id, weight) %>%  arrange(year)


### Write to csv
write_csv(survey_summary, path="data/survey_summary")
