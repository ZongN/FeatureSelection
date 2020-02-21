CallSSKM <- function(dt,lb,index,fs){
  
  dt_train <- dt[index,]
  lb_train <- lb[index]
  
  # Parallel computing
  SS <- SupSim(dt_train,lb_train)
  SSKM_SM <- SS$SS
  SSKM_MI <- SS$MI
  # Parallel computing
  
  K <- fs$K
  stop_thr <- as.double(fs$stop_thr)
  
  K_index <- SSKM(dt_train,SSKM_SM,SSKM_MI,K,SF_id = NULL,stop_thr)
  
  return(K_index)
}