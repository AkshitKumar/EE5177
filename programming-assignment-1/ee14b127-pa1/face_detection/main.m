% Programming Assignment - Question 2

% Initialization setp
clear; close all; clc;
fprintf('Loading the data set..................\n');

% Getting the directories for loading the data
face_train_dir = dir('../PA1_data/Problem2_data/face_train/');
face_test_dir = dir('../PA1_data/Problem2_data/face_test/');
non_face_train_dir = dir('../PA1_data/Problem2_data/nonface_train/');
non_face_test_dir = dir('../PA1_data/Problem2_data/nonface_test/');

% Matrix initialization for stacking the training data
face_train_data = [];
non_face_train_data = [];

% Matrix initialization for stacking the test data
face_test_data = [];
non_face_test_data = [];

fprintf('Stacking the face training data.........\n');
% Stacking the faces training data into a 660 X 784 matrix
for i = 3:length(face_train_dir)
    face = imread(strcat('../PA1_data/Problem2_data/face_train/',face_train_dir(i).name));
    face = im2double(face); % Scaling values from [0,255] to [0,1]
    face = face(:)'; % Unrolling of the parameters
    face_train_data = [face_train_data;face]; % Add new row in each iteration  
end

% Stacking the non faces training data into a 400 X 784 matrix
fprintf('Stacking the non face training data.......\n');
for i = 3:length(non_face_train_dir)
    non_face = imread(strcat('../PA1_data/Problem2_data/nonface_train/',non_face_train_dir(i).name));
    non_face = im2double(non_face); % Scaling values from [0,255] to [0,1]
    non_face = non_face(:)'; % Unrolling of the parameters
    non_face_train_data = [non_face_train_data;non_face]; % Add new row in each iteration
end

% Stacking the faces testing data into a 500 X 784 matrix
fprintf('Stacking the face test data................\n');
for i = 3:length(face_test_dir)
    face = imread(strcat('../PA1_data/Problem2_data/face_test/',face_test_dir(i).name));
    face = im2double(face);
    face = face(:)'; % Unrolling of the parameters
    face_test_data = [face_test_data;face]; % Add rows in each iteration 
end

% Stacking the non face testing data into a 395 X 784 matrix
fprintf('Stacking the non face test data.............\n');
for i = 3:length(non_face_test_dir)
    face = imread(strcat('../PA1_data/Problem2_data/nonface_test/',non_face_test_dir(i).name));
    face = im2double(face);
    face = face(:)'; % Unrolling of the parameters
    non_face_test_data = [non_face_test_data;face]; % Add rows in each iteration 
end

face_data_points = [150,150,200,250,300,300,400,400,600];
non_face_data_points = [150,200,200,200,200,300,300,300,400];

confusion_matrix = [];

for i = 1:length(face_data_points)
    % Get the reduced data set
    face_train_data_sub = face_train_data(1:face_data_points(i),:);
    non_face_train_data_sub = non_face_train_data(1:non_face_data_points(i),:);
    
    % Calculate the Eigen Vectors for face and non face data sets
    [U_face,S_face] = pca(face_train_data_sub);
    % [U_non_face,S_non_face] = pca(non_face_train_data_sub);
    
    % Projecting the data to plane of highest variance 
    Z_face_train = projectData(face_train_data_sub,U_face,140);
    Z_non_face_train = projectData(non_face_train_data_sub,U_face,140);
    Z_face_test = projectData(face_test_data,U_face,140);
    Z_non_face_test = projectData(non_face_test_data,U_face,140);
    
    % Learn ML Parameters from training set
    [mu_face,Sigma_face] = learnMLParameters(Z_face_train);
    [mu_non_face,Sigma_non_face] = learnMLParameters(Z_non_face_train);
    
    % Evaluate the test data set
    [tp,fn] = evaluate(mu_face,Sigma_face,mu_non_face,Sigma_non_face,Z_face_test);
    [fp,tn] = evaluate(mu_face,Sigma_face,mu_non_face,Sigma_non_face,Z_non_face_test);
    
    confusion_matrix = [confusion_matrix; tp,fn,fp,tn];
end
   
fprintf('Plotting the confusion matrix................\n');
%plotConfusionMatrix(confusion_matrix);
plotClassificationAccuracy(confusion_matrix);

% Get the loglikelihood score for faces and non faces
% By observing the classification accuracy, we find that model on 600 face
% training set and 400 non face training set does the best
face_train_data_sub = face_train_data(1:600,:);
non_face_train_data_sub = non_face_train_data(1:400,:);

[U_face,S_face] = pca(face_train_data_sub);
[U_non_face,S_non_face] = pca(non_face_train_data_sub);

Z_face_train = projectData(face_train_data_sub,U_face,140);
Z_non_face_train = projectData(non_face_train_data_sub,U_non_face,140);
Z_face_test = projectData(face_test_data,U_face,140);
Z_non_face_test = projectData(non_face_test_data,U_non_face,140);

[mu_face,Sigma_face] = learnMLParameters(Z_face_train);
[mu_non_face,Sigma_non_face] = learnMLParameters(Z_non_face_train);

[face_model_on_faces,non_face_model_on_faces,face_model_on_non_faces,non_face_model_on_non_faces] = plotLikelihood(mu_face,Sigma_face,mu_non_face,Sigma_non_face,Z_face_test,Z_non_face_test);

[tpr,fpr] = plotROC(-50,1,50,mu_face,Sigma_face,Z_face_test,Z_non_face_test,1);
[tpr2,fpr2] = plotROC(-100,1,100,mu_non_face,Sigma_non_face,Z_face_test,Z_non_face_test,2);

threshold_faces = -50 + find(fpr <= 0.2,1);
threshold_non_faces = -100 + find(fpr2 <= 0.2,1);

fprintf('Threshold for Faces is : %d\n',threshold_faces);
fprintf('Threshold for Non faces is : %d \n',threshold_non_faces);



