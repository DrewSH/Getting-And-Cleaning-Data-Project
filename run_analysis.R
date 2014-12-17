## Setting Libraries
library(reshape2)

##Creating Project Folder
dir.create("./Coursera/GCD_Project", showWarnings = FALSE)

## Retrieving Data for Both Training and Test
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Coursera/GCD_Project/data.zip",mode="wb")
unzip("./GCD_Project/data.zip",exdir="./Coursera/GCD_Project")

act_labels <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/activity_labels.txt")

features <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/features.txt")[,2]

##PROJECT TASK:Extracts only the measurements on the mean and standard deviation
##for each measurement.
  ##extract_features will be used to filter X_Train and X_Test below
extract_features <- grepl("mean|std", features)

## Retrieve Training Data
X_Train <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/train/X_train.txt")
Y_Train <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/train/Y_train.txt")

sub_Train <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/train/subject_train.txt")
names(sub_Train) = "Subject"

##PROJECT TASK:Appropriately labels the data set with descriptive variable names
  ## Adding feature names, from features, to be column names for X_Train
names(X_Train) = features
X_Train = X_Train[,extract_features]

##PROJECT TASK: Uses descriptive activity names to name the activities in the data set
  ## merging activity labels to Y_train by "ID"
YTrain_wLabels<-merge(Y_Train,act_labels)
names(YTrain_wLabels) = c("Activity_ID", "Activity_Desc")

## combine Trainings files
Train<-cbind(sub_Train,YTrain_wLabels,X_Train)

## Retrieving Test Data
X_Test <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/test/X_test.txt")
Y_Test <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/test/Y_test.txt")

sub_test <- read.table("./Coursera/GCD_Project/UCI HAR Dataset/test/subject_test.txt")
names(sub_test) = "Subject"

## Adding feature names, from features, to be column names for X_Train
names(X_Test) = features
X_Test = X_Test[,extract_features]

##PROJECT TASK: Uses descriptive activity names to name the activities in the data set
  ## merging activity labels to Y_test by "ID"
YTest_wLabels<-merge(Y_Test,act_labels)
names(YTest_wLabels) = c("Activity_ID", "Activity_Desc")

## combine Test files
Test<-cbind(sub_test,YTest_wLabels,X_Test)

##PROJECT TASK: Merges the training and the test sets to create one data set
  ##Combine Test and Train
Combined<-rbind(Test,Train)

##PROJECT TASK: From the "Combined" data set, creates a second, independent
  ##tidy data set with the average of each variable for each activity 
  ##and each subject.
id_labels   = c("Subject", "Activity_ID", "Activity_Desc")
data_labels = setdiff(colnames(Combined), id_labels)
melt_combined = melt(Combined, id = id_labels, measure.vars = data_labels)
tidy_combined = dcast(melt_combined, Subject + Activity_Desc ~ variable, mean)

##Exporting/Writing the final tidy table out to local drive
write.table(tidy_combined, file = "./Coursera/GCD_Project/tidy_data.txt",row.name=FALSE)
