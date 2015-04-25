# Codebook
This is a codebook for course project of Getting and Cleaning Data course. It explains how the script in "run_analysis.R" file works and transforms the data.

## Input
- **run_analysis.R**	script into working directory
- **UCI HAR Dataset**	directory into working directory

## Output
**cleandata.txt**	file in the working directory

## Description of cleandata.txt
Cols. 1-79:				numeric		various mean and standard deviation measurements

(the full list of measurements is in the next section)

Col. 80	(*subject*):	numeric		subject labels

Col. 81	(*activity*):	character	activity names

Separator is ";"

No row names

Contains average of each measurement for each subject and each activity.

### Measurements details
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag


The set of variables that were estimated from these signals and selected for the new dataset are: 

mean(): Mean value

std(): Standard deviation


Each of 30 subjects performed six activities (walking, walking_upstairs, walking_downstairs, sitting, standing, laying) and for each activity all the aforementioned measurements were collected.

Then the mean for each measurement for each subject and each activity was found to form a new dataset.


#### Full measurements variables names list
tBodyAcc-mean()-X

tBodyAcc-mean()-Y

tBodyAcc-mean()-Z

tBodyAcc-std()-X

tBodyAcc-std()-Y

tBodyAcc-std()-Z

tGravityAcc-mean()-X

tGravityAcc-mean()-Y

tGravityAcc-mean()-Z

tGravityAcc-std()-X

tGravityAcc-std()-Y

tGravityAcc-std()-Z

tBodyAccJerk-mean()-X

tBodyAccJerk-mean()-Y

tBodyAccJerk-mean()-Z

tBodyAccJerk-std()-X

tBodyAccJerk-std()-Y

tBodyAccJerk-std()-Z

tBodyGyro-mean()-X

tBodyGyro-mean()-Y

tBodyGyro-mean()-Z

tBodyGyro-std()-X

tBodyGyro-std()-Y

tBodyGyro-std()-Z

tBodyGyroJerk-mean()-X

tBodyGyroJerk-mean()-Y

tBodyGyroJerk-mean()-Z

tBodyGyroJerk-std()-X

tBodyGyroJerk-std()-Y

tBodyGyroJerk-std()-Z

tBodyAccMag-mean()

tBodyAccMag-std()

tGravityAccMag-mean()

tGravityAccMag-std()

tBodyAccJerkMag-mean()

tBodyAccJerkMag-std()

tBodyGyroMag-mean()

tBodyGyroMag-std()

tBodyGyroJerkMag-mean()

tBodyGyroJerkMag-std()

fBodyAcc-mean()-X

fBodyAcc-mean()-Y

fBodyAcc-mean()-Z

fBodyAcc-std()-X

fBodyAcc-std()-Y

fBodyAcc-std()-Z
fBodyAccJerk-mean()-X

fBodyAccJerk-mean()-Y

fBodyAccJerk-mean()-Z

fBodyAccJerk-std()-X

fBodyAccJerk-std()-Y

fBodyAccJerk-std()-Z

fBodyGyro-mean()-X

fBodyGyro-mean()-Y

fBodyGyro-mean()-Z

fBodyGyro-std()-X

fBodyGyro-std()-Y

fBodyGyro-std()-Z

fBodyAccMag-mean()

fBodyAccMag-std()

fBodyBodyAccJerkMag-mean()

fBodyBodyAccJerkMag-std()

fBodyBodyGyroMag-mean()

fBodyBodyGyroMag-std()

fBodyBodyGyroJerkMag-mean()

fBodyBodyGyroJerkMag-std()


## The raw data
The raw data was given in the form of .zip archive that contains a directory named "UCI HAR Dataset". I assume that this folder is in the working directory along with the "run_analysis.R" script.

The raw data inside the "UCI HAR Dataset" directory consists of two folders ("test" with the test data and "train" with the training data) and a few files of which "activity_labels.txt" and "features.txt" are of interest. Each of "test" and "train" directories contains files with various measurements ("X_test.txt" and "X_train.txt" respectively), activity type data ("y_test.txt" and "y_train.txt") and subjects data ("subjects_test.txt" and "subjects_train.txt").



