# SupSim
SupSim <- function(X,Y){

  # Raw
  data_num <- dim(X)[1]
  # Col
  feat_num <- dim(X)[2]

  # Calculate the MutualInfo between each features and the class
  ## 1.Single core ##
  # MI <- matrix(0,nrow = 1,ncol = feat_num)
  # for(i in 1:feat_num){
  #   MI[i] <- MutualInfo(X[,i],Y,1)[1]
  # }

  ## 2.Parallel cores ##
  MI = foreach(m = 1:feat_num,.combine="c",.packages = 'SSKM')%dopar%{
    MutualInfo(X[,m],Y,1)[1]
  }
  MI <- t(MI)


  SS <- matrix(1,nrow = feat_num,ncol = feat_num)
  ij_total <- (feat_num)*(feat_num-1)/2
  ij_calcu <- 0

  # ProgressBar
  PB <<- winProgressBar(title = "Calculating...",label="0 %", min = 0,max = 100, width = 300)

  ## 1.Single core ##
  # for(i in 1:(feat_num-1)){
  #   for(j in (i+1):feat_num){
  #     Rij_C <- MutualInfo(cbind(X[i],X[j]),Y,1)[1]
  #     SS[i,j] <- Rij_C - MI[i]
  #     Rj_C <- MutualInfo(X[j],Y,1)[1]
  #     SS[j,i] <- Rij_C - Rj_C
  #
  #     SS[i,j] <- 1 / (1 + ((SS[i,j] + SS[j,i]) / 2) ^ 2)
  #     SS[j,i] <- SS[i,j]
  #     ij_calcu <- ij_calcu + 1
  #
  #     # Update ProgressBar
  #     # percent <- (ij_calcu/ij_total)*100
  #     # info <- paste0("[ ",round(percent),"%"," (",ij_calcu,"/",ij_total,") ]")
  #     # setWinProgressBar(PB, percent, label = info)
  #   }
  # }

  ## 2.Parallel cores ##
  for(i in 1:(feat_num-1)){
    S = foreach(j = (i+1):feat_num,.combine="c",.packages = 'SSKM') %dopar% {
      Rij_C <- MutualInfo(cbind(X[i],X[j]),Y,1)[1]
      S_ij <- Rij_C - MI[i]
      Rj_C <- MutualInfo(X[j],Y,1)[1]
      S_ji <- Rij_C - Rj_C

      S_ij <- 1 / (1 + ((S_ij + S_ji) / 2) ^ 2)
      S_ji <- S_ij
      c(S_ij)
    }
    S <- t(S)
    S <- c(rep(1,times = i),S)

    SS[i,] <- S

    ij_calcu <- ij_calcu + (feat_num-i)

    # # Update ProgressBar
    percent <- (ij_calcu/ij_total)*100
    info <- paste0("[ ",round(percent),"%"," (",ij_calcu,"/",ij_total,") ]")
    setWinProgressBar(PB, percent, label = info)
  }
  # Upper triangle replaces lower triangle
  SS[lower.tri(SS)] <- t(SS)[lower.tri(SS)]

  close(PB)

  return(list(MI = MI,SS = SS))
}

