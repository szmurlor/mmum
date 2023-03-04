close all
x=0:0.01:2*pi; x=x';
d=sin(x);
svm=fitrsvm(x,d,'Standardize',true, ...
    'KernelFunction','RBF','KernelScale','auto')
y=predict(svm,x)
plot(x,d,'r',x,y,'--b'), grid
legend({'sin(x)','aproksymacja SVM'})
xlabel('x')
ylabel('sin(x), aproksymacja SVM')