library(dplyr)

## data download process

filename <- "Getting_and_Cleaning_Data_Course_Project_Assignment_4"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


##assignment of each data set

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



## 1. Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
MeanSD <- Merged_Data %>%
  select(subject, code, contains("mean"), contains("std"))


##3. Uses descriptive activity names to name the activities in the data set
MeanSD$code <- activities[MeanSD$code, 2]


##4. Appropriately labels the data set with descriptive variable names. 
names(MeanSD)[2] = "activity"
names(MeanSD) <- gsub("Acc", "Accelerometer", names(MeanSD))
names(MeanSD) <- gsub("Gyro", "Gyroscope", names(MeanSD))
names(MeanSD) <- gsub("BodyBody", "Body", names(MeanSD))
names(MeanSD) <- gsub("Mag", "Magnitude", names(MeanSD))
names(MeanSD) <- gsub("^t", "Time", names(MeanSD))
names(MeanSD) <- gsub("^f", "Frequency", names(MeanSD))
names(MeanSD)<-gsub("tBody", "TimeBody", names(MeanSD))
names(MeanSD)<-gsub("-mean()", "Mean", names(MeanSD), ignore.case = TRUE)
names(MeanSD)<-gsub("-std()", "STD", names(MeanSD), ignore.case = TRUE)
names(MeanSD)<-gsub("-freq()", "Frequency", names(MeanSD), ignore.case = TRUE)
names(MeanSD)<-gsub("angle", "Angle", names(MeanSD))
names(MeanSD)<-gsub("gravity", "Gravity", names(MeanSD))


##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData <- MeanSD %>%
  group_by(subject, activity) %>%
  summarise_all(mean)
write.table(TidyData, "TidyData.txt", row.name = FALSE)


