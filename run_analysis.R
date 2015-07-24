
setwd("C:/Users/jin/Desktop/clean.data/FUCI/UCI HAR Dataset")

## read all input files

test_y=read.csv('test/y_test.txt',header=F)
train_y=read.csv('train/y_train.txt',header=F)

names(test_y) = "ActivityNo"
names(train_y) = "ActivityNo"

## read subject file, each row in this file link to X_ file
test_sub=read.csv('test/subject_test.txt',header=FALSE)
names(test_sub) = 'subject'
train_sub=read.csv('train/subject_train.txt',header=FALSE)
names(train_sub) = 'subject'


## read activity file
activity=read.delim('activity_labels.txt', F," ")
names(activity) = c("ActivityNo", "ActivityName")

feature=read.delim('features.txt',sep=' ',header=F)
# featureCount is referenced when read X_ file
featureCount=nrow(feature)

names(feature )= c("featureNo", "featureName")

## read observation file
test_x=read.fwf('test/X_test.txt',rep(16,featureCount))
names(test_x) = feature$featureName

train_x=read.fwf('train/X_train.txt',rep(16,featureCount))
names(train_x) = feature$featureName


## replace  activityNo to ActivityName
train_activity=merge(activity, train_y, by.x="ActivityNo", by.y="ActivityNo")$ActivityName

## train data in one
train=cbind(Activity=train_activity, train_sub, train_x)


## replace activityNo to ActivityName
test_activity=merge(activity, test_y, by.x="ActivityNo", by.y="ActivityNo")$ActivityName
# test data in one
test=cbind(Activity=test_activity, test_sub, test_x)

## merge test and train data
result=rbind(test,train)
# a copy of all
write.table(result, file="result.ALL.txt", row.name=FALSE, quote=TRUE)

# mean by activity and subject
step5=(aggregate(. ~   Activity +subject, data=result,FUN=mean))
write.table(step5, file="step5.txt", row.name=FALSE, quote=TRUE)


