This repo contains a script that reads UCI HAR data and prepares a tidy data set with the average of mean and standard deviation values for each subject and activity. In order for the script to work properly, the UCI HAR dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip first shall be downloaded and unzipped (keeping the original folder structure), and saved in the R 
working directory. The script 
*reads in the required files (testing data, training data, labels and subjects (i.e. persons))
*replaces activity numbers with activity names, i.e. walking, walking upstairs, walking downstairs, sitting, standing, laying
*merges testing and training data sets
*extracts data related to the mean or standard deviation of each variable i.e. keeps those and only those variables that have mean() or std() in the name
*returns the mean value of each variable for each activity and each subject
*writes the above table in an output file GCD_project.txt
The repo also contains a code book that provides a short description on each variable of the output data set.
