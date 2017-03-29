% Initialization Step
clear; clc; close all;

% Generate Synthetic Data
x = -3:0.01:4;
y = sinc(x); % Generating data from sinc function
z = awgn(y,25); % Adding noise to the data

% Plotting actual data
plot(x,y);
xlabel('Data')
ylabel('True World State')
title('True World State vs Data')
print -dpng plots/sinc.png

% Plotting data with added noise
plot(x,z);
xlabel('Data')
ylabel('Synthetic World State')
title('True World State vs Data')
print -dpng plots/sinc_noise.png

alphas_rbf = get_alphas(6);
alphas_arctan = get_alphas(7);

%{
x_rbf_transform = rbf_transform(x,alphas_rbf,lambda);
x_arctan_transform = arctan_transform(x,alphas_arctan,lambda);

% Estimates of the weights of the RBF Transform function 
phi_rbf = inv(x_rbf_transform * x_rbf_transform') * x_rbf_transform * z';
variance_rbf = inv(x_rbf_transform * x_rbf_transform') * x_rbf_transform * z';

% Estimates of the weights of the arctan transform function
phi_arctan = inv(x_arctan_transform * x_arctan_transform') * x_arctan_transform * z';
variance_arctan = inv(x_arctan_transform * x_arctan_transform') * x_arctan_transform * z';
%}

lambdas = 0.01:0.001:7;
[pred_error,fitting_error,min_pred_err,min_pred_err_lambda,min_fit_err,min_fit_err_lambda] = fitting_rbf(lambdas,alphas_rbf,x,y,z);
min_num_kernel = fitting_kernel(min_pred_err_lambda,x,y,z);
[pred_error_arctan,fitting_error_arctan,min_pred_err_arctan,min_pred_err_lambda_arctan,min_fit_err_arctan,min_fit_err_lambda_arctan] = fitting_arctan(lambdas,alphas_arctan,x,y,z);

