function Z = projectData(X,U,K)

Z = zeros(size(X,1),K);

U_reduce = U(:,1:K);

m = size(X,1);
for i = 1:m
    Z(i,:) = U_reduce' * X(i,:)';
end

end