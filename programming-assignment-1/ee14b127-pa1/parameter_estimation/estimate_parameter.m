% Initialization step
clear; close all; clc

% Loading the given dataset
fprintf('Loading the dataset ............... \n');
load('../PA1_data/Problem1_data/data.mat')

% Setting the sum_ml, sum_map,sum_bayesian to store the mean of the
% bhattacharya distances
sum_ml = zeros(499,1);
sum_map = zeros(499,1);
sum_bayesian = zeros(499,1);

% Computing the ML, MAP and Bayesian estimates for prior 1
fprintf('Computing the ML,MAP and Bayesian estimates for prior 1....... \n');
% Dividing the data set into 100 disjoint sets
for i = 1:500:size(data,1)
    fprintf('Taking the data set number : %d\n',floor(i/500) + 1);
    % Computing the bhattacharya distance for ml, map and bayesian
    [d_ml,d_map,d_bayesian] = compute(data(i:i+499,:),mu01,Sigma01,Sigma,mu);
    % Taking the sum across all the 100 data sets
    sum_ml = sum_ml + d_ml;
    sum_map = sum_map + d_map;
    sum_bayesian = sum_bayesian + d_bayesian;
end

% Taking the mean for bhattacharya distance
sum_ml = sum_ml/100;
sum_map = sum_map / 100;
sum_bayesian = sum_bayesian / 100;

% Plotting bhattacharya distance versus n
plotDvsN(sum_ml,sum_map,sum_bayesian,1);

% Setting the sum_ml, sum_map,sum_bayesian to store the mean of the
% bhattacharya distances
sum_ml = zeros(499,1);
sum_map = zeros(499,1);
sum_bayesian = zeros(499,1);

% Computing the ML, MAP and Bayesian estimates for prior 2
fprintf('Computing the ML,MAP and Bayesian estimates for prior 2....... \n');
% Dividing the data set into 100 disjoint sets
for i = 1:500:size(data,1)
    fprintf('Taking the data set number : %d\n',floor(i/500) + 1);
    % Computing the bhattacharya distance for ml, map and bayesian
    [d_ml,d_map,d_bayesian] = compute(data(i:i+499,:),mu02,Sigma02,Sigma,mu);
    % Taking the sum across all the 100 data sets
    sum_ml = sum_ml + d_ml;
    sum_map = sum_map + d_map;
    sum_bayesian = sum_bayesian + d_bayesian;
end

% Taking the mean for bhattacharya distance
sum_ml = sum_ml/100;
sum_map = sum_map / 100;
sum_bayesian = sum_bayesian / 100;

% Plotting bhattacharya distance versus n
plotDvsN(sum_ml,sum_map,sum_bayesian,2);