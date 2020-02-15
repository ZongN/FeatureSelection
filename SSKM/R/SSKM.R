SSKM <- function(I,SM,MI,K,SF_id = NULL,stop_thr){

  data_num <- nrow(I)
  feat_num <- length(I)

  # Initialize objective
  Obj <- NULL
  # Randomly select K features as SF_id
  if(is.null(SF_id)){
    SF_id <- sample(length(I),K,replace = F)
  }

  # Unrepresentative feature
  CF_id <- c(1:feat_num)[-SF_id]
  CF_num <- length(CF_id)

  conv <- 0
  iter <- 0

  while(conv==0){
    iter <- iter+1

    CC <- matrix(0,nrow = 1,ncol = feat_num)
    CC_MI <- matrix(0,nrow = 1,ncol = feat_num)

    maxMI <- t(apply(SM[SF_id,CF_id], 2, max)) # Get the max MI feature
    maxMI_arg <- t(apply(SM[SF_id,CF_id], 2, which.max)) # Get the max MI feature address
    CC[CF_id] <- t(sapply(maxMI_arg,FUN = Change <-function(x) {return(SF_id[x])})) # Change the feature address to feature number
    CC[SF_id] <- SF_id
    CC_MI[CF_id] <- maxMI

    Obj[iter] <- 0

    # Update the SF* in each K cluster
    ## WAY(1)
    for(j in 1:K){
      SFC_id <- which(CC == SF_id[j])
      max_SFC_MI <- max(MI[SFC_id])
      max_SFC_id <- which.max(MI[SFC_id])
      SF_id[j] <- SFC_id[max_SFC_id]
      CC[SFC_id] <- SFC_id[max_SFC_id]
      Obj[iter] <- Obj[iter] + max_SFC_MI
    }

    ## WAY(2)
    # for(j in 1:K){
    #   SFC_id <- which(CC == SF_id[j])
    #
    #   if(length(SFC_id) > 1){
    #     max_SFC_MI <- max(apply(SM[SFC_id,SFC_id], 1, sum))
    #     max_SFC_id <- which.max(apply(SM[SFC_id,SFC_id], 1, sum))
    #     SF_id[j] <- SFC_id[max_SFC_id]
    #     CC[SFC_id] <- SFC_id[max_SFC_id]
    #     Obj[iter] <- Obj[iter] + max_SFC_MI
    #   }else{
    #     max_SFC_MI <- SM[SFC_id,SFC_id]
    #     Obj[iter] <- Obj[iter] + max_SFC_MI
    #   }
    # }

    # Update unrepresentative feature
    CF_id <- c(1:feat_num)[-SF_id]

    if(iter > 1){
      if(abs(Obj[iter] - Obj[(iter-1)]) < stop_thr){
        conv <- 1
      }
    }
  }

  return(sort(SF_id))
}
