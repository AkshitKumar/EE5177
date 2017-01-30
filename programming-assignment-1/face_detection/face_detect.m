% Programming Assignment - Question 2

% Initialization
clear; close all; 
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

% Preprocessing the Face Test Data
fprintf('Preprocessing the face fest data...........\n');
face_test = preProcess(face_test_data);
%Preprocessing the Non Face Test Data
fprintf('Preprocessing the non face test data........\n');
non_face_test = preProcess(non_face_test_data);

confusion_matrix = [];

fprintf('Running the evaluation on test data..........\n');
for i = 1:length(face_data_points)
    [mu_face,Sigma_face] = learnParameters(face_train_data,face_data_points(i));
    [mu_non_face, Sigma_non_face] = learnParameters(non_face_train_data, non_face_data_points(i));
    [tp,fn] = evaluate(mu_face,Sigma_face,mu_non_face,Sigma_non_face,face_test);
    [fp,tn] = evaluate(mu_face,Sigma_face,mu_non_face,Sigma_non_face,non_face_test);
    confusion_matrix = [confusion_matrix; tp,fn,fp,tn];
end

fprintf('Plotting the confusion matrix................\n');
plotConfusionMatrix(confusion_matrix);
    


