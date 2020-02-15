FirstPick <- function(dt,lb,MIMethod,PickNum){

  if(MIMethod == "MI"){

  }else if(MIMethod == "MIC"){

    # MIC(Xj,Y)
    MICY = foreach(m = 1:length(dt),.combine="c",.packages = 'minerva')%dopar%{
      mine(cbind(dt[,m],lb))$MIC[2]
    }
    MICY <- t(MICY)

    # (MIC of each feature and other features)/Sample
    S <- nrow(dt)
    MICF <- apply(mine(dt)$MIC,2,sum)/S

    # Q score value
    Q <- MICY-MICF

    #--------------------------------------------------------------------------------#

  }

  return(order(Q,decreasing = T)[PickNum])
}
