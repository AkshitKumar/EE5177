function [mu,sigma] = learnParameters(X,K)
    X_sub = X(1:K,:); % Select the first K rows
    X_sub = featureNormalize(X_sub);
    [U,S] = pca(X_sub); % Apply PCA on the selected data
    P = 140; % Number of principal components to be used
    Z = projectData(X_sub,U,P); % Project the data on a lower dimensional plane
    mu = mean(Z); % Maximum Likelihood mean is the mean of data
    sigma = cov(Z); % Maximum Likelihood covariance 
end