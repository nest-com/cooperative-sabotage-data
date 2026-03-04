%this folder will run when all workspaces from amplitudes 0.1, 0.1 and
%0.075 are loaded, that means we have variables of interest max2sec100 (sec
%sent in 100 with 0.2 amplitude) and similarly max1sec200 (secret sent in
%sec 200 with 0.1 amplitude)  with this loaded, we will execute
%findResultMatrix.m 
%That script has 3 threads, we find ROC for 0.2, for 0.1 and for 0.075 and
%save those variables independently. Thus, we will have auxiliary variable
%maxSecMix1 (or 2 or 7), ResultMatrix1 (or 2 or 7) and even K (the range of threshold varies, k1, k2 or k7)
%Note that GroundTruth is the same for all amplitudes and it goes from a
%range of when secret is sent -160 up to 160.

%RUN finResultMatrix.m (and get GroundTruth and 3 ResultMatrix (1,2 and 7)

%NOW RUN SCRIPTS TO FIND TPR and FPR, this scripts will have auxiliary
%variable for each amplitude.  Notice that the output is tpr1, tpr2 and
%tpr7, while for FPR the output is fpr1, fpr2 and fpr7, in these files the value
% of t depends on the cardinality of k1( or 2 or 7), also the value of j is
% the size of (max#Sec###), i is the ammount of secret trials (sent at
% different times)



%NOW Plot the results, each amplitude will be a curve on the figure.