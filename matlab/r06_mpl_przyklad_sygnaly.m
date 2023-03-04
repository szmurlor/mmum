close all;

% generacja danych uczących
x = 0:0.05:12;
s = sin(x)
t = mod( x, pi)*2/pi-1
r = sign(sin(x))
c = abs(sinc(x))
hold on
plot(x,s,'.r', 'LineWidth',2)
plot(x,t,'--c', 'LineWidth',2)
plot(x,r,'b', 'LineWidth',2)
plot(x,c,'.-g', 'LineWidth',2)
title('Przebieg wartości zadanych funkcji')
xlabel('Zmienna wejściowa x')
ylabel('Wartości zadane')
grid;
ylim([-1.5, 1.5])
hold off

d = [s;t;r;c]

n = 200
%net = feedforwardnet([n],'trainlm');
net = feedforwardnet([n],'trainbfg');

% aby spowodować przeuczenie ustalamy rygorystyczne
% kryteria błędów
net.trainParam.goal = 1e-10;  
net.trainParam.min_grad = 1e-10; 

% aby proces uczenia nie kończył się przedwcześnie
% z uwagi na spełnienie kryterium błędu na zbiorze 
% walidującym wyłączamy ten test
net.divideParam.trainRatio = 1;
net.divideParam.valRatio   = 0;
net.divideParam.testRatio  = 0;
       
% uczenie sieci: 
%   x – dane wejściowe, 
%   d – wartości zadane (destination)
net = train(net,x,d)


% prezentacja struktury sieci
view(net);		     

% testowanie sieci na danych testowych x
x = 0:0.053:12;

y = net(x);	
figure
hold on
plot(x,y(1,:),'.r', 'LineWidth',2)
plot(x,y(2,:),'--c', 'LineWidth',2)
plot(x,y(3,:),'b', 'LineWidth',2)
plot(x,y(4,:),'.-g', 'LineWidth',2)
title(sprintf('Wynik aproksymacji przy %d neuronach', n))
xlabel('Zmienna wejściowa x')
ylabel('Wartości aproksymowane')
grid;
hold off

