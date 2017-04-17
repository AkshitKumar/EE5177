% Initialization step
clc; clear;
load('train_face.mat');
load('train_nonface.mat');
load('test_face.mat');
load('test_nonface.mat');

% Fitting the distributions to face training data
fit_face_1 = gmdistribution.fit(train_face, 1 , 'CovType', 'diagonal', 'SharedCov', true, 'Regularize', 0.01);
fit_face_2 = gmdistribution.fit(train_face, 2 , 'CovType', 'diagonal', 'SharedCov', true, 'Regularize', 0.01);
fit_face_3 = gmdistribution.fit(train_face, 3 , 'CovType', 'diagonal', 'SharedCov', true, 'Regularize', 0.01);

% Fitting the distributions to non faces training data
fit_nonface_1 = gmdistribution.fit(train_nonface, 1 , 'CovType', 'diagonal', 'SharedCov', true, 'Regularize', 0.01);
fit_nonface_2 = gmdistribution.fit(train_nonface, 2 , 'CovType', 'diagonal', 'SharedCov', true, 'Regularize', 0.01);
fit_nonface_3 = gmdistribution.fit(train_nonface, 3 , 'CovType', 'diagonal', 'SharedCov', true, 'Regularize', 0.01);

% Visualising the means of the fitted data on faces
% k = 1
mu_face_1 = fit_face_1.mu;
mu_face_1 = reshape(mu_face_1,[22,22]);
imwrite(mat2gray(mu_face_1),'mu_face_1.png');
% k = 2
mu_face_2 = fit_face_2.ComponentProportion * fit_face_2.mu;
mu_face_2 = reshape(mu_face_2, [22,22]);
imwrite(mat2gray(mu_face_2),'mu_face_2.png');
% k = 3
mu_face_3 = fit_face_3.ComponentProportion * fit_face_3.mu;
mu_face_3 = reshape(mu_face_3, [22,22]);
imwrite(mat2gray(mu_face_3),'mu_face_3.png');

% Visualising the means of the fitted data on nonfaces
% k = 1
mu_nonface_1 = fit_nonface_1.mu;
mu_nonface_1 = reshape(mu_nonface_1,[22,22]);
imwrite(mat2gray(mu_nonface_1),'mu_nonface_1.png');
% k = 2
mu_nonface_2 = fit_nonface_2.ComponentProportion * fit_nonface_2.mu;
mu_nonface_2 = reshape(mu_nonface_2, [22,22]);
imwrite(mat2gray(mu_nonface_2),'mu_nonface_2.png');
% k = 3
mu_nonface_3 = fit_nonface_3.ComponentProportion * fit_nonface_3.mu;
mu_nonface_3 = reshape(mu_nonface_3, [22,22]);
imwrite(mat2gray(mu_nonface_3),'mu_nonface_3.png');

% Visualize the covariance of the fitted data on faces for k = 1
Sigma_face_1 = fit_face_1.Sigma;
Sigma_face_1 = reshape(Sigma_face_1,[22,22]);
imwrite(mat2gray(Sigma_face_1),'Sigma_face_1.png');

% Visualize the covariance of the fitted data on nonfaces for k = 1
Sigma_nonface_1 = fit_nonface_1.Sigma;
Sigma_nonface_1 = reshape(Sigma_nonface_1, [22,22]);
imwrite(mat2gray(Sigma_nonface_1),'Sigma_nonface_1.png');

% Prediction on the test data for k = 1
num_face = pdf(fit_face_1, test_face);
den_face = num_face + pdf(fit_nonface_1,test_face);
prob_face = num_face ./ den_face;
prob_face = prob_face > 0.5;

num_nonface = pdf(fit_nonface_1, test_nonface);
den_nonface = num_nonface + pdf(fit_face_1, test_nonface);
prob_nonface = num_nonface ./ den_nonface;
prob_nonface = prob_nonface > 0.5;

accuracy = (sum(prob_face) + sum(prob_nonface)) / (size(test_face,1) + size(test_nonface,1));
fprintf('Accuracy for k = 1 equals : %f\n', accuracy * 100);


% Prediction on the test data for k = 2
num_face = pdf(fit_face_2, test_face);
den_face = num_face + pdf(fit_nonface_2,test_face);
prob_face = num_face ./ den_face;
prob_face = prob_face > 0.5;

num_nonface = pdf(fit_nonface_2, test_nonface);
den_nonface = num_nonface + pdf(fit_face_2, test_nonface);
prob_nonface = num_nonface ./ den_nonface;
prob_nonface = prob_nonface > 0.5;

accuracy = (sum(prob_face) + sum(prob_nonface)) / (size(test_face,1) + size(test_nonface,1));
fprintf('Accuracy for k = 2 equals : %f\n', accuracy * 100);


% Prediction on the test data for k = 3
num_face = pdf(fit_face_3, test_face);
den_face = num_face + pdf(fit_nonface_3,test_face);
prob_face = num_face ./ den_face;
prob_face = prob_face > 0.5;

num_nonface = pdf(fit_nonface_3, test_nonface);
den_nonface = num_nonface + pdf(fit_face_3, test_nonface);
prob_nonface = num_nonface ./ den_nonface;
prob_nonface = prob_nonface > 0.5;

accuracy = (sum(prob_face) + sum(prob_nonface)) / (size(test_face,1) + size(test_nonface,1));
fprintf('Accuracy for k = 3 equals : %f\n', accuracy * 100);