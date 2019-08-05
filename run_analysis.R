# Loads all library to need to this analysis

library(tidyr)
library(lubridate)
library(dplyr)
library(stringr)

# Define some constans to be used in the Script


  DataFilePath <- "./data/UCI HAR Dataset"
     TrainPath <- "./data/UCI HAR Dataset/train/"
      TestPath <- "./data/UCI HAR Dataset/test/"

   ZipFileName <- "./data/dataforprojetc.zip"

           Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


# Download unzip and store on diretory Data under R Working Directory

      #If dta directory dont exist create it

      if ( !dir.exists("./data") )
           dir.create("./data")

      # Downloads data source file

      # Avoid to download file if it is already was download saving time during debugin time
      
      if( !file.exists(ZipFileName) )
          download.file(Url, ZipFileName)
      
      # Avoid to unzip files if it is already unziped
      
      if( !dir.exists(DataFilePath) )
           unzip( ZipFileName, exdir = "./data/" )


# Loads activity_labels and features


  
      activity_labels  <- read.delim2("./data/UCI HAR Dataset/activity_labels.txt", 
                          header = FALSE, sep="", stringsAsFactors = FALSE, 
                          col.names = c("ActivityId","ActivityLabel")) 
       
        activity_labels <- tbl_df(activity_labels)  %>% select(ActivityLabel)  
        
             features  <- read.delim2("./data/UCI HAR Dataset/features.txt", 
                          header = FALSE, sep="", stringsAsFactors = FALSE, 
                          col.names = c("FeatureId","FeatureDescription"))
             
             features  <- tbl_df(features) %>% select(FeatureDescription) 


# Loads Train data

  xtraindf  <- read.delim2("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="",  
                          stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", nrows = 10, 
                          col.names = features$FeatureDescription ) 
  
  ytraindf  <- read.delim2("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep="",  
                           stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", col.names = "ActivityId", nrows = 10 ) 
  
  subjecttraindf <- read.delim2("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep="",  
                           stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", col.names = "SubjectNum", nrows = 10 ) 
 
    traindf <- bind_cols(subjecttraindf, ytraindf, xtraindf) 

# Loads Test data
    
    xtestdf  <- read.delim2("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="",  
                             stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", 
                             col.names = features$FeatureDescription ) 
    
    ytestdf  <- read.delim2("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep="",  
                             stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", col.names = "ActivityId")
    
    subjecttestdf <- read.delim2("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep="",  
                                  stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", col.names = "SubjectNum") 
    
    testdf <- bind_cols(subjecttestdf, ytestdf, xtestdf)
               
# Merges Train and Test Data se to generate A new data set

    TrainTest <- bind_rows(traindf, testdf) 
    
# selects only the measures for SDT and means
    
     TrainTest <- select(TrainTest, SubjectNum, ActivityId, contains("STD", ignore.case = TRUE), 
                         contains("mean", ignore.case = TRUE ) )
     
     
#
#     1 tBodyAcc-mean()-X
#     2 tBodyAcc-mean()-Y
#     3 tBodyAcc-mean()-Z
#     4 tBodyAcc-std()-X
#     5 tBodyAcc-std()-Y
#     6 tBodyAcc-std()-Z    
#
      