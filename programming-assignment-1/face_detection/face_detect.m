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
face_train_data = face_train_data / 255;
non_face_train_data = non_face_train_data / 255;

[U,S] = pca(face_train_data);
K = 140;
Z = projectData(face_train_data,U,K);
