# getdataproject
Course Project for Coursera Getting and Cleaning Data course

## Files
* "run_analysis.R": contains script to convert the raw Samsung data set into tidy dataset.
* "CodeBook.md": explains in details how the data is transformed to get the tidy data set.
* "cleandata.txt": the resulting dataset of "run_analysis.R" script, contains a dataset of mean values of various mean and standard deviation measurements for each subject and each activity.


## Important info
* The "run_analysis.R" script and the Samsung data should be both in the working directory for "run_analysis.R" script to work properly.
* If the "run_analysis.R" script is run, it creates "cleandata.txt" file in the working directory.


## Notes
* Features are bounded within [-1, 1]
* Subject labels 1-30
* Activities: 6 different, explicitly named (walking, walking_upstairs, walking_downstairs, sitting, standing, laying).

