y=[0.1  0.2 0.3 0.35  0.45 0.5 0.6 0.7 0.8 0.9 1]
d=[0 0 1 0 1 1 1 1 0 1 1]
[tpr,fpr,th]=roc(d,y);
figure(1), plot(fpr,tpr)
grid, xlabel('FPR'),ylabel('TPR'), title ('ROC')
[X,Y,T,AUC] = perfcurve(d,y,1)
figure(2), plotroc(d,y), grid
