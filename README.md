# Project---Getting-and-Cleaning-Data
This script was made to demonstrate the ability to collect, work with, and clean a data set.

Initially, the libraries were loading and the data download. Next, the files were reading.

There are 5 exercises corresponding to:
1. Merges the training and the test sets to create one data set.
  To do this the functions rbind and cbind were used.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
  With the function select, the columns that contains "mean" and "std" were selected
3. Uses descriptive activity names to name the activities in the data set
  Using the merge function
4. Appropriately labels the data set with descriptive variable names.
  Using the gsub function
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  Using pipes

The data was taken from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
