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
y_train = [zeros(size(coast_train,1),1) ; ones(size(forest_train,1),1) ; 2 * ones(size(mountain_train,1),1) ; 3 * ones(size(insidecity_train,1),1)];

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
y_test = [zeros(size(coast_test,1),1) ;  ones(size(forest_test,1),1) ; 2 * ones(size(mountain_test,1),1) ; 3 * ones(size(insidecity_test,1),1)];

cverr = [];
testerr = [];

k = 5:5:100;
for i = 1:length(k)
    model = glmnet(X_train,y_train,'multinomial');
    CVerr = cvglmnet(X_train,y_train,'multinomial',[],[],k(i));
    cverr = [cverr ; min(CVerr.cvm)];
    yHat = glmnetPredict(model,X_test,CVerr.lambda_min,'class');
    accuracy = (80 - nnz(y_test - yHat))/80;
    testerr = [testerr ; 1 - accuracy];
end

figure(1);
plot(k,cverr);
figure(2);
plot(k,testerr);
