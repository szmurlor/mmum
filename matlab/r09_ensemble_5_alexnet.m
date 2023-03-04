% Program klasyfikacji do rozpoznania 68 klas obrazów twarzy
wyn=[]; wynVal=[];
Pred_y=[]; Pred_yVal=[]; 

% Pozyskiwanie obrazów
folder_z_obrazami = '[sciezka do folderu z obrazami]\ALEX_obrazy_all';
folder_z_obrazami = 'C:\Users\szmurlor\Nextcloud\ALEX_obrazy_all';
images = imageDatastore( folder_z_obrazami,...
 'IncludeSubfolders',true,...
 'ReadFcn', @customreader, ...
 'LabelSource','foldernames');
    
[uczImages,testImages] = splitEachLabel(images,0.8,'randomized');
for i=1:5
    i
    [trainingImages,validationImages] = ...
        splitEachLabel(uczImages,0.75+0.22*rand(1),'randomized');
    numTrainImages = numel(trainingImages.Labels);
    
    net = alexnet;
    % layersTransfer = net.Layers(1:end-3);
    layersTransfer = net.Layers(1:end-6);
    inputSize = net.Layers(1).InputSize;
    
    imageAugmenter = imageDataAugmenter( ...
    'RandRotation',[-20,20], ...
    'RandXTranslation',[-3 3], ...
    'RandYTranslation',[-3 3]);
    augimdsTrain = augmentedImageDatastore(inputSize(1:2),trainingImages,...
        'DataAugmentation',imageAugmenter);
    augimdsTest = augmentedImageDatastore(inputSize(1:2),testImages);
    layer = 'fc7';

    featuresTrain = activations(net, augimdsTrain, layer, 'OutputAs','rows');
    featuresTest = activations(net, augimdsTest, layer, 'OutputAs','rows');
    
    numClasses = numel(categories(trainingImages.Labels));
    layers = [
        layersTransfer
        fullyConnectedLayer(500+35*i, ... % randomizacja osobników zbioru
                    'WeightLearnRateFactor',20,...
                    'BiasLearnRateFactor',20)
        reluLayer()
        dropoutLayer( 0.3+0.23*rand(1) ) % randomizacja osobników zbioru
        fullyConnectedLayer(numClasses, ...
                    'WeightLearnRateFactor',20,...
                    'BiasLearnRateFactor',20)
        softmaxLayer
        classificationLayer];
    
    miniBatchSize = 10; 
    numIterationsPerEpoch = floor(numel(trainingImages.Labels)/miniBatchSize);
    options = trainingOptions('sgdm',...
        'MiniBatchSize',miniBatchSize,...
        'MaxEpochs',10,...
        'ExecutionEnvironment','gpu',...
        'InitialLearnRate',1.3e-4,...
        'Verbose',false,...
        'ValidationPatience',10,...% było 10
        'Plots','training-progress',...
        'ValidationData',validationImages,...
        'ValidationFrequency',numIterationsPerEpoch);
    netTransfer = trainNetwork(augimdsTrain,layers,options);
    predictedLabels = classify(netTransfer,testImages);
    testLabels = testImages.Labels;
    accuracy = (mean(predictedLabels == testLabels))*100;

    xu=double(featuresTrain);  maxu=max(abs(xu)); xu=xu./maxu;
    xt=double(featuresTest);   xt=xt./maxu;
    ducz=double(trainingImages.Labels);
    dtest=double(testLabels);
    
    % zbieramy kolejne wyniki klasyfikacji do późniejszego głosowania
    Pred_y = [Pred_y double(predictedLabels)];
    wyn= [wyn accuracy]
end
nclass=numClasses

% Integracja zespołu
dy=[dtest Pred_y]
nclass=numClasses
clear dz
[lw,lk]=size(dy);
for i=1:lw
    for j=1:nclass
        d=0;
      for k=2:lk
        if (j==double(dy(i,k)))
            d=d+1;
        else
        end
      end
      
       dz(i,j)=d;
%      klasa=dy(:,1)
    end
end
dz;
[q,cl_max]=max(dz');
zgod_class=length(find(double(dy(:,1))==cl_max'));

dokl_zesp=zgod_class/lw*100
F1_zesp=2*prec.*sen./(prec+sen) 

% Macierz rozkładu klas
[C,order] = confusionmat(double(testLabels),double(cl_max));
Confusion=C

% Wyniki niezintegrowanych członków zespołu
for i=1:nclass,
     sen(i)=C(i,i)/sum(C(i,:));
end

for i=1:nclass,
 prec(i)=C(i,i)/sum(C(:,i));
end
sen;
prec;

wyn
median_zesp=median(wyn)
max_zesp=max(wyn)
mean_zesp=mean(wyn)
odch_zesp=std(wyn)

function data = customreader(filename)
    I = imread(filename);
    [a,b,c] = size(I);    
    if c==1,
        I = grs2rgb(I);
    end    
    data=imresize(I,[227 227]);
end