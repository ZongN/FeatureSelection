Fearray = load('dt_train.dat/dt_train.dat');
Classflag = load('lb_train.dat/lb_train.dat');
Parameter = load('parameter.dat/parameter.dat');
Psfeanum = Parameter(1)
Expfeanum = Parameter(2)

RF = OMICFS(Fearray,Classflag,Psfeanum,Expfeanum)

csvwrite('OMICFS_RF.csv',RF);