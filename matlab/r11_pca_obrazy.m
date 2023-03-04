% Porównanie algorytmów PCA i TSNE w wizualizacji obrazów twarzy (5 klas)
num_class = 5;                      % Number of classes to read
folder_z_obrazami = 'C:\Users\szmurlor\Nextcloud\Alex_obrazy20';
images = imageDatastore(folder_z_obrazami,... 
    'IncludeSubfolders',true,...
    'ReadFcn', @customreader, ...
    'LabelSource','foldernames');
input_data = []; labels = [];

for i=1:length(images.Files)
    if int8(images.Labels(i)) <= num_class
        image = imread(images.Files{i});
        image= imresize(image, 0.5);
        vec = reshape(image,1,[]);   % Image flatten
        input_data = [input_data;vec];
        labels = [labels;images.Labels(i)];
    end
end
input_data = im2double(input_data);
[~,Y_pca] = pca(input_data);          % Dimensionality reduction
Y_tsne = tsne(input_data);
figure, 
subplot(1,2,1)
scatter(Y_pca(:,1), Y_pca(:,2), ...
        50, labels, 'filled')
grid on, title('PCA'), colormap(jet(size(Y_pca,1)))

subplot(1,2,2)
scatter(Y_tsne(:,1), Y_tsne(:,2), ...
        50, labels, 'filled')
grid on, title('TSNE'), colormap(jet(size(Y_tsne,1)))

function data = customreader(filename)
    I = imread(filename);
    [a,b,c] = size(I);    
    if c==1,
        I = grs2rgb(I);
    end    
    data=imresize(I,[227 227]);
end