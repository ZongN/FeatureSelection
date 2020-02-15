p_mkde2 <- function(x,Xa,h){
  d <- nrow(Xa)
  N <- length(Xa)/d
  
  S <- diag(var(t(Xa)))
  
  Z <- matrix(data = x ,nrow = d,ncol = N)
  Z <- Z -Xa
  
  #tmp1 <- sum(exp(-diag(t(Z) %*% diag(1/S) %*% Z)/(2*h^2)))  
  #When length(S) < 1,diag(1/S) will create the wrong matrix
  if(length(S) == 1){
    tmp1 <- sum(exp(-diag(t(Z) %*% (1/S) %*% Z)/(2*h^2)))
  }else{
    tmp1 <- sum(exp(-diag(t(Z) %*% diag(1/S) %*% Z)/(2*h^2)))
  }
  pxy <- (1/(N*h^d*sqrt((2*pi)^d*prod(S))))*tmp1
  
  return(pxy)
}