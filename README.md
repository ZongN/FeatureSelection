# Feature Selection
I wrote the simple code to merge several methods of the feature selection and the classifier methods of machine learning.
By useing this code, we can get the result after feature selection, and we can also know the results after classification.
Through the classification results, we can understand the quality of the features after selected.

*All the classifiers are call the R package [*caret*](http://topepo.github.io/caret/index.html "caret")*

*Some features selection methods are call the R package [*mRMRe*](https://www.rdocumentation.org/packages/mRMRe/versions/1.0.1/topics/mRMR.classic " mRMRe v1.0.1"), and matlab code [*OMICFS*](https://github.com/lhqxinghun/bioinformatics/tree/master/OMICFS "Git-OMICFS")*
---
## Feature Selection Methods:
* SSKM
* mRMR
* OMICFS

## Classifier Methods:
* SVM
* LDA
* xgBoost
* Randomforest
* Logistic regression
* NaiveBayes
---
### Input/Output
In this package, input is the row data include features(X axis), smaple(Y axis) and label, output are result of selected and classification.

### Proccess
*Main function* ▶ *Evaluate* ▶ *Callfunction(feature selsction)* ▶ *Callfunction(classifier)* ▶ *Result*

### Function Job
* Main:
  1. Read data
  2. Setting the parameters of feature selection(FS)
  3. Setting the parameters of classifier(CF)
  4. Setting round times(*OuterRound*)
  5. Setting the ratio of training to test data(*P*)
  6. Setting the feature number to pick(*K*)
  7. Setting the cores number for parallel computing
* Evaluate:
  1. Cut the input data into training and test data
  2. Call the FS and CF
  3. Record each round output
  In this stage, it will run *OuterRound* times in each *K*.
* Callfunction
  - Features selection:
    1. Passing FS parameters
  - Classifier:
    1. Passing CF parameters

![](https://img.shields.io/badge/R-3.5.3-blue) ![](https://img.shields.io/badge/caret-6.0--82-blue) ![](https://img.shields.io/badge/doParallel-1.0.14-blue) ![](https://img.shields.io/badge/e1071-1.7--2-blue) ![](https://img.shields.io/badge/foreach-1.4.4-blue) ![](https://img.shields.io/badge/mRMRe-2.0.9-blue)
