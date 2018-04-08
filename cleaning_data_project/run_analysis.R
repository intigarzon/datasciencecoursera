# Requirement 1:  Merges the training and the test sets to create one data set

# define the url
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download the data set from url above
download.file(url,destfile="./UCI HAR Dataset.zip")

# Read activity files
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
table(trainLabel)
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 
table(testLabel)

# Read data file
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
dim(trainData) 
head(trainData)
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
dim(testData)

# Read subject file
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")


# Merge both training and test sets
joinData <- rbind(trainData, testData)
dim(joinData)
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) 
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)

# Requirement 2: Extracts only the measurements on the mean and 
# standard deviation for each measurement
#first get features
features <- read.table("./UCI HAR Dataset/features.txt")
dim(features) 
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) 
joinData <- joinData[, meanStdIndices]
dim(joinData) 
# clean column names
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove brackets
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalise M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalise S
names(joinData) <- gsub("-", "", names(joinData)) # remove dashes


#Requirement 3: Uses descriptive activity names to name the activities in the data set 
# Read activity from data
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

# modify names removing underscores
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

#Requirement 4: Appropriately labels the data set with descriptive activity names
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)
# finally write cleaned data 
write.table(cleanedData, "merged_data.txt")

#Requirement 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
# output to file second datatset
write.table(result, "means_data.txt")