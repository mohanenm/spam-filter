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
sample <- email_data[sample(nrow(email_data), 1000),]
# Adding caret package so the SVM can actually be created
require(caret)
require(kernlab)
require(doMC)