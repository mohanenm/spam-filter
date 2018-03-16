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
# finally (actual split)
d_train <- thousand_sample[ train, ]
d_test <- thousand_sample[-train, ]
# domc
# use all possible cores, very, very, very cool(increase SVM)
registerDoMC(cores=4) # macbook air, 4 cores
# finding the right tunning params for SVM is done by using the sigest function from kernlab
# SVM needs sigma and c parameters
if(FALSE){
  "FROM 'A PRACTICAL GUIDE TO SVM CLASSIFICATION' ==> https://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf
  'We recommend a grid-search on C and γ using cross-validation. Various pairs of (C,γ) values are tried and the 
  one with the best cross-validation accuracy is picked. We found that trying exponentially growing sequences of
C and γ is a practical method to identify good parameters (for example, C=2−5,2−3,…,215;γ=2−15,2−13,…,23)"
}
if(FALSE){ "FROM ARTICLE THAT IS TEACHING ME HOW TO BUILD THIS: EASIER EXPLANATION THEN THE PREVIOUS ONE"
  "If you want to know what these parameters are exactly you can take a look at:
  http://feature-space.com/en/post65.html and http://stats.stackexchange.com/questions/31066/what-is-the-influence-of-c-in-svms-with-linear-kernel
  The C parameter tells the SVM optimization how much you want to avoid misclassifying each training example. 
  For large values of C, the optimization will choose a smaller-margin hyperplane if that hyperplane does a better
  job of getting all the training points classified correctly. Conversely, a very small value of C will cause the 
  optimizer to look for a larger-margin separating hyperplane, even if that hyperplane misclassifies more points. 
  For very tiny values of C, you should get misclassified examples, often even if your training data is linearly 
  separable."
}