# *A supervised similarity-based k-medoids (SSKM)*
## Author : CHEN-SEN OUYANG | [*IEEE Xplore*](https://ieeexplore.ieee.org/abstract/document/7009669 "IEEE Xplore")
### Abstract:
A supervised similarity-based k-medoids (SSKM) clustering algorithm is proposed for feature selection in classification problems. The set of original features is iteratively partitioned into k clusters, each of which is composed of similar features and represented by a feature yielding the maximum total of similarities with the other features in the duster. A supervised similarity measure is introduced to evaluate the similarity between two features for incorporating information of class labels of training patterns during clustering and representative selection. Experimental results show that our proposed method can select a more effective set of features for classification problems.
* Published in: 2014 International Conference on Machine Learning and Cybernetics
* Date of Conference: 13-16 July 2014
* Date Added to IEEE Xplore: 15 January 2015
* INSPEC Accession Number: 14851587
* DOI: 10.1109/ICMLC.2014.7009669
---
I wrote the Ouyang's algorithm in R language, and added some improvements.
And it will use multi-core through R package [*foreach*](https://www.rdocumentation.org/packages/foreach/versions/1.4.7/topics/foreach "foreach")

The main function is as follows:
```js
    SSKM <- function(I,SM,MI,K,SF_id = NULL,StopOption,stop_thr)
```
And I usually write an extra call function to call this *SSKM*, as follows:
```js
    CallSSKM <- function(dt,lb,index,fs)
```
The similar matrix table of the features can be calculated from this function *SupSim*, as follows:
```js
    SupSim <- function(X,Y)
```
### Parameter:
```js
    CallSSKM <- function(dt,lb,index,fs)
```
Similar matrix of the features
*  dt:Row data table,X axis are the features, Y axis is the sample.
*  lb:Label of the data.
*  index:Cross-validation sample.
*  fs:Calculation of parameters.
*   ⓐ K:Final number of features.
*   ⓑ stop_thr:Threshold to stop.
```js
    SupSim <- function(X,Y)
```
*  X:Row data table.
*  Y:Label of the data.
```js
    SSKM <- function(I,SM,MI,K,SF_id = NULL,stop_thr)
```
*  I:Row data table.
*  SM:Similar matrix of the features.
*  MI:Mutual information of each features and label.
*  K:Final number of features.
*  SF_id:The medoids of the first round, if NULL then it will pick in random.
*  stop_thr:Threshold to stop.
---
### Process:
*CallSSKM* ▶ *SupSim* ▶*SSKM* ▶ *Select results*
