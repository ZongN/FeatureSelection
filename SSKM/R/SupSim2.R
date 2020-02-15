# SupSim2
SupSim2 <- function(X,Y,Mul,lanbda,K){

  # Raw
  data_num <- dim(X)[1]
  # Col
  feat_num <- dim(X)[2]

  MI = foreach(m = 1:feat_num,.combine="c",.packages = 'SSKM')%dopar%{
    MutualInfo(X[,m],Y,1)[1]
  }
  MI <- t(MI)

  # Candidate features by MI
  if(round(feat_num/data_num) > Mul){
    Candidatelist <- order(MI,decreasing=T)

    rankpick_num <- round((lanbda*data_num)/log(data_num))

    # Check the pick number
    if(!(K < rankpick_num && rankpick_num <= feat_num)){ # rankpick_num out of range
      if(K < rankpick_num){ # 下界符合，表上界不符合。因此等於上界。
        rankpick_num <- feat_num
      }else{
        rankpick_num <- K
      }
    }

    Candidatelist <- Candidatelist[(1:rankpick_num)]

    # Update features
    X <- X[,Candidatelist]
    feat_num <- dim(X)[2]

    MI = foreach(m = 1:feat_num,.combine="c",.packages = 'SSKM')%dopar%{
      MutualInfo(X[,m],Y,1)[1]
    }
    MI <- t(MI)
  }else{
    Candidatelist <- NULL
  }

  # Compute similarity matrix
  SS <- matrix(1,nrow = feat_num,ncol = feat_num)
  ij_total <- (feat_num)*(feat_num-1)/2
  ij_calcu <- 0

  # ProgressBar
  PB <<- winProgressBar(title = "Calculating...",label="0 %", min = 0,max = 100, width = 300)

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

  return(list(CL = Candidatelist,MI = MI,SS = SS))
}

