# Getting-and-Cleaning-Data
This repository is for submission of the course project for the Johns Hopkins Getting and Cleaning Data course

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The R script, run_analysis.R, does the following:

1. Download the dataset from the given link
2. Merge the training and the test sets to create one data set.
3. Extract only the measurements on the mean and standard deviation for each measurement.
4. Use descriptive activity names to name the activities in the data set
5. Appropriately label the data set with descriptive variable names.
6 .Creating a tidy data set with the average of each variable for each activity and each subject TidyDataSet.txt
