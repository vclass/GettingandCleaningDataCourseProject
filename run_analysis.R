run_analysis <- function(){
  
  #Load test Dataset
  test_X <- read.table("test/X_test.txt")
  test_y <- read.table("test/y_test.txt")
  subject_test <- read.table("test/subject_test.txt")
  test_data <- cbind(subject_test,test_y,test_X)
  
  #Load train Dataset
  train_X <- read.table("train/X_train.txt")
  train_y <- read.table("train/y_train.txt")
  subject_train <- read.table("train/subject_train.txt")
  train_data <- cbind(subject_train,train_y,train_X)
  
  #combine test and train data
  dataset <- rbind(test_data,train_data)
  
  #Load Features Name
  feature_name <- read.table("features.txt")
  
  #Load Activity Label
  activity_label <- read.table("activity_labels.txt")
  names(activity_label) <- c("id","activity")
  
  #Set Column Name
  names(dataset) <- c("subject","activity_id",as.vector(feature_name$V2))
  
  #Extract only mean and std
  dataset <- dataset[ , which(names(dataset) %in% grep("subject|activity_id|mean[(]|std",names(dataset),value=TRUE))]
  
  #Merge to label Activity
  dataset <- merge(dataset,activity_label,by.x="activity_id",by.y="id",all=TRUE)
  
  #Find Average by subject and activity
  require(reshape2)
  df_melt <- melt(dataset, id = c("subject", "activity","activity_id"))
  dataset <- dcast(df_melt, subject+activity + activity_id ~ variable, mean)
  
  return(dataset)
  
}