The data set used for this project can be found at -
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The complete description of the same can be availed of at -
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The code for this project is available at run_analysis.R (https://github.com/vsdaking/Getting-Cleaning-Data/blob/master/run_analysis.R).

Herein, I have performed 5 broad functions on the provided data set. They are as follows - 

1. Merged the training and the test sets (actual, subject, activity & label data) to create one data set (for each such pair).
2. Extracted only the measurements on the mean and standard deviation for each measurement. 
3. Used descriptive activity names to name the activities in the data set
4. Appropriately labeled the data set with descriptive variable names. 
5. From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.

The process followed is -
1. Combined each pair of training and test set together using the full_join function to form a 10299x561/10299x1 data frame. Have converted it 
  to tbl_df as & where required.
   
2. Read the features.txt file and stored the feature names as a factor. Therein, I have used the 'grep' function to find which indices have
  feature names containing "mean" or "std". Once finished with that,I sort the indice and select only these features from the provided Data Set.
  
3. I match the label data set and the activity data set to determine which activity has generated the particular label. Add this info to the newly 
  concise data set.I aptly provide the data description.
  
4. I also add the info pertaining to which subject generated the particular observation to the data set. Further, I aptly provide the data 
  description for the same.
  
5. Finally, I take the new cleansed data set and generate another data set which is grouped by the subject & activity. On applying the colMeans
  function to all the feature measurements in the data set, I finally achieve my tidy data set.

Hence, I have created a clean and tidy 80*181 data set. 79 = features which matched the conditions & 180 = 6 activities * 30 subjects
