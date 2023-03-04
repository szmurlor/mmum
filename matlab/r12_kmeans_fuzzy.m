close all
x=[2+0.5*randn(10,2); 
   -1+0.3*randn(7,2); 
   0.5+0.4*randn(7,2)]

[C_fcm,U,obj_fcn]=fcm(x,3);
[IDX,C_kmeans]=kmeans(x,3);

hold on
plot(x(1:10,1), x(1:10,2), ...
    '.r', 'MarkerSize', 30)
plot(x(11:17,1), x(11:17,2), ...
    '.g', 'MarkerSize', 30)
plot(x(18:end,1), x(18:end,2), ...
    '.b', 'MarkerSize', 30)
plot(C_fcm(:,1), C_fcm(:,2), ...
    '+k', 'MarkerSize', 20)
scatter(C_kmeans(:,1), C_kmeans(:,2), ...
    150, 'k', 'square', 'filled')
legend('Klasa 1', 'Klasa 2', ...
    'Klasa 3', 'cMeans', 'kMeans')
hold off