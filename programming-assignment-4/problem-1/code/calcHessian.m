function hess = calcHessian(phi,X,w)
    m = length(w);
    hess = zeros(size(phi,1),size(phi,1));
    sig = sigmoid(X * phi) .* (1 - sigmoid(X * phi));
    for i = 1:m
        hess = hess + (sig(i) * X(i,:) * X(i,:)');
    end
    hess = hess / m;
end
    