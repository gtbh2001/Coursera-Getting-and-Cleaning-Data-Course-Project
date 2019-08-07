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

      # Avoid to download file if it is already was download saving time during debug time
      
      if( !file.exists(ZipFileName) )
          download.file(Url, ZipFileName)
      
      # Avoid to unzip files if it is already unziped
      
      if( !dir.exists(DataFilePath) )
           unzip( ZipFileName, exdir = "./data/" )


# Loads activity_labels and features
  
      activity_labels  <- read.delim2("./data/UCI HAR Dataset/activity_labels.txt", 
                          header = FALSE, sep="", stringsAsFactors = FALSE, 
                          col.names = c("ActivityId","ActivityName")) 
       
#        activity_labels <- tbl_df(activity_labels)  %>% select(ActivityLabel)  
        
             features  <- read.delim2("./data/UCI HAR Dataset/features.txt", 
                          header = FALSE, sep="", stringsAsFactors = FALSE, 
                          col.names = c("FeatureId","FeatureDescription"))
             
             features  <- tbl_df(features) %>% select(FeatureDescription) 

# Make Variables names more clean taking out characters "-()"
             
       features$FeatureDescription <- gsub("[-()]", "",features$FeatureDescription )

# Loads Train data

  xtraindf  <- read.delim2("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="",  
                          stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", 
                          col.names = features$FeatureDescription ) 
  
  ytraindf  <- read.delim2("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep="",  
                           stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", 
                           col.names = "ActivityId" ) 
  
  subjecttraindf <- read.delim2("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep="",  
                           stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", 
                           col.names = "SubjectNum" ) 
 
    traindf <- bind_cols(subjecttraindf, ytraindf, xtraindf) 

# Loads Test data
    
    xtestdf  <- read.delim2("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="",  
                             stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", 
                             col.names = features$FeatureDescription ) 
    
    ytestdf  <- read.delim2("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep="",  
                             stringsAsFactors = FALSE, dec = ".", numerals = "no.loss",
                             col.names = "ActivityId")
    
    subjecttestdf <- read.delim2("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep="",  
                                  stringsAsFactors = FALSE, dec = ".", numerals = "no.loss", 
                                 col.names = "SubjectNum") 
    
    testdf <- bind_cols(subjecttestdf, ytestdf, xtestdf)
               
# Merges Train and Test Data se to generate A new data set 

    TrainTest <- bind_rows(traindf, testdf)  

# Joing activity names to TrainTest Data set
    
    TrainTest <-  left_join(activity_labels, TrainTest)   
    
# Selects only the measures for SDT and Means and  Arrange by Subject & ActivityName
    
    TidyDataset <-  select(TrainTest, SubjectNum, ActivityName, contains("STD", ignore.case = TRUE), 
                           contains("mean", ignore.case = TRUE ) ) %>% 
                           arrange(SubjectNum, ActivityName) 

#  Write TidyDataSet to a CSV file
    
  write.csv(TidyDataset, "./TidyDataSet.csv")

# Create a summarize TidyDateSet with the means of every Variable
    
  SummarizedTidyDataSet <- TidyDataset %>% group_by(SubjectNum, ActivityName) %>%
                           summarize_all(mean )

# Write TidyDataSet to a CSV file
  
   write.csv(SummarizedTidyDataSet, "./SummarizedTidyDateSet.csv")        
    
# Zip files to be push on github
   
   zip(zipfile = "./TidyDataset.zip", files =  "./TidyDataSet.csv",
                  zip = Sys.getenv("R_ZIPCMD", "zip"), flags = "-r9X")
   
   zip(zipfile = "./SummarizedTidyDateSet.zip", files = "./SummarizedTidyDateSet.csv",
                  zip = Sys.getenv("R_ZIPCMD", "zip"), flags = "-r9X")
       
   file.remove("./TidyDataSet.csv", "./SummarizedTidyDateSet.csv") 
     
     
     

      