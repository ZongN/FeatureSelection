Evaluate <- function(OuterRound,P,K,envdt,envfs,envcf){

  dt <- envdt$dt
  lb <- envdt$lb
  dtname <- envdt$dtname
  
  cf <- envcf$cf
  FitC1 <- envcf$FitC1
  FitC2 <- envcf$FitC2
  FitC3 <- envcf$FitC3
  
  for(KN in K){
    
    # Update the K parameter in each FS list
    fs <- KNSetting(envfs$fs,KN)
    
    # Precreate the export table in the K environment
    ExportTableCreat(fs,cf,KN)
    
    # Data partition to train and test
    index_train <- createDataPartition(lb, p = P, list = F,times = OuterRound)
    
    # Write the index_train into the K environment
    assign("index_train", index_train,inherits = F,envir = eval(parse(text = paste0("env_K.",KN))))
    
    OR <- 0
    Export <- NULL
    
    while(OR != OuterRound){
      OR <- OR+1
      cat("Outer Round :",OR,"\n")
      
      for(i in 1:length(fs)){
        cat("=================",fs[[i]]$method,"=================","\n")
        
        ### Representative Features ###
        RF <- switch(fs[[i]]$method,
                     FASSKM = CallFASSKM(dt,lb,index_train[,OR],fs[[i]]),
                     FASSAPC = CallFASSAPC(dt,lb,index_train[,OR],fs[[i]]),
                     FAMICKM = CallFAMICKM(dt,lb,index_train[,OR],fs[[i]]),
                     FAMIDKM = CallFAMIDKM(dt,lb,index_train[,OR],fs[[i]]),
                     FAMICAPC = CallFAMICAPC(dt,lb,index_train[,OR],fs[[i]]),
                     mRMR   = CallmRMR(dt,lb,index_train[,OR],fs[[i]]),
                     mRMRT  = CallmRMRT(dt,lb,index_train[,OR],fs[[i]]),
                     OMICFS = CallOMICFS(dt,lb,index_train[,OR],fs[[i]]),
                     MICNMS = CallMICNMS(dt,lb,index_train[,OR],fs[[i]]),
                     MICNMSKM = CallMICNMSKM(dt,lb,index_train[,OR],fs[[i]]))
        
        fs[[i]]$RF <- paste(RF,collapse=" ")
        
        # Multi lab process
        if(length(unique(lb)) > 2){
          FitC1 <- FitC3
          FitC2 <- FitC3
        }
        
        ### Classifier ###
        for(g in 1:length(cf)){
          
          CFit <- switch(cf[[g]]$name,
                         SVM             = CallSVM(dt,lb,index_train[,OR],RF,FitC1),
                         LDA             = CallLDA(dt,lb,index_train[,OR],RF,FitC1),
                         RandomForest    = CallRaF(dt,lb,index_train[,OR],RF,FitC1),
                         NaiveBayes      = CallNB (dt,lb,index_train[,OR],RF,FitC1),
                         LogitRegression = CallLR (dt,lb,index_train[,OR],RF,FitC2),
                         xgBoost         = Callxgb(dt,lb,index_train[,OR],RF,FitC1))
          
          # Record the classifier performance (ACC,Precision,Recall)
          OneCFRE <- cbind(FS=fs[[i]],
                           CF = cbind(cf[[g]],method = CFit$method,CFit$BestTune),
                           Test = CFit$Test,
                           Train = CFit$Train)
          # The corresponding export table(CEXT)
          CEXT <- rbind(eval(parse(text = paste0("EX.",fs[[i]]$method,"_",cf[[g]]$name)),envir = eval(parse(text = paste0("env_K.",KN))))
                        ,OneCFRE)
          # Overwrite
          assign(paste0("EX.",fs[[i]]$method,"_",cf[[g]]$name), data.frame(CEXT),envir = eval(parse(text = paste0("env_K.",KN))))
        }
        
        cat("===============",fs[[i]]$method,"Done","===============","\n","\n")
      }
      
    }
    
    # Save RData  
    save.image(paste0(dtname,"_",OuterRound,"_",P,"_K=",KN,".RData"))
    
    #Send completion email
    SendMail(M_Title= paste0(dtname,"_",OuterRound,"_",P,"_K=",KN),"Done.")
  }
  
}