##downloads package if needed
if (!require("data.table")) {
  install.packages("data.table")
}


##loads package
require("data.table")

##read in files
train <- read.csv("UCI HAR Dataset\\train\\X_train.txt", header = FALSE, sep = "")
test  <- read.csv("UCI HAR Dataset\\test\\X_test.txt", header = FALSE, sep = "")
activity_labels  <- read.csv("UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep = "")
variable_names <- read.csv("UCI HAR Dataset\\features.txt", header = FALSE, sep = "")

##read in as vector
subject_train <- scan("UCI HAR Dataset\\train\\subject_train.txt")
activity_train <- scan("UCI HAR Dataset\\train\\y_train.txt")

subject_test <- scan("UCI HAR Dataset\\test\\subject_test.txt")
activity_test <- scan("UCI HAR Dataset\\test\\y_test.txt")

##pass the col names separately to the train and test data
colnames(train) <- variable_names$V2
colnames(test) <- variable_names$V2

##pass the activities and subjects to first the train, and after that the test data set, and also give the names of activities
train$activity <- activity_train
train$subject <- subject_train
train$activity_desc <- activity_labels[train$activity,]$V2

test$activity <- activity_test
test$subject <- subject_test
test$activity_desc <- activity_labels[test$activity,]$V2

##merge the named train and test sets
merged <- rbind(train, test)

##create a subset containing the mean and the standard deviation of the merged file
subset.mean.std <- merged$V2[grep("mean\\(\\)|std\\(\\)", merged$V2)]

##subset the tidy data set, containing the means by activities and subjects
tidyset <- dcast(merged, subject + activity_labels ~ variable, mean)

##export the tidy data set to a txt file
write.table(tidyset, file = "./tidyset.txt")
