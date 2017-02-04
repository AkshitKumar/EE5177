function [d_ml,d_map,d_bayesian] = compute(X,mu_prior,Sigma_prior,Sigma,mu)
    d_ml = [];
    d_map = [];
    d_bayesian = [];
    for i = 2:size(X,1)
        fprintf('Computing Bhattacharya Distance for n = %d\n',i); 
        data_sub = X(1:i,:);
        [mu_ml,Sigma_ml] = MLEstimate(data_sub,Sigma);
        [mu_map,Sigma_map] = MAPEstimate(data_sub,mu_prior,Sigma_prior,Sigma);
        [mu_bayesian,Sigma_bayesian] = BayesianEstimate(data_sub,mu_prior,Sigma_prior,Sigma);
        d_ml = [d_ml; calculateBhattacharyaDistance(mu,Sigma,mu_ml,Sigma_ml)];
        d_map = [d_map; calculateBhattacharyaDistance(mu,Sigma,mu_map,Sigma_map)];
        d_bayesian = [d_bayesian;calculateBhattacharyaDistance(mu,Sigma,mu_bayesian,Sigma_bayesian)];
    end
end