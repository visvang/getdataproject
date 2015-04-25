


## 1. Read both datasets into R

     ## 1.1. Read training data
     ## Read training dataset into R
readtrain <- function() {
     traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
     ## Read data on activities and subjects for training dataset into specific columns 
     ## of the same data frame. Columns are named "activity" and "subject" respectively. 
     traindata$activity <- as.vector(read.table("./UCI HAR Dataset/train/y_train.txt")[[1]])
     traindata$subject <- as.vector(read.table("./UCI HAR Dataset/train/subject_train.txt")[[1]])
     
     ## return data set
     traindata
}     
     ## 1.2. Read test data
     ## Read test dataset into R
readtest <- function() {
     testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
     ## Read data on activities and subjects for training dataset into specific columns
     ## of the same data frame. Columns are named "activity" and "subject" respectively.
     testdata$activity <- as.vector(read.table("./UCI HAR Dataset/test/y_test.txt")[[1]])
     testdata$subject <- as.vector(read.table("./UCI HAR Dataset/test/subject_test.txt")[[1]])

     ## return dataset
     testdata
}

## 2. Merge training dataset and test dataset into one data frame.
mergedatasets <- function(traindata, testdata) {
     alldata <- merge(traindata, testdata, all = TRUE)
     ## return dataset
     alldata
}

## 3. Apply descriptive variable names to the dataset. 
## As there are too many variables let's use information from "features.txt" file.
applyvarnames <- function(alldata) {
     ## Read data from "features.txt" file into R
     features <- read.table("./UCI HAR Dataset/features.txt")
     ## Create character vector of feature names
     featnames <- as.vector(features$V2)
     ## As two columns were added to the dataset manually, add their names to the featnames vector
     featnames <- c(featnames, "activity", "subject")
     ## Apply feature names vector as variable names for dataset
     names(alldata) <- featnames
     
     ## return dataset
     alldata
}

## 4. Extract only the measurements on the mean and standard deviation for each measurement. 

filterdataset <- function (alldata) {
     ## create a vector of variable names
     featnames <- names(alldata)
     ## As the applied feature names are descriptive, use grep function to select only required measurements
     ## Don't forget to add two manually added columns (activity and subject)!
     msfeatures <- c(grep("-mean\\(", featnames), grep("-std\\(", featnames), 562, 563)
     ## Sort the vector
     msfeatures <- sort(msfeatures)
     ## Create new filtered dataset according to required measurements vector
     filterdata <- alldata[, msfeatures]
     
     ## return dataset
     filterdata
}

## 5. Create independent tidy dataset with the average of each variable 
## for each activity and each subject.

createnewdataset <- function(filterdata) {
     ## 5.1. Create new dataset
     ## Sort given dataset by activity and subject
     filterdata <- filterdata[ order(filterdata$subject, filterdata$activity), ]
     ## Create new dataset 
     newdata <- as.data.frame(lapply(split(filterdata, list(filterdata$subject, filterdata$activity), drop = TRUE), colMeans))
     ## Switch columns and rows in the new dataset
     newdata <- as.data.frame(t(newdata))
     
     ## return dataset
     newdata
}

## 5.2. Set descriptive row names

applydescr <- function(newdata) {
     ## 5.2.1. Get activity names instead of labels from the "activity_labels.txt" file
     ## Read data from the file into R
     activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
     ## Set activity names to lower case
     activities$V2 <- tolower(activities$V2)
     ## Left join two datasets to apply corresponding activity name to each dataset row
     newdata <- merge(newdata, activities, by.x = "activity", by.y = "V1", all.x = TRUE)
     ## Remove obsolete activity code column
     newdata$activity <- NULL
     ## Apply "activity" column name to the new activity column
     colnames(newdata)[68] <- "activity"
     
     ## 5.2.2. Make subject column values more descriptive
     ## Create function that makes "subject x" string from x numeric value
     textfun1 <- function(x) { paste("subject", x, sep = " ")}
     ## Create new column with the help of textfun1 
     newdata$rownames <- sapply(newdata$subject, textfun1)
     ## Create descriptive string value for every subject and activity pair
     newdata$rownames <- interaction(newdata$rownames, newdata$activity, drop = TRUE, sep = " ")
     ## Set descriptive labels as row names
     rownames(newdata) <- newdata$rownames
     ## Remove obsolete rownames column
     newdata$rownames <- NULL
     
     ## return dataset
     newdata
}

## 6. Write new data into file
writefile <- function(newdata) {
     write.table(newdata, file = "cleandata.txt", sep = ";", row.names = FALSE)
}


mainfunction <- function() {
     alldata <- applyvarnames(mergedatasets(readtrain(), readtest()))
     newdata <- applydescr(createnewdataset(filterdataset(alldata)))
     writefile(newdata)
}




