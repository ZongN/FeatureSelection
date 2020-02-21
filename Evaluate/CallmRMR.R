CallmRMR <- function(dt,lb,index,fs){
  
  #dt_train <- dt[index,]
  #dt_train <- as.matrix(as.data.frame(dt[index,]))
  dt_train <- apply(dt[index,],2,as.double)
  
  lb_train <- as.numeric(lb[index])
  
  dt_mRMR <- mRMR.data(data = data.frame(dt_train,lb_train))
  
  K <- fs$K
  lbIndex <- length(dt_mRMR@feature_names)
  
  K_index <- mRMR.classic("mRMRe.Filter",
                          data = dt_mRMR, 
                          target_indices = lbIndex,
                          feature_count = K,
                          method="exhaustive")@filters
  
  K_index <- unlist(K_index)
  
  return(K_index)
}