## Important inner variables
**testdata**	2947 obs.	of 563 variables	raw test dataset

**traindata**	7352 obs.	of 563 variables	raw training dataset

**features**	561 obs.	of 2 variables		list of all measured features

**activities**	6 obs. 		of 2 variables		activities names and class labels

**alldata**		10299 obs.	of 563 variables	test and training datasets merged together

**filterdata**	10299 obs.	of 81 variables		filtered data for mean and standard deviation measurements only

**newdata**		180 obs.	of 81 variables		new tidy dataset created by *run_analysis.R* script




## Inner functions

### mainfunction()
Takes no arguments as all important parameters are hard written inside the functions.
The function to run to get the required result. Collects all the functions into one in the right order.



### readtest() and readtrain()
Parameters: Take no arguments as all parameters are fixed inside the function. 
Returns: data frames, one for training data and one for test data respectively.

Load raw data into R.
The raw measurements data from the "train" and "test" folders is loaded into **traindata** and **testdata** data frames respectively. Data on activity types and subjects is loaded as additional columns of existing data frames called *activity* and *subject*.

### mergedatasets()
Parameters: *traindata*, *testdata* -- data frames to be merged
Returns: one data frame

Test data and training data are merged into one dataset. As they have the same structure (all columns are the same), a new data frame is created with the same columns and all rows of both **traindata** and **testdata**. The new dataset is stored into **alldata** data frame.

### applyvarnames()
Parameters: *alldata* -- data frame of all data
Returns: the same data frame with descriptive column names

Applies the descriptive variable names to the dataset.
As there are too many different variables in the raw dataset and **alldata** I'm going to use the infromation from "features.txt" file that contains a list of all measurements in the raw training and test datasets.

Read data from "features.txt" into **features** data frame. 
Create a character vector **featnames** of feature names from **features**.
Add names for two manually added variables (*activity* and *subject*).
Apply **featnames** vector as variable names of **alldata** data frame.

### filterdataset()
Parameters: *alldata* -- data frame to select data from
Returns: new data frame with specific columns

Extracts a subset of measurements. 
Only mean and standard deviation measurements are required.

According to "features_info.txt" file, all mean and standard deviation measurements have "mean" or "std" in their names. As we used features names for variable names of **alldata** dataset, it's possible to filter only required measurements.
Create a vector **msfeatures** of all columns containing mean and standard deviation measurements, add *activity* and *subject* columns to the vector.
Sort the vector.
Filter **alldata** according to **msfeatures**, store result into  **filterdata** data frame.


### createnewdataset()
Parameters: *filterdata* -- a data frame to create new dataset from
Returns: the independent clean data set

The required clean data set contains mean value of each measurement for each subject and each activity.

Creates the new data set
Sort **filterdata** dataset by subject and activity.
Create new dataset by first splitting **filterdata** by subject and activity and then applying *colMeans* function, store into **newdata** data frame.
Reverse columns and rows of **newdata** for convenience.

### applydescr()
Parameters: *newdata* -- data frame to apply descriptive row names and activity descriptors
Returns: the same data frame with row names and activity descriptors instead of labels.

Sets descriptive names for variables.
The **newdata** dataset is ready but we need to do a few more things about it to make it look better.

Gets activity names instead of labels.
First read "activity_labels.txt" into **activities** data frame.
Then left join **newdata** with **activities** to get appropriate activity name for each activity label for each row (unique pair subject-activity).

Gets descriptive row names.
Create row names from *activity* and *subject* columns.
Don't remove *activity* and *subject* columns as we need them separate for the dataset to be clean.

### writefile()
Parameters: *newdata* -- data frame to write into file
Returns: the output of this function is a "cleandata.txt" file in the working directory.

Saves dataset into file.
The **newdata** dataset is saved into "cleandata.txt" file in the working directory.

