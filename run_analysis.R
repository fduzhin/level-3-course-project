## Level 3 Data Science Track
## Course Project

### Summary of the data:

## There are two directories - test and train, 
## similarly structured. The sets of data from the two 
## directories are supposed to be merged.
## The sub-directory "Interial Signals" in both cases 
## contains the (almost) raw measurements from the accelerometer 
## and the gyriscope. 
## There are nine raw measurements:
# body_acc_x
# body_acc_y
# body_acc_z
# body_gyro_x
# body_gyro_y
# body_gyro_z
# total_acc_x
# total_acc_y
# total_acc_z
## Among these, the total_acc and the body_gyro sets are
## measured directly. Then total_acc is expressed as a sum:
## total_acc=body_acc+gravity_acc (using some clever technique)

## The files X_train.txt and X_test.txt
## are the interesting data sets - those obtained from
## the raw measurements by the study's authors.
## We are supposed to extract info from X_train.txt and X_test.txt.

## The files X_train.txt and X_test.txt contain thousands
## of measurements of 561 variables. Of those 561 variables,
## we are interested in mean and standard deviation
## of the nine raw measurements. Thus we need 18 variables:

# 1 tBodyAcc-mean()-X
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 4 tBodyAcc-std()-X
# 5 tBodyAcc-std()-Y
# 6 tBodyAcc-std()-Z
# 41 tGravityAcc-mean()-X
# 42 tGravityAcc-mean()-Y
# 43 tGravityAcc-mean()-Z
# 44 tGravityAcc-std()-X
# 45 tGravityAcc-std()-Y
# 46 tGravityAcc-std()-Z
# 121 tBodyGyro-mean()-X
# 122 tBodyGyro-mean()-Y
# 123 tBodyGyro-mean()-Z
# 124 tBodyGyro-std()-X
# 125 tBodyGyro-std()-Y
# 126 tBodyGyro-std()-Z

# We first create the vectors of indices and names
# of the required variables:
VAR <- c(1,2,3,4,5,6,41,42,43,44,45,46,121,122,123,124,125,126)
NAMES <- c("body.acc.mean.x","body.acc.mean.y","body.acc.mean.z",
           "body.acc.std.x","body.acc.std.y","body.acc.std.z",
           "grav.acc.mean.x","grav.acc.mean.y","grav.acc.mean.z",
           "grav.acc.std.x","grav.acc.std.y","grav.acc.std.z",
           "body.gyro.mean.x","body.gyro.mean.y","body.gyro.mean.z",
           "body.gyro.std.x","body.gyro.std.y","body.gyro.std.z")

# Names of the six activities:
ACTIVITIES <- c("WALKING", "WALKING UPSTAIRS",
                "WALKING DOWNSTAIRS", "SITTING",
                "STANDING", "LAYING")

## Read the subject and the activity from the two sets:
train.subjects <- read.table("./dataset/train/subject_train.txt")
train.activity <- read.table("./dataset/train/y_train.txt")
test.subjects <- read.table("./dataset/test/subject_test.txt")
test.activity <- read.table("./dataset/test/y_test.txt")

## Read the main data into R:
raw_x_train <- read.table("./dataset/train/X_train.txt")
raw_x_test <- read.table("./dataset/test/X_test.txt")

## Create the main data frame DF, name its variables, 
## and names the activities
DF <- rbind(data.frame(train.subjects,train.activity),
            data.frame(test.subjects,test.activity))
names(DF) <- c("subject","activity")
DF <- cbind(DF,rbind(raw_x_train[,VAR],raw_x_test[,VAR]))
names(DF)[3:20] <- NAMES
for (i in 1:nrow(DF)) {
  DF$activity[i] <- ACTIVITIES[as.numeric(DF$activity[i])]
}

## Save the tidy data into a file:
write.csv(DF,file="mean_and_std_tidy_data.csv")

## Create the new data set DFsum with a summary of the first data set.
## We are supposed to find the average of each variable
## for each activity and each subject

library(plyr)
DFsum <- ddply(DF, .(subject, activity), summarize, 
               average.body.acc.mean.x=mean(body.acc.mean.x),
               average.body.acc.mean.y=mean(body.acc.mean.y),
               average.body.acc.mean.z=mean(body.acc.mean.z),
               average.body.acc.std.x=mean(body.acc.std.x),
               average.body.acc.std.y=mean(body.acc.std.y),
               average.body.acc.std.z=mean(body.acc.std.z),
               average.grav.acc.mean.x=mean(grav.acc.mean.x),
               average.grav.acc.mean.y=mean(grav.acc.mean.y),
               average.grav.acc.mean.z=mean(grav.acc.mean.z),
               average.grav.acc.std.x=mean(grav.acc.std.x),
               average.grav.acc.std.y=mean(grav.acc.std.y),
               average.grav.acc.std.z=mean(grav.acc.std.z),
               average.body.gyro.mean.x=mean(body.gyro.mean.x),
               average.body.gyro.mean.y=mean(body.gyro.mean.y),
               average.body.gyro.mean.z=mean(body.gyro.mean.z),
               average.body.gyro.std.x=mean(body.gyro.std.x),
               average.body.gyro.std.y=mean(body.gyro.std.y),
               average.body.gyro.std.z=mean(body.gyro.std.z))

## Save the second tidy data set into a file:
write.csv(DFsum,file="average_values_by_subject_and_activity.csv")
