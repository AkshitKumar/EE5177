% Initialization
clear; clc;
% Assigning variables 
K = 8;
costs = [];
s = [];
means = randi([0 255], K , 3);
I = double(imread('rio.png'));
[rows, cols, numChannels] = size(I);
cluster = zeros(rows,cols);

for i = 1:100
    [cluster_temp , cost] = clustering(I,means);
    costs = [costs;cost];
    number_Changes = nnz(cluster_temp - cluster);
    s = [s,number_Changes];
    cluster = cluster_temp;
    clustered_image = uint8(getClusteredImage(K,means,I,cluster));
    if and(i < 11, or(K == 2 ,K == 4)) 
        imwrite(clustered_image,strcat('clustered_image_iter_',int2str(i),'_K_',int2str(K),'.png'));
    end
    if number_Changes == 0
        break;
    end
    means = getMeans(I,cluster,K);
end

imwrite(clustered_image,strcat('rio_clustered_image_K_',int2str(K),'.png'));
figure(1)
plot(1:i,s);
title('Number of cluster changes vs iteration');
xlabel('iteration');
ylabel('Number of cluster changes');

figure(2)
plot(1:i,costs);
title('Cost vs Iteration');
xlabel('iteration');
ylabel('Cost(d^{(t)})');