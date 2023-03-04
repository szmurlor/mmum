%x = [ 1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20];
%d = [ -1.69	-0.79	5.77	7.80	4.56	14.32	15.47	8.88	7.41	17.26	14.83	20.47	20.39	27.04	22.53	22.36	29.35	22.86	31.22	28.13]
%polyfit(x,d,1)


%Przykład zastosowania obu funkcji regresji liniowej
x = (1:10)';
d = 5 - 3*x + 5*randn(10,1); 
d(3)= 50;d(10) = 100;   % wartości odstające
bls = regress(d,[ones(10,1) x])
[brob,stats] = robustfit(x,d)
hold on
plot(x,brob(1)+brob(2)*x,'r-', x,bls(1)+bls(2)*x,'m:')
legend('robustfit', 'regress')
plot(x,d, 'o')
stats.w