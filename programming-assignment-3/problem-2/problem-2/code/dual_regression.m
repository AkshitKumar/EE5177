function [ train_rmse, test_rmse,prediction] = dual_regression( train_hog_features,test_hog_features,train_angle, test_angle)
    phi = train_hog_features * pinv(train_hog_features' * train_hog_features) * train_angle;
    train_estimate = train_hog_features' * phi;
    test_estimate = test_hog_features' * phi;
    train_rmse = rms(train_estimate - train_angle);
    test_rmse = rms(test_estimate - test_angle);
    prediction = test_estimate;
end

