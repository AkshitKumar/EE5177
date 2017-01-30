% Initialization step
clear; close all; clc

% Loading the given dataset
load('../PA1_data/Problem1_data/data.mat')

% Get the ML Estimate of the data
[mu_ml, Sigma_ml] = MLEstimate(data);