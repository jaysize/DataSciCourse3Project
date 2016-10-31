# DataSciCourse3Project
Final project for Getting and Cleaning Data - the third course of Data Science Specialization

# Synopsis
The goal of this course and this project are to demonstrate how to retreive, clean and organize a data set from an particular source so that it is tidy and ready for data science analysis.

# Code Outline
Combining, labeling, relabeling and aggregating the data is the main objective of this code.  The desired output will have the following characteristics: one variable per column, one unique observation per row, one table for each "kind" of variable and at least one column on which to link to other tables.  In this case, we will rely upon both text (for activity) and numeric (for subject) for the ability to link to other tables.

It executes the following process (the numbers match the comments preceeding each section of code in run_analysis.R)

1. Read the entire data set from the UCI website
2. Read the features, activity_labels, subject_test, subject_train, y_test, y_train, x_test, and X_train text files into data tables.
3. Assign "features" factor to column headings of xtest and xtrain.
4. Select only mean and standard deviation columns for each variable.
5. Add the activity codes (from y test and train) and subjects to our X test and train sets
6. Merge the activity labels to x_test and x_train on the activity codes
7. Drop the old activity codes and rename the activity and subject columns
8. Combine (or stack) test and training data sets
9. Rename columns to more descriptive names
10. Create a tidy summary table with the average of each variable for each activity and each subject.

# Motivation
This is created to demonstrate personal capability but also to serve as a reference to others on one of the many ways to process the Human Activity Recognition files from UCI.

# Installation
No complex installation is necessary.  Just cut and paste the code to your R environment.

# Tests
This code will completely execute all that is necessary to the user's current working directory.

# Contributors
The main source of this data comes from the following website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
While this git is not a conduit to contribute to the Human Activity Recognition project, you can feel free to improve upon this custom munging code by commeting or forking this git.

# License
No license is required for this code.
