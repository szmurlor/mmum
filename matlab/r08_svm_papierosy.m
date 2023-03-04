load papierosy.mat
xd=[x,d];
nn=randperm(2200);
xdperm=xd(nn,:);

% pomijamy ostatnia kolumne, ponieważ 
% zawiera wartości oczekiwane
xu=xdperm(1:1000,1:end-1);
xt=xdperm(1001:2200,1:end-1);

% ostatnia kolumna to wartości oczekiwane
du=xdperm(1:1000,end);
dt=xdperm(1001:2200,end);

svm=fitcecoc(xu,du)

y=predict(svm,xt)

n_errors = sum( y~=dt )
error_percent = n_errors/length(dt)*100

% wizualizacja danych błednie sklasyfikowanych
figure, plot( y~=dt ), grid
