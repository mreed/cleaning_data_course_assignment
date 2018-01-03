# cleaning_data_course_assignment
This is the assignment for week 4 of the data cleaning course from John Hopkins on Coursera

The file run_analysis.R cantains the code for the project.

1. First it is assumed you are using a working directory you downloaded with the zip. It has the following structure

/training
  subject_training.txt
  X_training.txt
  y_training.txt
/test
  subject_test.txt
  X_test.txt
  y_test.txt
activity_labels.txt
features.txt

run_analysis.R used the dplyr library to use its group_by and summarize_all functions

1. The code loads in the data from all the files listed above.
2. It renames the variables using the features.txt
3. It then combines the y_, subject and x_ data sets
4. It than merges using rbind the test and training data
5. It removes punctuation from variable names and makes them move user friendly
6. It changes the activity column from using numbers to the labels of the activities with activity_labels.txt
7. It finally groups by subject and activity and takes the mean for the new grouping of each variable.



