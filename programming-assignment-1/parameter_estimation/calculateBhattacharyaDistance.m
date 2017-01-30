function d = calculateBhattacharyaDistance(mu,Sigma,mu_estimate,Sigma_estimate)
    Sigma_avg = (Sigma + Sigma_estimate)/2;
    t1 = (mu - mu_estimate)' * inv(Sigma_avg) * (mu - mu_estimate);
    t2 = log(det(Sigma_avg)/sqrt(det(Sigma)*det(Sigma_estimate)));
    d = 1/8 * t1 + 1/2 * t2;
end