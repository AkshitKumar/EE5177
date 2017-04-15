% Initialization
clear; clc; close all;

% Loading the training data
coast_train = load('../../data/Q2_SVM/coast_train.mat');
coast_train = coast_train.coast_train;

forest_train = load('../../data/Q2_SVM/forest_train.mat');
forest_train = forest_train.forest_train;

mountain_train = load('../../data/Q2_SVM/mountain_train.mat');
mountain_train = mountain_train.mountain_train;

insidecity_train = load('../../data/Q2_SVM/insidecity_train.mat');
insidecity_train = insidecity_train.insidecity_train;

X_train = [coast_train ; forest_train ; mountain_train ; insidecity_train];
y_train = [ones(size(coast_train,1),1) ; 2 * ones(size(forest_train,1),1) ; 3 * ones(size(mountain_train,1),1) ; 4 * ones(size(insidecity_train,1),1)];

% Loading the test data
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

% Parameter Selection
[bestC,bestSigma,bestcv] = parameterSelection(X_train,y_train,10,0);


param = ['-s ', num2str(0), ' -t ', num2str(0) , ' -c ', num2str(bestC),' -q'];

model = svmtrain(y_train,X_train,param);
[pred,a,decv] = svmpredict(y_test,X_test,model);
acc = sum(y_test == pred)/length(y_test);
