function [mu_ml,Sigma_ml] = MLEstimate(data)
    mu_ml = mean(data);
    Sigma_ml = cov(data);
end