function [mu_bayesian,Sigma_bayesian] = BayesianEstimate(data,mu_prior,Sigma_prior,Sigma)
    avg = mean(data)';
    n = size(data,1);
    mu_bayesian = (Sigma_prior * inv(Sigma_prior + (1/n)*Sigma) * avg) + (1/n)*Sigma*inv(Sigma_prior + 1/n*Sigma)*mu_prior;
    Sigma_bayesian = (Sigma_prior * inv(Sigma_prior + (1/n)*Sigma)* (1/n) * Sigma) + Sigma;
end