# *A filter feature selection method based on the Maximal Information Coefficient and Gram-Schmidt Orthogonalization for biomedical data mining*
## Author : Hongqiang Lyu, Mingxi Wan, Jiuqiang Han et al | [*NCBI*](https://www.ncbi.nlm.nih.gov/pubmed/28850898")
### Abstract:
A filter feature selection technique has been widely used to mine biomedical data. Recently, in the classical filter method minimal-Redundancy-Maximal-Relevance (mRMR), a risk has been revealed that a specific part of the redundancy, called irrelevant redundancy, may be involved in the minimal-redundancy component of this method. Thus, a few attempts to eliminate the irrelevant redundancy by attaching additional procedures to mRMR, such as Kernel Canonical Correlation Analysis based mRMR (KCCAmRMR), have been made. In the present study, a novel filter feature selection method based on the Maximal Information Coefficient (MIC) and Gram-Schmidt Orthogonalization (GSO), named Orthogonal MIC Feature Selection (OMICFS), was proposed to solve this problem. Different from other improved approaches under the max-relevance and min-redundancy criterion, in the proposed method, the MIC is used to quantify the degree of relevance between feature variables and target variable, the GSO is devoted to calculating the orthogonalized variable of a candidate feature with respect to previously selected features, and the max-relevance and min-redundancy can be indirectly optimized by maximizing the MIC relevance between the GSO orthogonalized variable and target. This orthogonalization strategy allows OMICFS to exclude the irrelevant redundancy without any additional procedures. To verify the performance, OMICFS was compared with other filter feature selection methods in terms of both classification accuracy and computational efficiency by conducting classification experiments on two types of biomedical datasets. The results showed that OMICFS outperforms the other methods in most cases. In addition, differences between these methods were analyzed, and the application of OMICFS in the mining of high-dimensional biomedical data was discussed. The Matlab code for the proposed method is available at https://github.com/lhqxinghun/bioinformatics/tree/master/OMICFS/.
* PMID: 28850898
* DOI: 10.1016/j.compbiomed.2017.08.021
---
There is the source code on Github, but it's programmed in *Matlab*. So I call the OMICFS through R package [*matlabr*](https://www.rdocumentation.org/packages/matlabr/versions/1.5.2).

In *matlabr*, we need to pass the parameters by using read-write files.

And there is a *CallOMICFS* in evaluate folder.[Here](https://github.com/ZongN/FeatureSelection/blob/master/Evaluate/CallOMICFS.R)

In *CallOMICFS*, you can see that most of them are reading and writing file for pass parameters. As follows:
```js
     write.dat(dt_train , paste0(dirpath,"dt_train.dat"))
     write.dat(lb_train , paste0(dirpath,"lb_train.dat"))
     write.dat(parameter , paste0(dirpath,"parameter.dat"))
```

The parameters will be written to this folder from *CallOMICFS*, and then we can run the function to run matlab code, as follows:
```js
     run_matlab_script(paste0(dirpath,"MatlabCall.m"),verbose = TRUE,desktop = FALSE,splash = FALSE, display = FALSE, wait = TRUE,
                            single_thread = FALSE)
```
The more detail parameters can see in [Here](https://www.rdocumentation.org/packages/matlabr/versions/1.5.2).

When OMICFS is finished, it will write the selected features in *OMICFS_RF.csv*, then we can import the result by reading this csv file.
---
### Process:
*CallOMICFS.R* ▶ *.dat* ▶ *MatlabCall.m* ▶ *OMICFS.m* ▶ *OMICFS_RF.csv* ▶ *CallOMICFS.R* ▶ *Select results*
