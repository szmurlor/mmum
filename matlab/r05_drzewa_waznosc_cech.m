% Badanie ważności cech diagnostycznych
x1=1+randn(20,5);
x2=-2+randn(20,5);
x3=3+randn(20,5);
x=[x1;x2;x3];
d=[ones(20,1);2*ones(20,1);3*ones(20,1)];
Mdl = fitcensemble(x,d,'Method', ...
   'Bag','NumLearningCycles',50);

% funkcja badajaca ważność cech
imp = oobPermutedPredictorImportance(Mdl); 

figure;
bar(imp);
title({'Out-of-Bag Permuted Predictor' 
      'Importance Estimates'});
ylabel('Estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = Mdl.PredictorNames;
h.XTickLabelRotation = 90;
h.TickLabelInterpreter = 'none';
