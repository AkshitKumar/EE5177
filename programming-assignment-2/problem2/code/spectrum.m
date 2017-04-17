% Initialization
clear; clc;

% Assigning the variables 
K = 7;
costs = [];
s = [];
means = [];

% Load the image
I = double(imread('spectrum.png'));
[rows, cols, numChannels] = size(I);
% dim_x = linspace(1,cols,K); % Part a
% dim_y = rows / 2; % Part a
dim_x = randi([1,rows],K,1); % Part b
dim_y = randi([1,cols],K,1); % Part b
for i = 1:K
    means = cat(2,means, I(dim_x(i),dim_y(i),:));
end

means = reshape(means,[7,3]);
cluster = zeros(rows,cols);

for i = 1:100
    [cluster_temp, cost] = clustering(I, means);
    costs = [costs; cost];
    num_cluster_change = nnz(cluster_temp - cluster);
    s = [s; nnz(cluster_temp - cluster)];
    cluster = cluster_temp;
    clustered_image = uint8(getClusteredImage(K,means,I,cluster));
    if num_cluster_change == 0
        break;
    end
    means = getMeans(I,cluster,K);
end

imwrite(clustered_image,'spectrum_kmeans_rand1.png');
% imwrite(clustered_image,'spectrum_kmeans_fixed_means.png');
 
    