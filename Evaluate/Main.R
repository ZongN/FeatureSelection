#################### M a i n #################### 

#### Library Import #### 
source("Lib.R",local = T)

#### Data Import #### 
envdt <- new.env()
assign("dtname","BreastCancerWisconsin",envir = envdt)
loadpath <- paste0("../../Dataset/UCI/",envdt[["dtname"]],".csv")
assign("dt",read.csv(loadpath,stringsAsFactors = F)[-1],envir = envdt)
assign("lb",unlist(read.csv(loadpath)[1]),envir = envdt)

#### FS ####
envfs <- new.env()
assign("fs",list(data.frame(method = "FASSKM"  ,StopOption = "Iteration",stop_thr = 100,Mul = 3,lanbda = 5,stringsAsFactors = F),
                 data.frame(method = "mRMR"  ,stringsAsFactors = F),
                 data.frame(method = "OMICFS",stringsAsFactors = F)),envir = envfs)

#### Classifier #### 
envcf <- new.env()
assign("FitC1",trainControl(method = "repeatedcv",number = 10,repeats = 1,
                            classProbs = TRUE,summaryFunction = twoClassSummary),
       envir = envcf)
assign("FitC2",trainControl(method = "repeatedcv",number = 10,repeats = 1,
                            classProbs = TRUE),
       envir = envcf)
assign("FitC3",trainControl(method = "repeatedcv",number = 10,repeats = 1,
                            classProbs = TRUE,summaryFunction = multiClassSummary),
       envir = envcf)
assign("cf",list(data.frame(name = "SVM",stringsAsFactors = F),
                 data.frame(name = "LDA",stringsAsFactors = F),
                 data.frame(name = "xgBoost",stringsAsFactors = F),
                 data.frame(name = "NaiveBayes",stringsAsFactors = F),
                 data.frame(name = "RandomForest",stringsAsFactors = F),
                 data.frame(name = "LogitRegression",stringsAsFactors = F)),
       envir = envcf)

OuterRound <- 10
P <- .9
K <- c(2,4)

# Parallel computing
# Set the number of cores
cl <- makeCluster((detectCores()-2))
registerDoParallel(cl)

Evaluate(OuterRound,P,K,envdt,envfs,envcf)

# Close the cores
stopCluster(cl)
