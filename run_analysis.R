#Getting and Cleaning Data Course Project

#Loading the libraries
library(dplyr)
library(stringr)

# Download data
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Data.zip")
#Unzip data 
unzip(zipfile="./data/Data.zip",exdir="./data")


#Reading the files
features <- read.table('data\\features.txt', col.names = c("Id","Features"))
activity <- read.table('data\\activity_labels.txt', col.names = c("Id","Activity"))
subject_test <- read.table('data\\test\\subject_test.txt', col.names = "Subject")
x_test <- read.table('data\\test\\X_test.txt', col.names = features$Features)
y_test <- read.table('data\\test\\y_test.txt', col.names = "Y")
subject_train <- read.table('data\\train\\subject_train.txt', col.names = "Subject")
x_train <- read.table('data\\train\\X_train.txt', col.names = features$Features)
y_train <- read.table('data\\train\\y_train.txt', col.names = "Y")

#1. Merges the training and the test sets to create one data set
subject <- rbind(subject_test, subject_train)
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
data <- cbind(x, y, subject)
dim(data)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
Measure_mean_sd <- select(data, "Subject", Y, contains("mean"), contains("std"))
names(Measure_mean_sd)


#3. Uses descriptive activity names to name the activities in the data set
Measure_mean_sd <- merge(Measure_mean_sd, activity, by.x = "Y", by.y = "Id", all.x = TRUE)

#4. Appropriately labels the data set with descriptive variable names
names(Measure_mean_sd)
names(Measure_mean_sd) <- gsub("^t", "Time", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("Acc", "Accelerometer", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("Gyro", "Gyroscope", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("Mag", "Magnitude", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("^f", "Frequency", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("...X", "_X", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("...Y", "_Y", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("...Z", "_Z", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("mean", "Mean", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("std", "Std", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("std", "Std", names(Measure_mean_sd))
names(Measure_mean_sd) <- gsub("BodyBody", "Body", names(Measure_mean_sd))
names(Measure_mean_sd)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Mean_data <- Measure_mean_sd %>% group_by(Activity, Subject) %>% summarise_all(list(~mean)) %>% as.data.frame(Mean_data)
head(Mean_data)
str(Mean_data)

write.table(Mean_data, "DataProject.txt", row.name=FALSE)
