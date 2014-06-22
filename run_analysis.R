#################################################################
## Read all needed data in ##
#################################################################

# Read all data from the folder
X_test <- read.csv("test/X_test.txt",header= FALSE,sep="")
Y_test <- read.csv("test/Y_test.txt",header= FALSE,sep="")
subject_test <- read.csv("test/subject_test.txt",header= FALSE,sep="")
X_train <- read.csv("train/X_train.txt",header= FALSE,sep="")
Y_train <- read.csv("train/Y_train.txt",header= FALSE,sep="")
subject_train <- read.csv("train/subject_train.txt",header= FALSE,sep="")

##################################################################
## task 1: Merges the training and the test sets to create 
##         one data set.
##################################################################

# Combine train data and test data
X <- rbind(X_train,X_test)
Y <- rbind(Y_train,Y_test)
subject <- rbind(subject_train,subject_test)

# Give names to each columns, which makes the data recognizable
X_colnames <- read.csv("features.txt",header = FALSE,sep="")
colnames(X) <- X_colnames[,1]
colnames(Y) <- "activity"
colnames(subject) <- "subject"

# Combine all X,Y and subject together
data <- cbind(X,Y,subject)

##################################################################
## task 2: Extracts only the measurements on the mean and 
##         standard deviation for each measurement. 
##################################################################

# Get all columns numbers whose column name contains mean() or std().
X_ncol <- ncol(X)
keep_col <- c()
for(i in 1:X_ncol){
  if(grepl("mean()",X_colnames[i,2],fixed=TRUE) | grepl("std()",X_colnames[i,2],fixed=TRUE)){
    keep_col <- append(keep_col,i)
  }
}

# Get only chosen columns
Extracted_data <- data[,c(keep_col,562,563)]

##################################################################
## task 3: Appropriately labels the data set with descriptive 
##         variable names.
##################################################################

Extracted_data_copy <- Extracted_data

# Replace the column names to descriptive variable names from 
# "feature.txt" file.
replace_X_names <- function(x){
  if(x %in% X_colnames[,1]){
    as.character(X_colnames[as.numeric(x),2])
  }
  else x 
}
colnames(Extracted_data_copy) <- lapply(colnames(Extracted_data_copy),replace_X_names)


##################################################################
## task 4: Uses descriptive activity names to name the activities 
##         in the data set
##################################################################

# Read activity_labels file
activity_labels <- read.csv("activity_labels.txt",header = FALSE,sep="")

# Apply the activity_labels to "activity" column
replace_activity <- function(x){
  activity_labels[x,2]
}
Extracted_data_copy$activity <- sapply(Extracted_data_copy$activity,replace_activity)

##################################################################
## task 5: Creates a second, independent tidy data set with the 
##         average of each variable for each activity and each 
##         subject. 
##################################################################

# Split the data by "activity" & "subject"
multiple <- split(Extracted_data,Extracted_data[,c("activity","subject")])

# Calculate the mean of each column by "activity" & "subject"
single_mean <- function(x){
  apply(x,2,mean)
}
multiple_mean <- as.data.frame(lapply(multiple,function(x) single_mean(x)))
n <- nrow(multiple_mean)-2

# Reshape the final data
library(reshape2)
df <- as.data.frame(t(multiple_mean))
names <- row.names(multiple_mean[1:n,])
final_data <- melt(df,id=c("subject","activity"),measure.vars=names)
colnames(final_data) <- c("subject","activity","features","mean")

# Save the final data as a text file
# Please see the codebook for understanding numbers inside
write.csv(final_data,"mean on activity & subject.txt")


