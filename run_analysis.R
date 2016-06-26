#Include dplyer library for use later
library(dplyr)

#Download and unzip the data if it doesn't already exist
setwd("~/GitHub/TidyData")
if(!file.exists("./data"))
{
    dir.create("./data")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url,destfile="./data/Dataset.zip",method="curl")
    unzip(zipfile="./data/Dataset.zip",exdir="./data")
    }

path_rf <- "./data/UCI HAR Dataset"
files <- list.files(path_rf, recursive=TRUE)
files
