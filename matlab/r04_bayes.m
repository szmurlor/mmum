X = [1	0	1
     0	0	1
     1	1	2
     0	1	2
     1	1	1
     1	1	1
     1	0 	1
     0	1	2
     0	0	2];
x = X(:,1:2);
d = X(:,3);
model=fitcnb(x,d)

xt = [1 1
      0 1
      0 0];
klasa=model.predict(xt)


% Klasyfikator Bayesa
%
% Generacja danych uczących 2 klas
x1=randn(20,2);
x2=repmat([1.5 2.1],20,1)+randn(20,2);
xucz=[x1;x2];
subplot(1,2,1);
plot(x1(:,1),x1(:,2),'o', ...
     x2(:,1),x2(:,2),'rx')
title('dane uczące')
grid();legend('Klasa 1','Klasa 2')
klasa=[repmat('klasa1',20,1)
       repmat('klasa2',20,1)];

% Budowa modelu klasyfikatora Bayes'a
model = fitcnb(xucz,klasa);
% Tryb odtwarzania danych uczących
Klas_ucz = model.predict(xucz);

% Macierz niezgodności
CMatrix_ucz = confusionmat(klasa,Klas_ucz)
 
% Generacja danych testujących 2 klas
x1=randn(20,2);
x2=repmat([1.4 2.2],20,1)+randn(20,2);
xtest=[x1;x2];
klasa=[repmat('klasa1',20,1)
       repmat('klasa2',20,1)];
subplot(1,2,2);
plot(x1(:,1),x1(:,2),'o', ...
     x2(:,1),x2(:,2),'rx')
grid(); legend('Klasa 1','Klasa 2')
title('dane testujace')

% Testowanie na danych testujących
Klas_test = model.predict(xtest);
% Macierz niezgodności
CMatrix_test = confusionmat(klasa,Klas_test) 
[label, posterior] = predict(model,xtest)

[label, posterior]
