library(dplyr)

## 1. Merge the different Data Set to form unified DSs
# Merge the Actual Data sets generated
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

test1 <- tbl_df(X_test)
train1 <- tbl_df(X_train)

ds <- full_join(train1,test1)

rm("X_test","X_train","test1","train1")

## Merge the label data
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")


lbl_ds <- rbind(Y_test,Y_train)

ds_label <- full_join(tbl_df(Y_train),tbl_df(Y_test))

rm("Y_train","Y_test")

## Merge the Subject data
s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

test3 <- tbl_df(s_test)
train3 <- tbl_df(s_train)

ds_subject <- full_join(train3,test3)


rm("s_test","s_train","test3","train3")


# Read the Activity Data
act <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Replace the '_' from the input with ' ' 
act[, 2] = gsub("_", "", tolower(as.character(act[, 2])))



## 2. Extract measurements only on the mean & std features
# Read in the Feature Data Set
ftr <- read.table("./UCI HAR Dataset/features.txt")

# This is a factor variable. So, take only the feature names
ftr <- ftr[,2]

# search the feature names for mean & std and store the indice
ind1 <- grep("mean",ftr)
ind2 <- grep("std",ftr)

# merge the indice for both, mean & std, into a single value to be used herein
ind <- sort(c(ind1,ind2))

ds <- ds[,ind]



## 3. Use Descriptive Activity Names to name the extracted features in DS

lbl_ds[,1] = act[lbl_ds[,1], 2]
ds <- c(ds,lbl_ds)
ds <- tbl_df(as.data.frame(ds))



## 4. Label the data set with descriptive activity names
# Name the features in the DS
ds <- cbind(ds,ds_subject)
m <- c(as.character(ftr[ind]),"activity","subject")
names(ds) <- m
write.table(ds, "merged_clean_data.txt")


## 5. create a second, independent tidy data set with the average of each variable 
#      for each activity and each subject

sp<-split(ds,list(ds$subject,ds$activity))
td<-sapply(sp, function(x) colMeans(x[1:79]))
#rm(sp,ds)

write.csv(td, file="./tidyDat.csv")

rm(td)
