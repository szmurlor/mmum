function r05_drzewa_regresja
clear all
X=0:0.1:10;
X=X';
d=sin(X);
T=fitrtree(X,d, 'splitcriterion', 'mse','MinParentSize',3);
view(T,'Mode','graph');
Xtest=0:0.126:10;
Xtest=Xtest';
y=predict(T,Xtest)
figure,subplot(2,1,1),plot(X,d,'r',Xtest,y,'b'), grid, xlabel('x'), ylabel('f(x)')
T=fitrtree(X,d, 'splitcriterion', 'mse','MinParentSize',10);
view(T);
Xtest=0:0.126:10;
Xtest=Xtest';
y=predict(T,Xtest)
subplot(2,1,2),plot(X,d,'r',Xtest,y,'b'), grid, xlabel('x'), ylabel('f(x)')
view(T,'Mode','graph')

end