MutualInfo <- function(X,Y,class_inclu){
  
  
  X <- as.matrix(t(X))
  Y <- as.matrix(t(Y))
  
  if(class_inclu == 0){
    
    nx <- length(X)
    dxy <- 2
    hxy <- (4/(dxy+2))^(1/(dxy+4))*nx^(-1/(dxy+4))
    dx <- 1
    hx <- (4/(dx+2))^(1/(dx+4))*nx^(-1/(dx+4))
    
    Xall <- rbind(X,Y)
    sum1=0;
    
    for(is in 1:nx){
      pxy <- p_mkde2(x = Xall[,is],Xa = Xall,h = hxy)
      px <- p_mkde2(x = Xall[1,is],Xa= X,h = hx)
      py <- p_mkde2(x = Xall[2,is],Xa =Y,h = hx)
      sum1 <- sum1+pxy*log(pxy/(px*py))
    }
    Ixy <- sum1
    
    lambda <- sqrt(1-exp(-2*Ixy))
    
  }else{
    
    num_dim <- nrow(X)
    num_data <- length(X)/num_dim
    h <- (4/(num_dim+2))^(1/(num_dim+4))*num_data^(-1/(num_dim+4))
    
    pc_x <- data.frame()
    
    ClassType <- t(unique(as.character(Y)))
    num_C <- length(ClassType)
    pc <- matrix(data = 0,num_C,1)
    
    for(j in 1:num_C){
      X_c_id <- which(Y == ClassType[j])
      pc[j,1] <- length(X_c_id)
      
      if(num_dim != 1){
        X_c <- X[,X_c_id]
      }else{
        X_c <- t(X[,X_c_id])
      }
      
      for(i in 1:num_data){
        pc_x[j,i] <- p_mkde2(X[,i],as.matrix(X_c),h)*length(X_c)
      }
    }
    
    pc <- pc/num_data
    HC <- -sum(pc*log(pc))
    
    pc_x_sum <- rbind(t(sapply(pc_x[,],sum)),t(sapply(pc_x[,],sum)))
    pc_x <- pc_x/pc_x_sum
    
    #Find 0 in pc_x
    pc_x <- pc_x*log(pc_x)
    pc_x[sapply(pc_x, is.nan)] <- 0
    
    HC_A <- -sum(t(sapply(pc_x[,],sum)))/num_data
    
    Ixy <- HC-HC_A
    lambda <- sqrt(1-exp(-2*Ixy))
  }
  
  return(c(Ixy,lambda))
}
