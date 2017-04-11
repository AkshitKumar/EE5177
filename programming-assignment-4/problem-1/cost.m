function [J, grad, hess] = cost(phi,X,w)
    m = length(w);
    
    J = 0; % Initial value of the 
    grad = zeros(size(phi));
    hess = zeros(size(phi,1),size(phi,1));
    
    J = -1/m * (w' * log(sigmoid(X * phi)) + (1 - w)' * log(1 - sigmoid(X * phi)));
    grad = 1/m * ((sigmoid(X * phi) - w)' * X);
    hess = calcHessian(phi,X,w);
end

