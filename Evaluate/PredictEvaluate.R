PredictEvaluate <- function(dt_train,dt_test,CFFit){
  
  # Predict
  PredictRe_train <- predict(CFFit,dt_train)
  PredictRe_test  <- predict(CFFit,dt_test)
  
  # Confusion Matrix
  CM_train <- confusionMatrix(PredictRe_train,dt_train$lb,mode = "prec_recall")
  CM_test  <- confusionMatrix(PredictRe_test,dt_test$lb,mode = "prec_recall")
  
  # AUC predict
  AUCPredictRe_train <- predict(CFFit,dt_train,type="prob")
  AUCPredictRe_test  <- predict(CFFit,dt_test ,type="prob")
  
  train_set <- data.frame(obs = dt_train$lb,AUCPredictRe_train,pred = PredictRe_train)
  test_set  <- data.frame(obs = dt_test$lb ,AUCPredictRe_test ,pred = PredictRe_test)
  
  # For multi-class
  if(length(unique(dt_train$lb)) > 2){
    train_AUC <- multiClassSummary(train_set,lev = levels(train_set$obs))["AUC"]
    test_AUC  <- multiClassSummary(test_set ,lev = levels(test_set$obs))["AUC"]
    
    TrainEva <- data.frame(ACC = CM_train$overall["Accuracy"],Precision = mean(CM_train$byClass[,"Precision"]),Recall = mean(CM_train$byClass[,"Recall"]),AUC = train_AUC)
    TestEva  <- data.frame(ACC = CM_test$overall["Accuracy"] ,Precision = mean(CM_test$byClass[,"Precision"]) ,Recall = mean(CM_test$byClass[,"Recall"]) ,AUC = test_AUC)
  }else{ # For two class
    train_AUC <- multiClassSummary(train_set,lev = levels(train_set$obs))["AUC"]
    test_AUC  <- multiClassSummary(test_set ,lev = levels(test_set$obs))["AUC"]
    
    TrainEva <- data.frame(ACC = CM_train$overall["Accuracy"],Precision = CM_train$byClass["Precision"],Recall = CM_train$byClass["Recall"],AUC = train_AUC)
    TestEva  <- data.frame(ACC = CM_test$overall["Accuracy"] ,Precision = CM_test$byClass["Precision"] ,Recall = CM_test$byClass["Recall"] ,AUC = test_AUC)
  }
    
  Record <- list(Test = TestEva,Train = TrainEva)
  
  return(Record)
}