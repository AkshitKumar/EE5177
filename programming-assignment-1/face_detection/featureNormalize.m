function X_norm = featureNormalize(X)
    X_norm = bsxfun(@minus, X, mean(X));
    X_norm = bsxfun(@rdivide,X_norm,std(X_norm));
    %X_norm = X;
end