CallLR <- function(dt,lb,index,RF,fitcontrol){
  
  dt_lb <- cbind(dt[,RF],lb = (lb))
  dt_lb_train <- dt_lb[index,]
  dt_lb_test <- dt_lb[-index,]
  
  lrFit <- train(lb ~ ., data = dt_lb_train, 
                  method = "multinom", 
                  trControl = fitcontrol,
                  tuneLength = 8)
  
  # Predict & Confusion Matrix
  PE <- PredictEvaluate(dt_train = dt_lb_train,
                        dt_test  = dt_lb_test,
                        CFFit    = lrFit)
  
  # Bind the bestTune parameter and predict evaluate
  Re <- list(method = fitcontrol$method,
             BestTune = lrFit$bestTune,
             Test = PE$Test,
             Train = PE$Train)
  
  return(Re)
}


