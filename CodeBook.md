GettingandCleaningDataCourseProject
===================================

Codebook.MD

Variables
===================================
 Test data
 
  1. test_X - Data Load from test_X file
  
  2. test_y - Data Load from test_y file
  
  3. subject_test - Data Load from subject_test file
  
  4. test_data - data that combined from test_X, test_y, and subject_test
  
Train data  
  
  1. train_X - Data Load from train_X file
  
  2. train_y - Data Load from train_y file
  
  3. subject_train - Data Load from subject_train file
  
  4. train_data - data that combined from train_X, train_y, and subject_train

Other variables
 
  1. dataset - output variable
  
  2. feature_name - Data Load from feature file
  
  3. activity_label - Data Load from activity_label file
  
Programming Logic
  
  1. Load test Dataset into each variable and then combine subjectid, activityid, and data together
  test_X <- read.table("test/X_test.txt")
  test_y <- read.table("test/y_test.txt")
  subject_test <- read.table("test/subject_test.txt")
  test_data <- cbind(subject_test,test_y,test_X)
  
  2. Load train Dataset into each variable and then combine subjectid, activityid, and data together
  train_X <- read.table("train/X_train.txt")
  train_y <- read.table("train/y_train.txt")
  subject_train <- read.table("train/subject_train.txt")
  train_data <- cbind(subject_train,train_y,train_X)
  
  3. combine test and train data together
  dataset <- rbind(test_data,train_data)
  
  4. Load Features Name and activity_label and set names
  feature_name <- read.table("features.txt")
  activity_label <- read.table("activity_labels.txt")
  names(activity_label) <- c("id","activity")
  
  5. Set name of each variables in dataset variables (name of each measurements)
  names(dataset) <- c("subject","activity_id",as.vector(feature_name$V2))
  
  6. Select only mean and std columns of each measurement by using grep command. Choose columns that have "mean(" or "std" in their name (plus subject and activity_id column) 
  dataset <- dataset[ , which(names(dataset) %in% grep("subject|activity_id|mean[(]|std",names(dataset),value=TRUE))]
  
  7. Merge dataset with variable name in activity_label variable. Use activity_id and id to join 2 datasets
  dataset <- merge(dataset,activity_label,by.x="activity_id",by.y="id",all=TRUE)
  

  8. Find mean of each measurements group by subject and activity(and id)
  require(reshape2)
  df_melt <- melt(dataset, id = c("subject", "activity","activity_id"))
  dataset <- dcast(df_melt, subject+activity + activity_id ~ variable, mean)
  
  9. Write output into "output.txt"
  write.table(dataset,file="output.txt",row.names=FALSE)
  
}
