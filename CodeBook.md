

## Getting and Cleaning Data Assignment Code Book

The script 'run_analysis.R' performs the 5 steps in getting and cleaning the original dataset as stated in the assignment instructions.

#1. Data Download

Data was downloaded from the following url: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


#2.Assigning each data set to variables

'features' - contains the 'features.txt' data set
'activities' - contains the 'activiy_labels.txt' data set
'subject_test' - contains the 'subject_test.txt' data set
'x_test' - contains the 'x_test.txt' data set
'y_test' - contains the 'y_test.txt' data set
'subject_train' - contains the 'subject_train.txt' data set
'x_train' - contains the 'x_train.txt; data set
'y_train' - contains the 'y_train.txt' data set


#3.Merges the training and the test sets to create one data set

'x_train' and 'x_test' is merged in and assigned to 'X' with rbind()
'y_train' and 'y_test' is merged and assigned to 'Y' with rbind()
'subject_train' and 'subject_test is merged and assigned to 'Subject' with rbind()

'X', 'Y' and 'Subject' are merged and assigned to 'Merged_Data'


#4. Extracts only the measurements on the mean and standard deviation for each measurement

The 'subject', 'code', 'mean' and 'std' data are selected from 'Merged_Data' and assigned to 'MeanSD'


#5.Uses descriptive activity names to name the activities in the data set
The actual 'activities' are selected to replace the 'code' numbers in 'MeanSD'


#6. Appropriately labels the data set with descriptive variable names
Shortened column names in the original data set are replaced with the words in full.



#7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
'MeanSD' is grouped by 'subject' and 'activity' and the mean of each value is taken and assigned to the independent 'TidyData'



