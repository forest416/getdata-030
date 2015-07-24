
setwd("C:/Users/jin/Desktop/clean.data/FUCI/UCI HAR Dataset")

test_y=read.csv('test/y_test.txt',header=F)
train_y=read.csv('train/y_train.txt',header=F)

names(test_y) = "ActivityNo"
names(train_y) = "ActivityNo"

test_sub=read.csv('test/subject_test.txt',header=FALSE)
names(test_sub) = 'subject'
train_sub=read.csv('train/subject_train.txt',header=FALSE)
names(train_sub) = 'subject'


##
activity=read.delim('activity_labels.txt', F," ")
names(activity) = c("ActivityNo", "ActivityName")

feature=read.delim('features.txt',sep=' ',header=F)
featureCount=nrow(feature)

names(feature )= c("featureNo", "featureName")

test_x=read.fwf('test/X_test.txt',rep(16,featureCount))
names(test_x) = feature$featureName

train_x=read.fwf('train/X_train.txt',rep(16,featureCount))
names(train_x) = feature$featureName



train_activity=merge(activity, train_y, by.x="ActivityNo", by.y="ActivityNo")$ActivityName

train=cbind("TYPE"="TRAIN",Activity=train_activity, train_sub, train_x)



test_activity=merge(activity, test_y, by.x="ActivityNo", by.y="ActivityNo")$ActivityName

test=cbind("TYPE"="TEST", Activity=test_activity, test_sub, test_x)


result=rbind(test,train)

write.table(result, file="result.ALL.txt", row.name=FALSE, quote=TRUE)

result$TYPE <- NULL

step5=(aggregate(. ~   Activity +subject, data=result,FUN=mean))
write.table(step5, file="step5.txt", row.name=FALSE, quote=TRUE)


