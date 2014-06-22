##Getting and Cleaning Data Project
This project is for the course "Getting and Cleaning Data".

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

###Merges the training and the test sets to create one data set.

Read six files are used in the this task:
	X_test
	Y_test
	subject_test
	X_train
	Y_train
	subject_train
For convienience in the future, give each column a reasonable name.
Next row bind train data and test data, and then column bind data X, Y and subject.


###Extracts only the measurements on the mean and standard deviation for each measurement.

Get all column numbers whose corresponding column name contains "mean()" or "std()". Make a list of it. Thne get only chosen columns, but also keep "subject" and "activity" columns.

###Uses descriptive activity names to name the activities in the data set

Replace the column names to descriptive variable names from the file "feature.txt"

###Appropriately labels the data set with descriptive variable names. 

Read "activity_labels.txt" and then apply the activity_labels to "activity" column, which makes numbers are substituted by strings.

###Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Split the data by "activity" and "subject", by them we get a data frame for each combination of "activity" and "subject". 

For each data frame, calculate the mean of each column. Reshape the final data by "melt" function.

Save the final data a text file named "mean on activity & subject.txt".