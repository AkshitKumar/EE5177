function K = kernelfunction(X1,X2,alpha)
    n1sq = sum(X1.^2,1);
    n1 = size(X1,2);
    if isempty(X2)
        D = (ones(n1,1)*n1sq)' + ones(n1,1)*n1sq -2*(X1'*X1);
    else
        n2sq = sum(X2.^2,1);
        n2 = size(X2,2);
        D = (ones(n2,1)*n1sq)' + ones(n1,1)*n2sq -2*X1'*X2;
    end
    K = exp(-D/(2*alpha^2));
end

