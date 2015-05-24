
if (!require("data.table")) {
  install.packages("data.table")
}

require("data.table")

train <- read.csv("UCI HAR Dataset\\train\\X_train.txt", header = FALSE, sep = "")
test  <- read.csv("UCI HAR Dataset\\test\\X_test.txt", header = FALSE, sep = "")
activity_labels  <- read.csv("UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep = "")
variable_names <- read.csv("UCI HAR Dataset\\features.txt", header = FALSE, sep = "")

subject_train <- scan("UCI HAR Dataset\\train\\subject_train.txt")
activity_train <- scan("UCI HAR Dataset\\train\\y_train.txt")

subject_test <- scan("UCI HAR Dataset\\test\\subject_test.txt")
activity_test <- scan("UCI HAR Dataset\\test\\y_test.txt")

colnames(train) <- variable_names$V2
colnames(test) <- variable_names$V2

train$activity <- activity_train
train$subject <- subject_train
train$activity_desc <- activity_labels[train$activity,]$V2

test$activity <- activity_test
test$subject <- subject_test
test$activity_desc <- activity_labels[test$activity,]$V2

merged <- rbind(train, test)


subset.mean.std <- merged$V2[grep("mean\\(\\)|std\\(\\)", merged$V2)]


tidyset <- dcast(merged, subject + activity_labels ~ variable, mean)

write.table(tidyset, file = "./tidyset.txt")

