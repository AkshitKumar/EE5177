% Initialization Step
clear; clc; close all;

% Reading the file data
% Reading data from the train file
[train_file_name, train_angle, train_centX, train_centY, train_cropW, train_cropH] = read_file('data/train.txt');
% Reading data from the test file
[test_file_name, test_angle, test_centX, test_centY, test_cropW, test_cropH] = read_file('data/test.txt');

% Feature Extraction using HOG 
train_hog_features = feature_extraction(train_file_name, train_angle, train_centX, train_centY, train_cropW, train_cropH);
test_hog_features = feature_extraction(test_file_name, test_angle, test_centX, test_centY, test_cropW, test_cropH);

% Linear Regression on HoG Features
[linear_regression_train_rmse, linear_regression_test_rmse,linear_regression_prediction] = linear_regression(train_hog_features,test_hog_features,train_angle, test_angle);

% Dual Regression 
[dual_regression_train_rmse, dual_regression_test_rmse,dual_regression_prediction] = dual_regression(train_hog_features,test_hog_features,train_angle, test_angle);

% Linear Regression with PCA
[linear_regression_pca_train_rmse, linear_regression_pca_test_rmse,linear_regression_pca_prediction] = linear_regression_pca(train_hog_features,test_hog_features,train_angle, test_angle);

% Dual Regression with Kernel Trick
[dual_kernel_train_rmse, dual_kernel_test_rmse,dual_kernel_prediction] = dual_regression_kernel(train_hog_features,test_hog_features,train_angle,test_angle);

dual_kernel_pred_lambda1 = dual_kernel_prediction(1:600);
dual_kernel_pred_lambda2 = dual_kernel_prediction(601:1200);
dual_kernel_pred_lambda3 = dual_kernel_prediction(1201:1800);
% Comparison
test_image_index = [122,337,405,428,550];
linear_regression_angle = [];
dual_regression_angle = [];
linear_regression_pca_angle = [];
dual_kernel_angle_lambda1 = [];
dual_kernel_angle_lambda2 = [];
dual_kernel_angle_lambda3 = [];
for i = 1:length(test_image_index)
    linear_regression_angle = [linear_regression_angle; linear_regression_prediction(test_image_index(i))];
    dual_regression_angle = [dual_regression_angle; dual_regression_prediction(test_image_index(i))];
    linear_regression_pca_angle = [linear_regression_pca_angle; linear_regression_pca_prediction(test_image_index(i))];
    dual_kernel_angle_lambda1 = [dual_kernel_angle_lambda1; dual_kernel_pred_lambda1(test_image_index(i))];
    dual_kernel_angle_lambda2 = [dual_kernel_angle_lambda2; dual_kernel_pred_lambda2(test_image_index(i))];
    dual_kernel_angle_lambda3 = [dual_kernel_angle_lambda3; dual_kernel_pred_lambda3(test_image_index(i))];
end