library(plyr)
library(dplyr)

## Download project dataset files and unzips the files into
## the designated UCI HAR Dataset folder

filename <- "downloaded_dataset.zip"
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}



## Reads in the data for features and activities labels
features <- read.table("UCI HAR Dataset/features.txt")
activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

## Reads in test datasets
## x table contains the actual measurements
## y table indicates which activity the corresponding row in x table is for
## subj table indicates which subject the corresponding row in x table comes from
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Reads in training datasets
## x table contains the actual measurements
## y table indicates which activity the corresponding row in x table is for
## subj table indicates which subject the corresponding row in x table comes from
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")


## Extracts only the measurements on 
## the mean and standard deviation 
## for each measurement.
## The mean is indicated by having "mean()" in the variable name
## The standard deviation is indicated by having "std()" in the variable name

test_x <- test_x[,grepl("*mean\\(\\)*|*std\\(\\)*",features[,2])]
train_x <- train_x[,grepl("*mean\\(\\)*|*std\\(\\)*",features[,2])]


## Appropriately labels the data set with 
## descriptive variable names
## by moving the "mean" and "std" indication to the end
## of the variable names and maintaining the coordinate X, Y, Z
## in the name and assignment the names to the x tables
features_names <- grep("*mean\\(\\)*|*std\\(\\)*",features[,2], value=TRUE)
features_names <- sub("-(mean|std)\\(\\)-(X|Y|Z)","_\\2_\\1",features_names)
features_names <- sub("-((mean|std))\\(\\)","_\\1",features_names)
features_names <- tolower(features_names)

names(test_x) <- features_names
names(train_x) <- features_names


## Renaming the subject variable names 
names(test_subj) <- "subject"
names(train_subj) <- "subject"

## Uses descriptive activity names to name 
## the activities in the data set
## by using information from activity_labels.txt files
test_y$V1 <- factor(test_y$V1)
levels(test_y$V1) <- activities_labels$V2
names(test_y) <- "activity"

train_y$V1 <- factor(train_y$V1)
levels(train_y$V1) <- activities_labels$V2
names(train_y) <- "activity"


## Combining all the tables for the test and train datasets
test <- cbind(test_subj,test_y,test_x)
train <- cbind(train_subj,train_y,train_x)

## Merges the training and the test sets to create one data set.
all_data <- rbind(test,train)

## Group data by subject and activity
groupped_data <- group_by(all_data, subject, activity)


## From the data set in step 4, creates a second, 
## independent tidy data set with the average of 
## each variable for each activity and each subject.
## by using the summarize_all function in the dplyr package
groupped_data <- summarize_all(groupped_data,"mean")

## write the resulting tidy dataset into a file "tidy.txt"
write.table(groupped_data,"tidy.txt",row.names = FALSE, quote = FALSE)