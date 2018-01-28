#############################################################################################################################################################################################
#                                                                     OVERVIEW                                                                                                                                                                                   #
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.                                                                                    #
#Using data collected from the accelerometers from the Samsung Galaxy S smartphone, work with the data and make a clean data set and output the tidy data to a file named "tidyDataSet.txt".#
#############################################################################################################################################################################################

# Clean up workspace
rm(list=ls())

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd('C:/Users/MSI/Documents/data/UCI HAR Dataset/')

# Reading the data from files
features <- read.table('./features.txt',header=FALSE)
activityLabels <- read.table('./activity_labels.txt',header=FALSE)
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)
xTrain <- read.table('./train/X_train.txt',header=FALSE)
yTrain <- read.table('./train/y_train.txt',header=FALSE)

# Read in the test data
subjectTest <- read.table('./test/subject_test.txt',header=FALSE)
xTest <- read.table('./test/x_test.txt',header=FALSE)
yTest <- read.table('./test/y_test.txt',header=FALSE)

###################################################################################################
# 1. Merge the training and the test sets to create one data set.                                 #
###################################################################################################

colnames(activityLabels) <- c('activityId','activityType')
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

trainingData <- cbind(yTrain,subjectTrain,xTrain)
testData <- cbind(yTest,subjectTest,xTest)
finalData <- rbind(trainingData,testData)


#################################################################################################################################################################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each measurement.                                                                                                                                     #
#################################################################################################################################################################################################################################
colNames  <- colnames(finalData)
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
finalData <- finalData[logicalVector==TRUE]

################################################################################################################################################################################################################################
# 3. Use descriptive activity names to name the activities in the data set                                                                                                                                                     #
################################################################################################################################################################################################################################
finalData <- merge(finalData,activityType,by='activityId',all.x=TRUE)
colNames  = colnames(finalData)

################################################################################################################################################################################################################################
# 4. Appropriately label the data set with descriptive variable names.                                                                                                                                                         #
################################################################################################################################################################################################################################
for (i in 1:length(colNames)) 
{
  colNames[i] <- gsub("\\()","",colNames[i])
  colNames[i] <- gsub("-std$","StdDev",colNames[i])
  colNames[i] <- gsub("-mean","Mean",colNames[i])
  colNames[i] <- gsub("^(t)","time",colNames[i])
  colNames[i] <- gsub("^(f)","freq",colNames[i])
  colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(finalData) <-colNames

#######################################################################################################################################################################################################################
# 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.                                                                                               #
#######################################################################################################################################################################################################################

finalDataNoActivityType  <- finalData[,names(finalData) != 'activityType'];
Result <- aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);
Result <- merge(Result,activityLabels,by='activityId',all.x=TRUE);
write.table(Result, './tidyDataSet.txt',row.names=TRUE,sep='\t')

