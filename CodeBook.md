# Codebook
This is a codebook for course project of Getting and Cleaning Data course. It explains how the script in "run_analysis.R" file works and transforms the data.

## Input
**run_analysis.R**	script into working directory
**UCI HAR Dataset**	directory into working directory

## Output
**cleandata.txt**	file in the working directory

### Description of cleandata.txt
Cols. 1-79:				numeric		various mean and standard deviation measurements
Col. 80	(*subject*):	numeric		subject labels
Col. 81	(*activity*):	character	activity names

Separator is ";"
No row names

Contains average of each measurement for each subject and each activity.


## Important inner variables
**testdata**	2947 obs.	of 563 variables	raw test dataset
**traindata**	7352 obs.	of 563 variables	raw training dataset
**features**	561 obs.	of 2 variables		list of all measured features
**activities**	6 obs. 		of 2 variables		activities names and class labels
**alldata**		10299 obs.	of 563 variables	test and training datasets merged together
**filterdata**	10299 obs.	of 81 variables		filtered data for mean and standard deviation measurements only
**newdata**		180 obs.	of 81 variables		new tidy dataset created by *run_analysis.R* script



## The raw data
The raw data was given in the form of .zip archive that contains a directory named "UCI HAR Dataset". I assume that this folder is in the working directory along with the "run_analysis.R" script.

The raw data inside the "UCI HAR Dataset" directory consists of two folders ("test" with the test data and "train" with the training data) and a few files of which "activity_labels.txt" and "features.txt" are of interest. Each of "test" and "train" directories contains files with various measurements ("X_test.txt" and "X_train.txt" respectively), activity type data ("y_test.txt" and "y_train.txt") and subjects data ("subjects_test.txt" and "subjects_train.txt").

## Loading raw data into R
The raw measurements data from the "train" and "test" folders is loaded into **traindata** and **testdata** data frames respectively. Data on activity types and subjects is loaded as additional columns of existing data frames called *activity* and *subject*.

## Transforming the raw data
### Merging the data into one dataset
Test data and training data are merged into one dataset. As they have the same structure (all columns are the same), a new data frame is created with the same columns and all rows of both **traindata** and **testdata**. The new dataset is stored into **alldata** data frame.

### Applying the descriptive variable names to the dataset
As there are too many different variables in the raw dataset and **alldata** I'm going to use the infromation from "features.txt" file that contains a list of all measurements in the raw training and test datasets.

Read data from "features.txt" into **features** data frame. 
Create a character vector **featnames** of feature names from **features**.
Add names for two manually added variables (*activity* and *subject*).
Apply **featnames** vector as variable names of **alldata** data frame.

### Extracting a subset of measurements 
Only mean and standard deviation measurements are required.

According to "features_info.txt" file, all mean and standard deviation measurements have "mean" or "std" in their names. As we used features names for variable names of **alldata** dataset, it's possible to filter only required measurements.
Create a vector **msfeatures** of all columns containing mean and standard deviation measurements, add *activity* and *subject* columns to the vector.
Sort the vector.
Filter **alldata** according to **msfeatures**, store result into  **filterdata** data frame.

## The independent clean data set
The required clean data set contains mean value of each measurement for each subject and each activity.

### Creating the new data set
Sort **filterdata** dataset by subject and activity.
Create new dataset by first splitting **filterdata** by subject and activity and then applying *colMeans* function, store into **newdata** data frame.
Reverse columns and rows of **newdata** for convenience.

### Setting descriptive names for variables
The **newdata** dataset is ready but we need to do a few more things about it to make it look better.

#### Getting activity names instead of labels.
First read "activity_labels.txt" into **activities** data frame.
Then left join **newdata** with **activities** to get appropriate activity name for each activity label for each row (unique pair subject-activity).

#### Getting descriptive row names
Create row names from *activity* and *subject* columns.
Don't remove *activity* and *subject* columns as we need them separate for the dataset to be clean.

### Save dataset into file
The **newdata** dataset is saved into "cleandata.txt" file in the working directory.
