# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Additional Steps Completed Within Code
1. A new project folder is created for this program.
2. Human Activity Recognition Using Smartphones Data Set (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is downloaded and unzipped automatically.
3. End result, "tidy" data, is exported to the project folder as a text file automatically.

## Steps to work on this course project
1. Put ```run_analysis.R``` in your current work directory.
2. Run ```source("run_analysis.R")```, then it will generate a new file ```tiny_combined.txt``` in the project folder, within your working directory.
