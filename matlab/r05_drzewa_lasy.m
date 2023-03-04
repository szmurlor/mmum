function r05_drzewa_lasy

% Przykład użycia klasy treebagger
x1=1+randn(20,5);
x2=-2+randn(20,5);
x3=3+randn(20,5);
x=[x1;x2;x3];
d=[ones(20,1);2*ones(20,1);3*ones(20,1)];

b = TreeBagger(50,x,d,'oobpred','on', 'OOBVarImp', 'on', 'NVarToSample',3, 'OOBPredictorImportance','on')

% Ważność cech
q1=b.OOBPermutedVarDeltaError;  
figure(1),bar(q1)

% Inna metoda oceny ważności cech
q2=b.OOBPermutedVarCountRaiseMargin; 
figure(2),bar(q2)


% out-of-bag error
figure(3),plot(oobError(b))
xlabel('Liczba drzew')
ylabel('Błąd klasyfikacji na danych weryfikujących')
grid

end