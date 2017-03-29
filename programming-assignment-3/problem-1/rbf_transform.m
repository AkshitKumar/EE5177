function Z = rbf_transform(x,alphas,lambda)
    X = repmat(x,length(alphas),1);
    alpha_mat = repmat(alphas',size(x,1),size(x,2));
    X_transform = exp(-1 * (X - alpha_mat) .^2 / lambda); 
    Z = X_transform;
end

