This is the readme doc for the Getting and Cleaning Data Coursera final project.

Step 1: Read and Merges the training and the test sets to create one data set.
------------------------------------------------------------------------------

``` r
#Read Test files
dataActivityTest  <- read.table("test/Y_test.txt", header = FALSE)
dataSubjectTest  <- read.table("test/subject_test.txt", header = FALSE)
dataFeaturesTest  <- read.table("test/X_test.txt", header = FALSE)

#Read Train files
dataActivityTrain <- read.table("train/Y_train.txt", header = FALSE)
dataSubjectTrain <- read.table("train/subject_train.txt", header = FALSE)
dataFeaturesTrain <- read.table("train/X_train.txt", header = FALSE)

#Combine Test and train datasets
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

#Change Names to provide descriptive column names
names(dataSubject) <- "subject"
names(dataActivity)<- "activity"
dataFeaturesNames <- read.table("features.txt", head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

#Combine all tables into one huge Datatable with descriptive columns names set above
Data <- cbind(dataFeatures, dataSubject, dataActivity)
```

Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
----------------------------------------------------------------------------------------------

``` r
#Grab just the mean and std columns and save into a summary data table
summaryFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
summaryData <- subset(Data, select = c(as.character(summaryFeaturesNames), "subject", "activity" ))
```

Step 3: Uses descriptive activity names to name the activities in the data set
------------------------------------------------------------------------------

``` r
activityLabels <- read.table("activity_labels.txt", header = FALSE)
names(activityLabels) <- c("activity", "activity_name")
lookup <- inner_join(summaryData, activityLabels, by = "activity")
summaryData$activity <- lookup$activity_name
```

Step 4: Appropriately labels the data set with descriptive variable names.
--------------------------------------------------------------------------

First create a helper function that prettifies the acronyms

``` r
# Rename columns names
RenameColumns <- function(name) {
    newName <- gsub("^t", "time", name)
    newName <- gsub("^f", "fequency", newName)
    newName <- gsub("([A]|[B]|[G]|[J]|[M])", "\\.\\1", newName)
    newName <- gsub("Acc", "Accelerometer", newName)
    newName <- gsub("Gyro", "Gyroscope", newName)
    newName <- gsub("Mag", "Magnitude", newName)
    newName <- gsub("\\-", "\\.", newName)
    newName <- gsub("\\(\\)", "", newName)
    tolower(newName)
}
```

Then use the function to apply the prettified names to the table

``` r
names(summaryData) <- RenameColumns(names(summaryData))
```

Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-------------------------------------------------------------------------------------------------------------------------

``` r
tidysummary <- summaryData %>% 
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
```

Then write out the final data

``` r
write.table(format(tidysummary, scientific=T), 
            file = "tidy.txt", 
            row.name=FALSE)
```
