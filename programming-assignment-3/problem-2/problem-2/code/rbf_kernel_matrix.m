% The code for kernel matrix is taken from the following stack overflow
% link : http://stackoverflow.com/questions/17690132/what-is-the-algorithm-for-an-rbf-kernel-matrix-in-matlab
function K = rbf_kernel_matrix(X,X2,lambda)
    n1sq = sum(X.^2,1);
    n1 = size(X,2);
    if isempty(X2)
        D = (ones(n1,1)*n1sq)' + ones(n1,1)*n1sq -2*X'*X;
    else
        n2sq = sum(X2.^2,1);
        n2 = size(X2,2);
        D = (ones(n2,1)*n1sq)' + ones(n1,1)*n2sq -2*X'*X2;
    end
    K = exp(-D/(2*lambda^2));
end