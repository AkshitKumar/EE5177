% Programming Assignment - Question 2
% Initialization
clear; close all; clc
fprintf('Loading the data set\n');
face_train_dir = dir('../PA1_data/Problem2_data/face_train/');
face_test_dir = dir('../PA1_data/Problem2_data/face_test/');
non_face_train_dir = dir('../PA1_data/Problem2_data/nonface_train/');
non_face_test_dir = dir('../PA1_data/Problem2_data/nonface_test/');
face_train_data = [];
non_face_train_data = [];
face_test_data = [];
non_face_test_data = [];

for i = 3:length(face_train_dir)
    face = imread(strcat('../PA1_data/Problem2_data/face_train/',face_train_dir(i).name));
    face = im2double(face);
    face = face(:)'; % Unrolling of the parameters
    face_train_data = [face_train_data;face]; % Add rows in each iteration  
end

%face_train_data = face_train_data'; % Transpose to get a 784 X 660 matrix

for i = 3:length(non_face_train_dir)
    non_face = imread(strcat('../PA1_data/Problem2_data/nonface_train/',non_face_train_dir(i).name));
    non_face = im2double(non_face);
    non_face = non_face(:)'; % Unrolling of the parameters
    non_face_train_data = [non_face_train_data;non_face];
end

%non_face_train_data = non_face_train_data';

%Scaling the values from [0,255] to [0,1]
%face_train_data = face_train_data / 255;
%non_face_train_data = non_face_train_data / 255;


face_train_norm = featureNormalize(face_train_data);
[U_face,S_face] = pca(face_train_norm);
K = 140;
Z_face = projectData(face_train_norm,U_face,K);

non_face_train_norm = featureNormalize(non_face_train_data);
[U_non_face,S_non_face] = pca(non_face_train_norm);
K = 140;
Z_non_face = projectData(non_face_train_norm,U_non_face,K);

mu_face = mean(Z_face);
%Sigma_face = cov(Z_face);
Sigma_face = (1/size(Z_face,1)) * (Z_face' * Z_face);
disp(det(Sigma_face));

mu_non_face = mean(Z_non_face);
%Sigma_non_face = cov(Z_non_face);
Sigma_non_face = (1/size(Z_non_face,1)) * (Z_non_face' * Z_non_face);
disp(det(Sigma_non_face));

for i = 3:length(face_test_dir)
    face = imread(strcat('../PA1_data/Problem2_data/face_test/',face_test_dir(i).name));
    face = im2double(face);
    face = face(:)'; % Unrolling of the parameters
    face_test_data = [face_test_data;face]; % Add rows in each iteration 
end


for i = 3:length(non_face_test_dir)
    face = imread(strcat('../PA1_data/Problem2_data/nonface_test/',non_face_test_dir(i).name));
    face = im2double(face);
    face = face(:)'; % Unrolling of the parameters
    non_face_test_data = [non_face_test_data;face]; % Add rows in each iteration 
end
%face_test_data = face_test_data / 255;

face_test_norm = featureNormalize(face_test_data);
[U_face_test,S_face_test] = pca(face_test_norm);
K = 140;
Z_face_test = projectData(face_test_norm,U_face_test,K);

non_face_test_norm = featureNormalize(non_face_test_data);
[U_non_face_test, S_non_face_test] = pca(non_face_test_norm);
K = 140;
Z_non_face_test = projectData(non_face_test_norm, U_non_face_test, K);

result = [];
probs_face = [];
probs_non_face = [];

for i = 1:size(Z_face_test,1)
    x = Z_face_test(i,:);
    prob_face = loglikelihood(x,mu_face,Sigma_face);
    probs_face = [probs_face,prob_face];
    prob_non_face = loglikelihood(x,mu_non_face,Sigma_non_face);
    probs_non_face = [probs_non_face,prob_non_face];
    if(prob_face > prob_non_face)
        result = [result; 1];
    else
        result = [result; 0];
    end
end
    
result2 = [];
probs_face_2 = [];
probs_non_face_2 = [];

for i = 1:size(Z_non_face_test,1)
    x = Z_non_face_test(i,:);
    prob_face = loglikelihood(x,mu_face,Sigma_face);
    probs_face_2 = [probs_face_2,prob_face];
    prob_non_face = loglikelihood(x,mu_non_face,Sigma_non_face);
    probs_non_face_2 = [probs_non_face_2,prob_non_face];
    if(prob_face > prob_non_face)
        result2 = [result2; 1];
    else
        result2 = [result2; 0];
    end
end
   
    


