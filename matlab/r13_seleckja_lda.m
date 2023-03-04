x1=1:10;x1=1.2*x1+0.9*randn(1,10);
x2=0.3*x1+0.1+0.1*randn(1,10);
x3=x1+0.1*randn(1,10); 
x4=0.05*x3-0.1+0.2*randn(1,10)
x=[x1' x2'; x3' x4'];
figure(1),
plot(x(1:10,1),x(1:10,2),'rx',...
     x(11:20,1),x(11:20,2),'go')
 
%PCA
rxx=x'*x/20;
[v,d]=eig(rxx);
v
d
w=[v(:,2)]'
y=w*x'
figure(2),
plot(1:10,y(1:10),'rx',...
     1:10,y(11:20),'go')
% LDA
m=mean(x);
m1=mean(x(1:10,:));
m2=mean(x(11:20,:));
sb=10*(m1-m)'*(m1-m)+ ...
   10*(m2-m)'*(m2-m);
sb
sw=zeros(2,2);
for i=1:10
   sw=sw+(x(i,:)-m1)'*(x(i,:)-m1)+ ...
         (x(i+10,:)-m2)'*(x(i+10,:)-m2)
end
return
 
[v,d]=eig(sb,sw);
w=[v(:,2)]';
y=w*x';
figure,
plot(1:10,y(1:10),'rx',...
     1:10,y(11:20),'go')
