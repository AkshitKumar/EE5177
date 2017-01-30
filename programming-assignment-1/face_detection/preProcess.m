function Z = preProcess(X)
    X = featureNormalize(X);
    [U,S] = pca(X);
    K = 140;
    Z = projectData(X,U,K);
end