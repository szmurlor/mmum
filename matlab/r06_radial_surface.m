close all
[x1,x2] = meshgrid(-10:2.6:10,-10:2.6:10);
z = sin(sqrt(x1.^2+x2.^2)) ./ ... 
    sqrt(x1.^2+x2.^2);
surf(x1,x2,z)

x1_ = reshape(x1,1,[]);
x2_ = reshape(x2,1,[]);
d = sin(sqrt(x1_.^2+x2_.^2)) ./ ...
    sqrt(x1_.^2+x2_.^2);

x = [x1_;x2_]

spread = .5;

%  max number of neurons
K =1000;             

% Minimalny akceptowalny błąd (SSE)
goal = 0.00000001;   

% liczba neuronów dodawana jednoczesnie
Ki = 5;		    
net = newrb(x,d,goal,spread,K,Ki);

% generacja wyników sieci na danych wejściowych
y = net(x);  	    

z_ = reshape(y, size(x1))
figure
surf(x1,x2,z_)
sum(sum(abs(z - z_)))
