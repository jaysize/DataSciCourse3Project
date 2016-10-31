# This is the code for the final project of Getting and Cleaning Data
# The goal of this code is to process a large and multi-data table into a 
# single tidy set along with a summarized version using mean as aggregation.

library(plyr)
library(dplyr)
library(data.table)
library(downloader)

# 1. Read the entire data set from the UCI website
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip")

# 2. Read the features, activity_labels, subject_test, subject_train, 
#           y_test, y_train, x_test, and X_train text files into data tables.
features <- read.table('./UCI HAR Dataset/features.txt')
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
ytest <- read.table('./UCI HAR Dataset/test/y_test.txt')
ytrain <- read.table('./UCI HAR Dataset/train/y_train.txt')
xtest <- read.table('./UCI HAR Dataset/test/X_test.txt')
xtrain <- read.table('./UCI HAR Dataset/train/X_train.txt')
xtest <- tbl_df(xtest)
xtrain <- tbl_df(xtrain)

# 3. Assign "features" factor to column headings of xtest and xtrain.
colnames(xtest) <- features[,2]
colnames(xtrain) <- features[,2]
xtest <- xtest[ , !duplicated(colnames(xtest))]
xtrain <- xtrain[ , !duplicated(colnames(xtrain))]

# 4. Select only mean and standard deviation columns for each variable.
xtestmean <- select(xtest, contains("mean()"))
xteststd <- select(xtest, contains("std()"))
xtrainmean <- select(xtrain, contains("mean()"))
xtrainstd <- select(xtrain, contains("std()"))
xtest <- cbind(xtestmean,xteststd)
xtrain <- cbind(xtrainmean, xtrainstd)


# 5. Add the activity codes (from y test and train) and subjects to our X test and train sets
xtest <- cbind(ytest$V1, xtest)
xtest <- cbind(subject_test$V1, xtest)
xtrain <- cbind(ytrain$V1, xtrain)
xtrain <- cbind(subject_train$V1, xtrain)


# 6. Merge the activity labels to x_test and x_train on the activity codes
xtest <- merge(activities,xtest,by.x="V1", by.y="ytest$V1")
xtrain <- merge(activities,xtrain,by.x="V1", by.y="ytrain$V1")
xtest <- tbl_df(xtest)
xtrain <- tbl_df(xtrain)


# 7. Drop the old activity codes and rename the activity and subject columns
setnames(xtest,"V1","activitycode")
setnames(xtrain,"V1","activitycode")
xtest$activitycode <- NULL
xtrain$activitycode <- NULL
setnames(xtest, "subject_test$V1", "subject")
setnames(xtrain, "subject_train$V1", "subject")
setnames(xtest, "V2", "activity")
setnames(xtrain, "V2", "activity")

# 8. Combine (or stack) test and training data sets
xtotal <- rbind(xtest, xtrain)
xtotal<- tbl_df(xtotal)

# 9. Rename columns to more descriptive names
names(xtotal) <- gsub("BodyBody", "Body", names(xtotal))
names(xtotal) <- gsub("[-][m][e][a][n][(][)]", "_mean", names(xtotal))
names(xtotal) <- gsub("[-][s][t][d][(][)]", "_stdev", names(xtotal))
names(xtotal) <- gsub("BodyAcc", "body_accelerometer", names(xtotal))
names(xtotal) <- gsub("BodyGyro", "body_gyroscope", names(xtotal))
names(xtotal) <- gsub("Jerk", "_jerk", names(xtotal))
names(xtotal) <- gsub("GravityAcc", "gravity_acceleraation", names(xtotal))
names(xtotal) <- gsub("Mag", "_magnitude", names(xtotal))
names(xtotal) <- gsub("fbody", "fft_body", names(xtotal))
names(xtotal) <- gsub("tbody", "timedomain_body", names(xtotal))
names(xtotal) <- gsub("tgravity", "timedomain_gravity", names(xtotal))
xtotal


# 10. Create a tidy summary table with the average of each variable 
# for each activity and each subject.
xsummary <- xtotal %>%
  group_by(activity, subject) %>%
  summarise_each(funs(mean(., na.rm=TRUE)))
xsummary

# optional for making an output file of the summary data set
# write.table(xsummary, file = "ProjectSummary.txt", row.name=FALSE)

