function [d_ml,d_map,d_bayesian] = compute(X,mu_prior,Sigma_prior,Sigma,mu)
    d_ml = [];
    d_map = [];
    d_bayesian = [];
    % Iterating the value of n from 2 to 500
    for i = 2:size(X,1)
        fprintf('Computing Bhattacharya Distance for n = %d\n',i); 
        data_sub = X(1:i,:);
        % Calculating the ML,MAP and Bayesian parameters
        [mu_ml,Sigma_ml] = MLEstimate(data_sub,Sigma);
        [mu_map,Sigma_map] = MAPEstimate(data_sub,mu_prior,Sigma_prior,Sigma);
        [mu_bayesian,Sigma_bayesian] = BayesianEstimate(data_sub,mu_prior,Sigma_prior,Sigma);
        % Appending the values of ML, MAP and Bayesian Estimates
        d_ml = [d_ml; calculateBhattacharyaDistance(mu,Sigma,mu_ml,Sigma_ml)];
        d_map = [d_map; calculateBhattacharyaDistance(mu,Sigma,mu_map,Sigma_map)];
        d_bayesian = [d_bayesian;calculateBhattacharyaDistance(mu,Sigma,mu_bayesian,Sigma_bayesian)];
    end
end