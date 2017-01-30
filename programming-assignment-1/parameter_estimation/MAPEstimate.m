function [mu_map,Sigma_map] = MAPEstimate(data,mu_prior,Sigma_prior,Sigma)
    n = size(data,1);
    mu_map = (n*inv(Sigma) + inv(Sigma_prior)) * (sum(inv(Sigma)*data',2) + inv(Sigma_prior) * mu_prior);
    Sigma_map = Sigma;
end