% Drzewo decyzyjne
      X=[0.2 0.8
 0.4 0.8
 0.6 0.8
 0.8 0.8
 0.2 0.6
 0.4 0.6
 0.6 0.6 
 0.8 0.6
 0.2 0.4
 0.6 0.4
 0.4 0.2
 0.8 0.2];
     d= ['kl1'
 'kl2'
 'kl1'
 'kl1'
 'kl1'
 'kl1'
 'kl1'
 'kl2'
 'kl2'
 'kl2'
 'kl1'
 'kl2'];
      C=[0 10
 10 0]; 
      T=fitctree(X,d, 'splitcriterion', 'gdi','cost',C, 'Minparent',1);
      view(T,'Mode','graph')

      
load fisheriris
C=[0 10 10
   10 0 10
   10 10 0];
% T = fitctree(meas, species)
T=fitctree(meas,species, 'splitcriterion', 'gdi','cost',C, 'MinLeafSize',1);
view(T,'Mode','graph')
