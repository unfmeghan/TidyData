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

datapath <- "./data/UCI HAR Dataset"
files <- list.files(datapath, recursive=TRUE)

#Read Test files
dataActivityTest  <- read.table(paste(datapath, "/test/Y_test.txt", sep="" ),header = FALSE)
dataSubjectTest  <- read.table(paste(datapath, "/test/subject_test.txt", sep=""),header = FALSE)
dataFeaturesTest  <- read.table(paste(datapath, "/test/X_test.txt", sep=""),header = FALSE)

#Read Train files
dataActivityTrain <- read.table(paste(datapath, "/train/Y_train.txt", sep=""),header = FALSE)
dataSubjectTrain <- read.table(paste(datapath, "/train/subject_train.txt", sep=""),header = FALSE)
dataFeaturesTrain <- read.table(paste(datapath, "/train/X_train.txt", sep=""),header = FALSE)
