# This is the code book for Getting and Cleaning Data course project

# About the source data

The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# About R script
The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1.Download the dataset

2.Assign each data to variables
* features <- features.txt: The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* activities <- activity_labels.txt :List of activities performed when the corresponding measurements were taken and its codes (labels)
* subject_test <- test/subject_test.txt :contains test data of 9/30 volunteer test subjects being observed
* test_set <- test/X_test.txt :contains recorded features test data
* test_lables <- test/y_test.txt :contains test data of activities’code labels
* subject_training <- test/subject_train.txt : contains train data of 21/30 volunteer subjects being observed
* training_set <- test/X_train.txt :contains recorded features train data
* trainging_lables <- test/y_train.txt :contains train data of activities’code labels

3.Merges the training and the test sets to create one data set
* merged_set is created by merging test_set and training_set using rbind() function
* merged_labels is created by merging test_lables and training_lables using rbind() function
* merged_subject  is created by merging subject_training and subject_test using rbind() function
* Merged_data  is created by merging Subject, Y and X using cbind() function

4.Extracts only the measurements on the mean and standard deviation for each measurement
        TidyData is created by subsetting Merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5.Uses descriptive activity names to name the activities in the data set
        Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

6.Appropriately labels the data set with descriptive variable names:
* code column in TidyData renamed into activities
* All Acc in column’s name replaced by Accelerometer
* All Gyro in column’s name replaced by Gyroscope
*  All BodyBody in column’s name replaced by Body
*  All Mag in column’s name replaced by Magnitude
* All start with character f in column’s name replaced by Frequency
* All start with character t in column’s name replaced by Time

7.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* Final_Data is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
* Export FinalData into Final_Tidy_Data.txt file.
      
        


