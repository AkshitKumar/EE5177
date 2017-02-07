function [mu_ml,Sigma_ml] = MLEstimate(data,Sigma)
    mu_ml = mean(data)';
    %Sigma_ml = cov(data);
    Sigma_ml = Sigma;
end