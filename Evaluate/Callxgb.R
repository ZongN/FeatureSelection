Callxgb <- function(dt,lb,index,RF,fitcontrol){
  
  dt_lb <- cbind(dt[,RF],lb)
  dt_lb_train <- dt_lb[index,]
  dt_lb_test <- dt_lb[-index,]
  
  # Model training and turning
  xgbFit <- train(lb ~ ., data = dt_lb_train,
                  method = "xgbTree",  # method = "xgbDART"
                  trControl = fitcontrol,
                  preProc = c("center", "scale"),
                  tuneLength = 2,
                  metric = "ROC")
  
  # Predict & Confusion Matrix
  PE <- PredictEvaluate(dt_train = dt_lb_train,
                        dt_test  = dt_lb_test,
                        CFFit    = xgbFit)
  
  # Bind the bestTune parameter and predict evaluate
  Re <- list(method = fitcontrol$method,
             BestTune = xgbFit$bestTune,
             Test = PE$Test,
             Train = PE$Train)
  
  return(Re)
}