# Code Book

This code book describes the variables, the data, and the transformations that were performed to clean up the data.

# Variables

The variables that were used in this project are from the UCI Human Activity Recognition from Smartphones data set.
There are two main sensors in the Samsung Galaxy smartphones that were used: an accelerometer and a gyroscope.  These basically measured linear and rotational movements of people in a study that were told to walk, sit, run, etc.  The data are measurements of multi-dimensional acceleration along with baseline gravity acceleration.  The data set has both time domain and fft signals denoted by "t" and "f" in the original data set. Different calculations and transformations were made from the original set, but we will focus on extracting the mean and standard deviation. 

# Data sets

The original data and labels are not all stored in the same table and they have also been split into test and training data sets labeled with suffixes _test and _train respectively.  The key data are stored in the X_test or train.txt files.  The labels for each variable (or column) are saved in a separate table  named "features.txt".  While each row represents a task being done by one person (or subject), the labels are store in separate tables as well. The subject labels are saved in subject_test or train.txt.  The activity keys are saved in y_test or train with the names saved in a key table called activities.txt.

The original measurement (variable) names are the following (with separate X, Y and Z variables just shown as XYX): 

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

# Transformation to Tidy Data

Combining, labeling, relabeling and aggregating the data is the main objective of this code.  The desired output will have the following characteristics: one variable per column, one unique observation per row, one table for each "kind" of variable and at least one column on which to link to other tables.  In this case, we will rely upon both text (for activity) and numeric (for subject) for the ability to link to other tables.

It executes the following process (the numbers match the comments preceeding each section of code in run_analysis.R)

1. Read the entire data set from the UCI website
2. Read the features, activity_labels, subject_test, subject_train, y_test, y_train, x_test, and X_train text files into data tables.
3. Assign "features" factor to column headings of xtest and xtrain.
4. Select only mean and standard deviation columns for each variable.
5. Merge y_test and y_train with the activity labels
6. Add the merged table of activities and subjects to our test and train sets
7. Rename activity and subject columns
8. Combine (or stack) test and training data sets that now have labels on the columns and rows
9. Rename columns to more descriptive names
10. Create a tidy summary table with the average of each variable for each activity and each subject.

The final, more comprehensible variable names are the following (with separate X, Y and Z variables just shown as XYX):
* timedomain_body_accelerometer-XYZ
* timedomain_gravity_acceleration-XYZ
* timedomain_body_accelerometer_jerk-XYZ
* timedomain_body_gyroscope-XYZ
* timedomain_body_gyroscope_jerk-XYZ
* timedomain_body_accelerometer_magnitude
* timedomain_gravity_acceleration_magnitude
* timedomain_body_accelerometer_jerk_magnitude
* timedomain_body_gyroscope_magnitude
* timedomain_body_gyroscope_jerk_magnitude
* fft_body_accelerometer-XYZ
* fft_body_accelerometer_jerk-XYZ
* fft_body_gyroscope-XYZ
* fft_body_accelerometer_magnitude
* fft_body_accelerometer_jerk_magnitude
* fft_body_gyroscope_magnitude
* fft_body_gyroscope_jerk_magnitude
