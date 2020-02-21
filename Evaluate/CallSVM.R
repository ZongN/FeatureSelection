CallSVM <- function(dt,lb,index,RF,fitcontrol){
  
  dt_lb <- cbind(dt[,RF],lb)
  dt_lb_train <- dt_lb[index,]
  dt_lb_test <- dt_lb[-index,]
  
  # Model training and turning
  svmFit <- train(lb ~ ., data = dt_lb_train, 
                  method = "svmRadial", 
                  trControl = fitcontrol, 
                  preProc = c("center", "scale"),
                  tuneLength = 4,
                  metric = "ROC")
  
  # Predict & Confusion Matrix
  PE <- PredictEvaluate(dt_train = dt_lb_train,
                        dt_test  = dt_lb_test,
                        CFFit    = svmFit)
  
  # Bind the bestTune parameter and predict evaluate
  Re <- list(method = fitcontrol$method,
             BestTune = svmFit$bestTune,
             Test = PE$Test,
             Train = PE$Train)
  
  return(Re)
}