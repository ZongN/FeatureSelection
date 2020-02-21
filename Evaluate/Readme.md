# Evaluate

This is main function folder. When first time using this program, you can run the *Lib.R* first. It will help you install the using packages easier (Under Rstudio IDE). Also need to pay attention to the path of call function.

In the main function, it will import the row data as the new.evn(*envdt*).

#### *Row data format must be the first row is the label followed by the feature.*

| Label | Feature_1 | Feature_2 | Feature_3  | ... |
|------:|----------:|----------:|-----------:| ---:|
| X     | 0.01      | 225       | 0.5        | ... |
| X     | 0.05      | 125       | 0.2        | ... |
| Y     | 0.03      | 147       | 0.1        | ... |
| X     | 0.01      | 169       | 0.6        | ... |

Then add the feature selection method into *envfs*, and add the classifier method into *envcf*.

Next , set the *OuterRound*、*P*、*K* and the cores number *cl*

#### *The parameter description can refer to the previous Readme.*

#### *It's recommended not to use all core executions.*

After all, run the *Evaluate.R*.

By using the env method, I think that the parameters can be controlled more simply. But the disadvantage is that it's more inconvenient to call.
