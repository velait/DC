# R and SQL ----
# Installing new packages ----

# install.packages("dbplyr")
# install.packages("RSQLite") 

# Load the libraries ----
library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)
library(ggplot2)

# download data ----
# mode = "wb" refers to binary 
download.file(url = "https://ndownloader.figshare.com/files/2292171",
              destfile = "data/portal_mammals.sqlite", mode = "wb")

# Create a connection to the SQLite data base ----
DBConnection <- DBI::dbConnect(RSQLite::SQLite(), "data/portal_mammals.sqlite")

# looking into the DBConnection
dbplyr::src_dbi(DBConnection)

# interact with tables
surveys <- tbl(DBConnection, "surveys")
plots <- tbl(DBConnection, "plots")
species <- tbl(DBConnection, "species")



# bdplyr functions are actually translations from SQL:
show_query(surveys2002)

# Write a dbplyr mutate on surveys to add a column called mean_weight
surveys %>% mutate(weight_kg = weight/1000)

#
surveys2002 <- surveys %>% filter(year == 2002, weight > 200) %>% as.data.frame()

ggplot(surveys2002, aes(weight)) + stat_density(geom="line")


# exercise: subset and plot

surveys %>% filter(year == 2002, weight < 100) %>% as.data.frame() %>% ggplot(aes(weight)) + stat_density(geom="line")


# Save the surveys2002 into csv in data folder
write_csv(as.data.frame(surveys2002), path="data/survey2002")
