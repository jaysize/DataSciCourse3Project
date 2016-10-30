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
names(xtest)
names(xtrain)


# 5. Merge y_test and y_train with the activity labels
test_activities = merge(ytest,activities,by.x="V1", by.y="V1")
train_activities = merge(ytrain,activities,by.x="V1", by.y="V1")

# 6. Add the merged table of activities and subjects to our test and train sets
xtest <- cbind(test_activities$V2, xtest)
xtest <- cbind(subject_test$V1, xtest)
xtrain <- cbind(train_activities$V2, xtrain)
xtrain <- cbind(subject_train$V1, xtrain)

# 7. Rename activity and subject columns
setnames(xtest,"test_activities$V2","activity")
setnames(xtest, "subject_test$V1", "subject")
names(xtest)
setnames(xtrain,"train_activities$V2","activity")
setnames(xtrain, "subject_train$V1", "subject")
names(xtrain)

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
names(xtotal)


# 10. Create a tidy summary table with the average of each variable 
# for each activity and each subject.
xsummary <- xtotal %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean(., na.rm=TRUE)))
xsummary
