---
title: "Getting and Cleaning Data Course Project"
output: html_notebook
---
 
## CodeBook

This dataset is a subset of data collected from the link below.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original dateset has data collect during a experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

For more deitails about the original date set please take a look in this link

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Steps to reach the gol of Tw tidy data sets

* First I download the original date set, Unziped on _*./data*_ directory

* Loaded activity_labels and features( variables names ) into R objects

* To Make Variables names more clean I took out characters "_*-()*_" 

* Loaded Train data files ( _*Xtrain.txt, y_train.txt and subject_train.txt*_) into R DataFrames - Those files are loacated in "_*./data/UCI HAR Dataset/train/*_"

* Loaded Test data files ( _*Xtest.txt, y_teste.txt and subject_test.txt*_) into R DataFrames - Those files are loacated in "_*./data/UCI HAR Dataset/test/*_"

* With the data loaded two data frames were created : **traindf** and **testDf**

* Merge **traindf** and *testdf* into *TrainTestdf* tha contains all records from **traindf** an **testdf**

* Joing activity names to **TrainTest** Data set in order to use descriptive activity names to name the activities in the data set

* Selects only the measures for **SDT** and **Means** and  Arrange by Subject & ActivityName genarating a **TidyDataSet**

* Write **TidyDataSet** to a CSV file to prepare to submit

### For each record it is provided:


- Subject who performed the activity that generat the data 

- Activity Label 

- A 88 -feature vector with time and frequency domain variables, for detais about feature names see TidydataVar.txt

* Create a second independentely dataset **SummarizedTidyDataSet** that summarizes **TidyDataSet** with the means of every Variable grouped by   Subject & Activity 

* Write **SummarizedTidyDataSet**to a CSV file to prepare to submit

* Zip datasets to prepare for submit

### The dataset includes the following files:

- TidyDataSet.csv - Data set with Train & Test merged for Mean and STD measures
- SummarizedTidyDataSet.cvs - the means of every Variable grouped by Subject & Activity 
- TidayDatavar.txt - All var names
- CodeBook.md  - CodeBook describing the data set, varnames and the transformations 
                required to clean original dataset and create this data set

### License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.



