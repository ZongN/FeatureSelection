CallRaF <- function(dt,lb,index,RF,fitcontrol){
  
  dt_lb <- cbind(dt[,RF],lb)
  dt_lb_train <- dt_lb[index,]
  dt_lb_test <- dt_lb[-index,]
  
  # Model training and turning
  rfFit <- train(lb ~ ., data = dt_lb_train, 
                 method = "rf",
                 trControl = fitcontrol,
                 ntree = 2,
                 preProc = c("center", "scale"),
                 tuneLength = 8,
                 metric = "ROC")
  
  # Predict & Confusion Matrix
  PE <- PredictEvaluate(dt_train = dt_lb_train,
                        dt_test  = dt_lb_test,
                        CFFit    = rfFit)
  
  # Bind the bestTune parameter and predict evaluate
  Re <- list(method = fitcontrol$method,
             BestTune = rfFit$bestTune,
             Test = PE$Test,
             Train = PE$Train)
  
  return(Re)
}