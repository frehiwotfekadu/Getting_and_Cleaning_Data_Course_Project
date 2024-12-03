library(dplyr)

#Downloading all Data Sets
filename <- "Getting_and_Cleaning_Data_Course_Project.zip"

if(!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}

if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}
#Reading an assignining datasets
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))


test_set <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

test_labels <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "code")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")


training_set <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

training_labels <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "code")

subject_training <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

#Merging the training and the test sets to create one data set

merged_set <- rbind(test_set, training_set)

merged_labels <- rbind(test_labels, training_labels)

merged_subject <- rbind(subject_test, subject_training)


Merged_data <- cbind(merged_subject, merged_labels, merged_set)

#Extracting only the measurements on the mean and standard deviation for each measurement
TidyData <- Merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

#Using descriptive activity names to name the activities in the data set
TidyData$code <- activities[TidyData$code, 2]

#Appropriately labeling the data set with descriptive variable names. 
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#From the above data set creating a second, independent tidy data set with the 
#average of each variable for each activity and each subject
Final_Data <- TidyData %>%
  group_by(subject, activity) %>%
 summarise_all(list(mean = mean))
write.table(Final_Data, "Final_Tidy_Data.txt", row.names = FALSE)