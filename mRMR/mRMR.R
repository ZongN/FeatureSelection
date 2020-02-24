#install.packages("mRMRe")
library(mRMRe)


## For test 
data(cgps)

data.annot <- data.frame(cgps.annot)
data.cgps <- data.frame(cgps.ic50, cgps.ge)


df <- data.frame("surv1" = Surv(runif(100),sample(0:1, 100, replace = TRUE)),
                 "cont1" = runif(100),
                 "disc1" = factor(sample(1:5, 100, replace = TRUE),ordered = TRUE),
                 "surv2" = Surv(runif(100),sample(0:1, 100, replace = TRUE)),
                 "cont2" = runif(100),
                 "cont3" = runif(100),
                 "surv3" = Surv(runif(100),sample(0:1, 100, replace = TRUE)),
                 "disc2" = factor(sample(1:5, 100, replace = TRUE),ordered = TRUE))

dd <- mRMR.data(data = df)
print(mim(subsetData(dd, 1:4, 1:4)))

dd <- mRMR.data(data = data.cgps)
mRMR.classic(data = dd, target_indices = c(1),feature_count = 10)


## For test 
library(mlbench)
data(Sonar)
dt <- Sonar[,1:60]
lb <- Sonar[,61]
lb <- (as.numeric(lb))


dd <- mRMR.data(data = data.frame(Class=lb,dt))
Test <- mRMR.classic("mRMRe.Filter",data = dd, target_indices = 1,feature_count = 5,method="exhaustive")

min(Test)
#############################
set.thread.count(2)
data(cgps)
feature_data <- mRMR.data(data =  data.frame(cgps.ge))

# Calculate the pairwise mutual information matrix
mim(feature_data)
filter <- mRMR.classic("mRMRe.Filter", data = feature_data, target_indices = 3:5,
                       feature_count = 2)

# Obtain the sparse (lazy-evaluated) mutual information matrix.
mim(filter)



data(cgps)

data <- data.frame(target=cgps_ic50, cgps_ge)
mRMR.classic(data, 1, 30)
