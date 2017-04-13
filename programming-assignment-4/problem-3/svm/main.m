%% Initialization
clear; clc; close all;

%% Loading the training data
coast_train = load('../../data/Q2_SVM/coast_train.mat');
coast_train = coast_train.coast_train;

forest_train = load('../../data/Q2_SVM/forest_train.mat');
forest_train = forest_train.forest_train;

mountain_train = load('../../data/Q2_SVM/mountain_train.mat');
mountain_train = mountain_train.mountain_train;

insidecity_train = load('../../data/Q2_SVM/insidecity_train.mat');
insidecity_train = insidecity_train.insidecity_train;

X_train = [coast_train ; forest_train ; mountain_train ; insidecity_train];
y_train = [ones(size(coast_train,1),1) ; 2*ones(size(forest_train,1),1) ; 3*ones(size(mountain_train,1),1) ; 4*ones(size(insidecity_train,1),1)];
%y_train = [zeros(size(coast_train,1),1) ; ones(size(forest_train,1),1) ; ones(size(mountain_train,1),1) ; ones(size(insidecity_train,1),1)];

%% Loading the test data
coast_test = load('../../data/Q2_SVM/coast_test.mat');
coast_test = coast_test.coast_test;

forest_test = load('../../data/Q2_SVM/forest_test.mat');
forest_test = forest_test.forest_test;

mountain_test = load('../../data/Q2_SVM/mountain_test.mat');
mountain_test = mountain_test.mountain_test;

insidecity_test = load('../../data/Q2_SVM/insidecity_test.mat');
insidecity_test = insidecity_test.insidecity_test;

X_test = [coast_test ; forest_test ; mountain_test ; insidecity_test];
y_test = [ones(size(coast_test,1),1) ;  2 * ones(size(forest_test,1),1) ; 3 * ones(size(mountain_test,1),1) ; 4 * ones(size(insidecity_test,1),1)];

%% k-fold cross validation
numFolds = 5;
Indices = crossvalind('Kfold',y_train,numFolds);
sigma = 2.^(-5:5);
C = 2.^(-5:5);

%svmStruct = svmtrain(X_train,y_train,'kernel_function','rbf','rbf_sigma',sigma(1));

% for k = 1:length(sigma)
%     for i = 1:numFolds
%         TestingFoldSample = X_train(Indices == i, :);
%         TrainingFoldSample = X_train(Indices ~= i,:);
%         TrainingFoldLabel = y_train(Indices ~= i,:);
%         svmStruct = svmtrain(TrainingFoldSample,TrainingFoldLabel,'kernel_function','rbf','rbf_sigma',sigma(k));
%         yHat(Indices == i) = svmclassify(svmStruct,TestingFoldSample);   
%     end
%     %accFold(k) = sum(grp2idx(yHat) == grp2idx(TestingFoldSample))/length(TestingFoldSample);
% end
labelSet = unique(y_train);
labelSetSize = length(labelSet);
models = cell(labelSetSize,1);

for i = 1:labelSetSize
    models{i} = svmtrain(X_train,double(y_train == labelSet(i)),'kernel_function','rbf','rbf_sigma',0.1);
end

model = struct('model',{models},'labelSet',labelSet);

models = model.models;
for j = 1:labelSetSize
    C = svmclassify(models{j},X_test);
end
 
    