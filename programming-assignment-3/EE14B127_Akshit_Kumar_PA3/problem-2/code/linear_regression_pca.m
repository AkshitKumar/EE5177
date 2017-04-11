function [train_rmse, test_rmse,prediction] = linear_regression_pca(train_hog_features,test_hog_features,train_angle, test_angle)
    count = find_num_eigenvalues(train_hog_features');
    pca_train_data = pca(cov(train_hog_features'));
    reduced_train_data = pca_train_data(:,1:count);
    pca_train_hog_features = train_hog_features' * reduced_train_data;
    pca_test_hog_features = test_hog_features' * reduced_train_data;
    phi = pinv(pca_train_hog_features' * pca_train_hog_features) * pca_train_hog_features' * train_angle;
    train_rmse = rms((pca_train_hog_features * phi) - train_angle);
    test_rmse = rms((pca_test_hog_features * phi) - test_angle);
    prediction = pca_test_hog_features * phi;
end

