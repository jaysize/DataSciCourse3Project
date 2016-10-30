# Code Book

This code book describes the variables, the data, and the transformations that were performed to clean up the data.

# Variables

The variables that were used in this project are from the UCI Human Activity Recognition from Smartphones data set.
* There are two main sensors in the Samsung Galaxy smartphones that were used: an accelerometer and a gyroscope.  These basically measured linear and rotational movements of people in a study that were told to walk, sit, run, etc.  The data are measurements of multi-dimensional acceleration along with baseline gravity acceleration.  The data set has both time domain and fft signals denoted by "t" and "f" in the original data set. Different calculations and transformations were made from the original set, but we will focus on extracting the mean and standard deviation. The original variables followed the following name structure:

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

# Data sets

The original data and labels are not all stored in the same table and they have also been split into test and training data sets labeled with suffixes _test and _train respectively.  The key data are stored in the X_test or train.txt files.  The labels for each variable (or column) are saved in a separate table  named "features.txt".  While each row represents a task being done by one person (or subject), the labels are store in separate tables as well. The subject labels are saved in subject_test or train.txt.  The activity keys are saved in y_test or train with the names saved in a key table called activities.txt.

The original measurement (variable) names were: 

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

# Transformation

Combining, labeling and aggregating the data is the main objective of this code.  It executes the following process

1
