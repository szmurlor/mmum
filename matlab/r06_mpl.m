close all;

% generacja danych uczących
x1=1+randn(20,5);
x2=-2+randn(20,5);
x3=3+randn(20,5);
x=[x1;x2;x3]';
d=[  ones(20,1);
   2*ones(20,1);
   3*ones(20,1)]';

% struktura MLP zawiera dwie warstwy ukryte 
% o odpowiednio 5 i 2 neuronach, wymiar 
% wejścia i wyjścia 
% automatycznie dobrany z danych uczących 
% [x,t], algorytm uczący LM (można 
% zmienić na inny)
net = feedforwardnet([5,2],'trainlm');
  
% uczenie sieci: 
%   x – dane wejściowe, 
%   d – wartości zadane (destination)
net = train(net,x,d);

% prezentacja struktury sieci
view(net);		     

% testowanie sieci na danych wejściowych x
y = net(x);	

n_errors = sum(abs(round(y-d)))

perform(net,d,y)
