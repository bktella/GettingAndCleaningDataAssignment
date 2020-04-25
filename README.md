README.md
================

## Getting and Cleaning Data Course Assignment

Repository for the final assignment for the Getting and Cleaning Data Coursera course (<https://www.coursera.org/learn/data-cleaning>)

This is the course project for the Getting and Cleaning Data Coursera
course. The R script, `run_analysis.R`, does the following:

  - Download the dataset if it does not already exist in the working directory
  - Load the activity and features info
  - Load both the training and test datasets, filtering only those columns which a mean or standard deviation (signified by having either "mean()" or "std()" in the feature names
  - Load the activity and subject data for each dataset, renaming column names as activity and subject and convert the activity into factors with descriptive labels
  - Merge the activity and subject columns with the dataset
  - Merge the two datasets
  - Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
  - The end result is shown in the file `tidy.txt`.
