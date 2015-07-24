# getdata-030 

## prepare
Copy the R program file run_analysis.R to the same directory as file *features* file 

##File read in process

- features
- activity_labels
- train/subject_train
- train/X_train
- train/y_train
- test/subject_train
- test/X_train
- test/y_train

## steps of processing
* read all file 
* assign variable name
* merge test observes with activity label and subject number
* merge train observes with activity label and subject number
* merge test and train data

* calculate mean by activity and subject and save to file
