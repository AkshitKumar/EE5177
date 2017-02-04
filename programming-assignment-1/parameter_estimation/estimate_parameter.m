% Initialization step
clear; close all; clc

% Loading the given dataset
fprintf('Loading the dataset ............... \n');
load('../PA1_data/Problem1_data/data.mat')

x = [2:500];

sum_ml = zeros(499,1);
sum_map = zeros(499,1);
sum_bayesian = zeros(499,1);

fprintf('Computing the ML,MAP and Bayesian estimates for prior 1....... \n');
for i = 1:500:size(data,1)
    fprintf('Taking the data set number : %d\n',i/500 + 1);
    [d_ml,d_map,d_bayesian] = compute(data(i:i+499,:),mu01,Sigma01,Sigma,mu);
    sum_ml = sum_ml + d_ml;
    sum_map = sum_map + d_map;
    sum_bayesian = sum_bayesian + d_bayesian;
end

sum_ml = sum_ml/100;
sum_map = sum_map / 100;
sum_bayesian = sum_bayesian / 100;

plotDvsN(sum_ml,sum_map,sum_bayesian,1);

sum_ml = zeros(499,1);
sum_map = zeros(499,1);
sum_bayesian = zeros(499,1);

fprintf('Computing the ML,MAP and Bayesian estimates for prior 2....... \n');
for i = 1:500:size(data,1)
    fprintf('Taking the data set number : %d\n',i/500 + 1);
    [d_ml,d_map,d_bayesian] = compute(data(i:i+499,:),mu02,Sigma02,Sigma,mu);
    sum_ml = sum_ml + d_ml;
    sum_map = sum_map + d_map;
    sum_bayesian = sum_bayesian + d_bayesian;
end

sum_ml = sum_ml/100;
sum_map = sum_map / 100;
sum_bayesian = sum_bayesian / 100;

plotDvsN(sum_ml,sum_map,sum_bayesian,2);