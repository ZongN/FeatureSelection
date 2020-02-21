CallOMICFS <- function(dt,lb,index,fs){
  
  dirpath <- "..\\FS\\OMICFS\\"
  
  dt_train <- dt[index,]
  lb_train <- data.frame(lb = as.numeric(lb[index]))
  
  # OMICFS Parameter
  psfeanum <- fs$K
  expfeanum <- fs$E
  parameter <- data.frame(psfeanum,expfeanum)
  
  # Prepare the data for OMICFS in matlab
  write.dat(dt_train , paste0(dirpath,"dt_train.dat"))
  write.dat(lb_train , paste0(dirpath,"lb_train.dat"))
  write.dat(parameter , paste0(dirpath,"parameter.dat"))
  
  # Call OMICFS from matlab,and write to the csv file
  run_matlab_script(paste0(dirpath,"MatlabCall.m"),verbose = TRUE,desktop = FALSE,splash = FALSE, display = FALSE, wait = TRUE,
                            single_thread = FALSE)
  # Read the result by csv
  K_index <- unlist(read.table(paste0(dirpath,"OMICFS_RF.csv"),sep = ","))
  
  return(K_index)
}