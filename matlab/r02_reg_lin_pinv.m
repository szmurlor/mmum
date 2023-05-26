X=[3 0 2 3; 
   4 1 2 2; 
   1 0 1 6; 
   5 0 4 1; 
   4 0 2 1; 
   2 2 3 1]
d=[1 0 0 2 3 5]'
W=pinv(X)
X*W

a=pinv(X)*d
plot(1:6,d, 'r', 1:6, X*a, 'b', 'LineWidth',2)
ylabel('d,y')
xlabel('x')
legend('d','y=X*a')

grid