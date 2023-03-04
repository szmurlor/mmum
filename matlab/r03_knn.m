close all

% Generacja danych 
xucz=randn(120,2);
ducz=[1*ones(40,1) ; 
      2*ones(40,1); 
      3*ones(40,1)];
plot(xucz(1:40,1),xucz(1:40,2),'ro', ...
     xucz(41:80,1),xucz(41:80,2),'gx', ...
     xucz(81:120,1),xucz(81:120,2),'bd')
grid
legend('klasa 1', 'klasa 2', 'klasa 3')
title(['Rozkład danych uczących' ...
    ' z podziałem na klasy'])
xlabel('x_1'), ylabel('x_2')

xtest=randn(80,2);
dtest=[1*ones(30,1); 
       2*ones(30,1); 
       3*ones(20,1)];

% Model klasyfikatora KNN
knn =  fitcknn(xucz,ducz,'NumNeighbors', ...
    5,'Standardize',1)

% testowanie na zbiorze testowym
y=predict(knn,xtest)

% Macierz niezgodności klasowej
confusionmat(dtest,y)

figure

% Punkty środkowe (centroidy) grup
c = [ 1 1
      -1 1
      -1 -1 ]
o40 = ones(40,1)
xc = [ o40*c(1,1) o40*c(1,2)
       o40*c(2,1) o40*c(2,2)
       o40*c(3,1) o40*c(3,2) ]
xucz=[ randn(40,2);
       randn(40,2);
       randn(40,2) ] + xc
ducz=[1*ones(40,1); 
      2*ones(40,1); 
      3*ones(40,1)];

xtest=[ randn(40,2);
        randn(40,2);
        randn(40,2) ] + xc
dtest=[ 1*ones(40,1); 
        2*ones(40,1); 
        3*ones(40,1)];

plot(xucz(ducz==1,1),xucz(ducz==1,2),'ro', ...
     xucz(ducz==2,1),xucz(ducz==2,2),'gx', ...
     xucz(ducz==3,1),xucz(ducz==3,2),'bd', ...
     c(:,1), c(:,2), 's')
grid
legend('klasa 1', 'klasa 2', 'klasa 3')
title(['Rozkład danych uczących' ...
    ' z podziałem na klasy'])
xlabel('x_1'), ylabel('x_2')

% Model klasyfikatora KNN
knn =  fitcknn(xucz,ducz,'NumNeighbors', ...
    5,'Standardize',1)

% testowanie na zbiorze testowym
y=predict(knn,xtest)

% Macierz niezgodności klasowej
confusionmat(dtest,y)


p = []
for k = 1:30
    % Model klasyfikatora KNN
    knn =  fitcknn(xucz,ducz,'NumNeighbors', ...
        k,'Standardize',1);
    
    % testowanie na zbiorze testowym
    y=predict(knn,xtest);
    
    p = [p sum(y == dtest) / length(dtest)]
end
figure
plot(p*100)
title('Dokładność [%]')
xlabel('k')
grid