function [cluster,cost] = clustering(image, means)
    K = size(means);
    euclidean_norm = [];
    [rows, cols, numChannels] = size(image);
    for i = 1:K
        norm_matrix = [];
        for j = 1:rows
            norm_col = [];
            for k = 1:cols
                norm_col = [norm_col, norm(reshape(image(j,k,:),[1,3]) - means(i,:))];
            end
            norm_matrix = [norm_matrix;norm_col];
        end
        euclidean_norm = cat(3,euclidean_norm,norm_matrix);
    end
    [min_euclidean_norm , cluster] = min(euclidean_norm, [], 3);
    cluster = cluster;
    cost = sum(sum(min_euclidean_norm));
end
    