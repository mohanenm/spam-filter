# SPAM -- FILTER

if(FALSE){
  "READ DATA INTO VARIABLE, 'EMAIL DATA', NO HEADER, SEPERATION IS DONE AT SEMI COLON"
}
email_data <- read.csv("data.csv", header=FALSE,sep=";")

# read in attribute names so that support vector model can actually work
names_data <-read.csv("names.csv", header=FALSE, sep=";")

# print(email_data)
# print(name_data)
# Actually applying names to our read in data
names(email_data) <- sapply((1:nrow(names_data)), function(i) toString(names_data[i,1]))
# Changing y column to factor values, allows SVM classfication output
email_data$y <- as.factor(email_data$y)
#splliting data into a sample, to put lower load on SVM
thousand_sample <- email_data[sample(nrow(email_data), 1000),]
# Adding packages so the SVM can actually be created
# allows actual SVM to be used
require(caret)
#kernal based machine learning lab; adds methods for classification; deeper than caret package
require(kernlab)
require(doMC)
# splliting test and train data; which rows will be for training and which rows will be for testing; 
# keeps zero and one in both training and testing to guarantee homogenous training
train <- creatDataPartition(thousand_sample$y, p=.85, list = FALSE, times = 1)