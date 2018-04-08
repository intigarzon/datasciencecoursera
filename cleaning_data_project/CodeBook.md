## For this work, data analysed represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data for the project was obtained from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Following, you can find code description for variables, data and any other work done to clean up the data through "run_analysis.R" script:

1. Download the data set from the address mentioned above.

2. Read both training and test data sets
Read X_train.txt, y_train.txt and subject_train.txt from the "./UCI HAR Dataset/data/train" folder and store them in trainData,trainLabel and trainSubject variables respectively. Also, read X_test.txt, y_test.txt and subject_test.txt from the "./UCI HAR Dataset/data/test" folder and store them in testData, testLabeland testsubject variables respectively.

3. Merge both test and training dataset
Concatenate testData to trainData to obtain joinData data frame, testLabel to trainLabel (joinLabel), and testSubject to trainSubject (joinSubject).

4. Read features file
Read features.txt file from "./UCI HAR Dataset/data" folder and store mean and standard deviation data in 'features', which is a subset of joinData.

5. Clean subset column names
Column names are modified to remove bracket and dash symbols in names, as well as convert into capital letters the initials for "mean" and "std" ("M" and "S" respectively).

6. Read the activity_labels
Read the activity_labels.txt file from the "./UCI HAR Dataset/data" folder and store the data in a variable called activity.

7. Clean names in the second column of activity
Make all names lower cases and remove underscore if the name has has it.

8. Combine the joinSubject, joinLabel and joinData and output to file
Combine the joinSubject, joinLabel and joinData by column to get cleanedData. Rename first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
Output cleanedData to "merged_data.txt" file.

9. Generate a copy data set to average each measurement
Work out averages for each activity and subject in a new copy of merged_data.txt. It is done through a for loop to cover up all combinations obtaining a new data frame.
This data frame is output to "means_data.txt".