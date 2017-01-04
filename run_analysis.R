### Seeint  the README.txt file for the detailed information 
### on the dataset. For the purposes of this project, 
### the files in the Inertial Signals folders are not used. 
### The files that will be used to load data are listed as follows:

## test/subject_test.txt
## test/X_test.txt
## test/y_test.txt
## train/subject_train.txt
## train/X_train.txt
## train/y_train.txt

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
### read relevant files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
## merge by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
## set names
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
## comgine data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
## extract only mean/stdev
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data2<-subset(Data,select=selectedNames)
## label activity/measurement
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activityLabels$V2))
#- prefix t  is replaced by  time
#- Acc is replaced by Accelerometer
#- Gyro is replaced by Gyroscope
#- prefix f is replaced by frequency
#- Mag is replaced by Magnitude
#- BodyBody is replaced by Body
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
## create a second tidy data set
library(plyr);
Data3<-aggregate(. ~subject + activity, Data2, mean)
Data3<-Data3[order(Data3$subject,Data3$activity),]
write.table(Data3, file = "tidydata.txt",row.name=FALSE)
