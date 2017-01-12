Among the list of files provided from the zip, there are 7 files that need to be used for making the tidy data: 

  - a: test/subject_test.txt(subject as number for 2947 observation) 
  
  - b: test/X_test.txt(type of measurement for 2946 observatino x 561 measurement[features]) 
  
  - c: test/y_test.txt(type of activity as number for 2947 observation) 
  
  - d: train/subject_train.txt(subject as number for 7352 observation) 
  
  - e: train/X_train.txt(type of measurement for 7352 observatino x 561 measurement[features]) 
  
  - f: train/y_train.txt(type of activity as number for 7352 observation)   
  
  - g: features.txt(describing the name of mesurement)

In order to arrive into a tidy date, the following steps should be taken:  

1) read relevant(a-f) file to creat R objects  
2) merge by cbind for a+d;b+e; c+f  
3) cbind to create a table from 3 data set from 2)  
4) select only observation that has either "mean" or "stdv2 (grep("mean\(\)|std\(\)", dataFeaturesNames$V2))  
5) rename obersavatino as follows:
-prefix t  is replaced by  time
- Acc is replaced by Accelerometer
- Gyro is replaced by Gyroscope
- prefix f is replaced by frequency
- Mag is replaced by Magnitude- BodyBody is replaced by Body

6) create aggregate of mean of data extracted by 4)  7) create tidydata.txg
