library(caret)     # Classifier
library(pROC)      # Multi class AUC
library(minerva)
library(SSKM)      # SSKM / Similarity matrix
library(apcluster) # APC
library(mRMRe)     # mRMR
#library(multiplex) # OMICFS
library(matlabr)   # Call from matlab
library(xgboost)
library(plyr)
library(foreach)
library(doParallel)
library(parallel)
library(e1071)
library(MLmetrics)

source("../FS/mRMRT/mRMRT.R",local = T)

source("CallFASSKM.R",local = T)
source("CallmRMR.R",local = T)
source("CallOMICFS.R",local = T)

source("CallSVM.R",local = T)
source("CallRandomForest.R",local = T)
source("CallNaiveBayes.R",local = T)
source("CallLDA.R",local = T)
source("Callxgb.R",local = T)
source("CallLogitRegression.R",local = T)

source("PredictEvaluate.R",local = T)
source("ExportTableCreat.R",local = T)

library(mailR)
source("SendMail.R",local = T)

source("KNSetting.R",local = T)

source("Evaluate.R",local = T)
