function [train_rmse, test_rmse,prediction] = dual_regression_kernel(train_hog_features,test_hog_features,train_angle, test_angle)
    pairwise_distance = pdist(train_hog_features');
    lambda_1 = min(pairwise_distance);
    lambda_2 = max(pairwise_distance);
    lambda_3 = (lambda_1 + lambda_2)/2;
    lambdas = [lambda_1 lambda_2 lambda_3];
    test_rmse = [];
    train_rmse = [];
    prediction = [];
    for i = 1:length(lambdas)
        H = rbf_kernel_matrix(train_hog_features,train_hog_features,lambdas(i));
        K = rbf_kernel_matrix(train_hog_features,test_hog_features,lambdas(i));
        pred = K' * pinv(H) * train_angle ;
        prediction = [prediction; pred];
        test_rmse = [test_rmse, rms(pred - test_angle)];
        pred = H' * pinv(H) * train_angle;
        train_rmse = [train_rmse, rms(pred - train_angle)];
    end
end