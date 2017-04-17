function prediction = indicatorFunction(X_test,X,optimal_x,y,lambda)
    prediction = kernelfunction(X_test',X',lambda) * (optimal_x .* y);
end

