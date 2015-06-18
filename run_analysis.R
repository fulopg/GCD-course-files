#This script reads UCI HAR data and prepares a tidy data set with the average of mean and standard 
#deviation values for each subject and activity. In order for the script to work properly, the UCI HAR
#dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#first shall be downloaded and unzipped (keeping the original folder structure), and saved in the R 
#working directory.


#reading in the data files
training_values <- read.table("UCI Har Dataset/train/X_train.txt",header=F) 
training_labels <- read.table("UCI Har Dataset/train/y_train.txt",header=F,col.names="activity") 
training_subjects <- read.table("UCI Har Dataset/train/subject_train.txt",header=F,col.names="subject_id") 
testing_values <- read.table("UCI Har Dataset/test/X_test.txt",header=F) 
testing_labels <- read.table("UCI Har Dataset/test/y_test.txt",header=F,col.names="activity") 
testing_subjects <- read.table("UCI Har Dataset/test/subject_test.txt",header=F,col.names="subject_id") 
features <- read.table("UCI Har Dataset/features.txt", header=F) 
 
#separating the description column
features_descr <- as.character(features[,2]) 

#replacing activity IDs with descriptions
testing_labels$activity[testing_labels$activity==1] <- "walking"
testing_labels$activity[testing_labels$activity==2] <- "walking_upstairs"
testing_labels$activity[testing_labels$activity==3] <- "walking downstairs"
testing_labels$activity[testing_labels$activity==4] <- "sitting"
testing_labels$activity[testing_labels$activity==5] <- "standing"
testing_labels$activity[testing_labels$activity==6] <- "laying"
training_labels$activity[training_labels$activity==1] <- "walking"
training_labels$activity[training_labels$activity==2] <- "walking_upstairs"
training_labels$activity[training_labels$activity==3] <- "walking downstairs"
training_labels$activity[training_labels$activity==4] <- "sitting"
training_labels$activity[training_labels$activity==5] <- "standing"
training_labels$activity[training_labels$activity==6] <- "laying"


#adding feature descriptions as headers to training and testing data 
colnames(training_values) <- features_descr 
colnames(testing_values) <- features_descr 
 
#combining subjects, activities and training / testing values 
training_all <- cbind(training_subjects,training_labels,training_values) 
testing_all <- cbind(testing_subjects,testing_labels,testing_values) 
 
#combining the testing and training sets 
combined_data <- rbind(training_all,testing_all) 
 
#removing duplicate column names
combined_data <- combined_data[!duplicated(names(combined_data))] 
 
#loading dplyr 
library(dplyr) 
 
#keeping only columns related to mean or standard deviation 
combined_data <- select(combined_data,subject_id,activity,contains("mean()"),contains("std()")) 
 
#Grouping data, calculating mean 
grouped_data <- combined_data %>% group_by(subject_id,activity) 
grouped_data <- grouped_data %>% summarise_each(funs(mean)) 

#creating output file
write.table(grouped_data,file="GCD_project.txt",row.name=F)

