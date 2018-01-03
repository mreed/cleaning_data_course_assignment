#load the dplyr library to use group_by and summerize_all
library(dplyr)
#pull all the data into r
x_training <- read.table('./train/X_train.txt')
x_test <- read.table('./test/X_test.txt')
y_training <- read.table('./train/Y_train.txt')
y_test <- read.table('./test/Y_test.txt')
subject_test <- read.table('./test/subject_test.txt')
subject_train <- read.table('./train/subject_train.txt')
features <- read.table('./features.txt')
activity_labels <- read.table('./activity_labels.txt')

#give the training set and test set the name from column 2 of the feature data set
colnames(x_training) <- features$V2
colnames(x_test) <- features$V2

#add subject to x_training and x_test
x_training$subject_id <- subject_train$V1
x_test$subject_id <-subject_test$V1

#add activity data to the respective x data set
x_training$activity <- y_training$V1
x_test$activity <- y_test$V1

#merge x_training and x_test
ds <- rbind(x_training, x_test)

#get the indices of columns that have mean(), std(), subject or activity
std_mean_ind <- grep("mean()|std()|^subject|^activity",names(ds))

#extract only the columns with above indices
data <- ds[,std_mean_ind]

#rename the activity id to the activity label
data$activity <- activity_labels$V2[data$activity]

#remove '(' ')' '-' or '_' from variable names
names(data) <- gsub('\\(|\\)|\\-|_','',names(data))

#change the beginning of the variable if starts with f change it to freq
names(data) <- sub('^f','freq',names(data))
#change the beginning of the variable to time if it starts with a t
names(data) <- sub('^t','time',names(data))

#create another dataset the is grouped by subject than activity, then calculate the mean for each group
data2 <- data %>% group_by(subjectid,activity) %>% summarize_all(mean)
