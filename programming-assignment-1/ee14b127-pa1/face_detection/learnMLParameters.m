function [mu,Sigma] = learnMLParameters(X)
    mu = mean(X);
    Sigma = cov(X);
end