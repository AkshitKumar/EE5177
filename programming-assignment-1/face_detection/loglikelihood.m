function val = loglikelihood(x,mu,Sigma)
    num = exp((-1/2) * (x - mu) * inv(Sigma) * (x - mu)');
    den = sqrt(abs(det(2*pi*Sigma)));
    val = log(num/den);
    %disp(val);
end