Getting and Cleaning Data: Course Project
=========================================

Summary of the data and the project's objective:
-----------------------------------------------

There are two directories - `test` and `train`, similarly structured. The sets of data from the two directories are supposed to be merged. The sub-directory `Interial Signals` in both cases contains the (almost) raw measurements from the accelerometer and the gyriscope. 

There are nine raw measurements:
 1. body_acc_x
 2. body_acc_y
 3. body_acc_z
 4. body_gyro_x
 5. body_gyro_y
 6. body_gyro_z
 7. total_acc_x
 8. total_acc_y
 9. total_acc_z

Among these, the total_acc and the body_gyro sets are measured directly. Then total_acc is expressed as a sum: total_acc=body_acc+gravity_acc (using some clever technique).

The files `X_train.txt` and `X_test.txt` are the interesting data sets - those obtained from the raw measurements by the study's authors. We are supposed to extract info from `X_train.txt` and `X_test.txt`.

The files `X_train.txt` and `X_test.txt` contain thousands of measurements of 561 variables. Of those 561 variables, we are interested in mean and standard deviation of the nine raw measurements. Thus we need 18 variables:

 1. tBodyAcc-mean()-X
 2. tBodyAcc-mean()-Y
 3. tBodyAcc-mean()-Z
 4. tBodyAcc-std()-X
 5. tBodyAcc-std()-Y
 6. tBodyAcc-std()-Z
 41. tGravityAcc-mean()-X
 42. tGravityAcc-mean()-Y
 43. tGravityAcc-mean()-Z
 44. tGravityAcc-std()-X
 45. tGravityAcc-std()-Y
 46. tGravityAcc-std()-Z
 121. tBodyGyro-mean()-X
 122. tBodyGyro-mean()-Y
 123. tBodyGyro-mean()-Z
 124. tBodyGyro-std()-X
 125. tBodyGyro-std()-Y
 126. tBodyGyro-std()-Z

Description of the analysis to produce the first tidy data set:
---------------------------------------------------------------

First, we read all the raw data from the files 
 * `./dataset/train/subject_train.txt`
 * `./dataset/train/y_train.txt`
 * `./dataset/test/subject_test.txt`
 * `./dataset/test/y_test.txt`

Then we create the main data frame **DF** by merging the subject info, the activity info, and the subset of the main data containing the following columns: 1,2,3,4,5,6,41,42,43,44,45,46,121,122,123,124,125,126 (these are the 18 variables we are supposed to extract according to the project's description).

Further, we add the following descriptive names to the columns:
"subject", "activity", "body.acc.mean.x","body.acc.mean.y","body.acc.mean.z", "body.acc.std.x","body.acc.std.y","body.acc.std.z", "grav.acc.mean.x","grav.acc.mean.y","grav.acc.mean.z", "grav.acc.std.x","grav.acc.std.y","grav.acc.std.z", "body.gyro.mean.x","body.gyro.mean.y","body.gyro.mean.z","body.gyro.std.x,"body.gyro.std.y","body.gyro.std.z"

Then we rename the six activities, i.e., the values in the corresponding row of the main date frame, from 1,2,3,4,5,6 to "WALKING", "WALKING UPSTAIRS","WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING" respectively.

Finally, we save the data frame **DF** into the file `mean_and_std_tidy_data.csv`

Description of the analysis to produce the second tidy data set:
---------------------------------------------------------------

Here we just use the function *ddply* from the library *plyr* to produce the mean of each of the 18 variables factored by the subject and the activity. We call the new data frame **DFsum**. The data frame **DFsum** is then saved into the file `average_values_by_subject_and_activity.csv`
