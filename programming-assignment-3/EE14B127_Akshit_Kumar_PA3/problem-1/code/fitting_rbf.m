function [pred_error,fitting_error,min_pred_err,min_pred_err_lambda,min_fit_err,min_fit_err_lambda] = fitting_rbf(lambdas,alphas,x,y,z)
    alphas_rbf = alphas;
    [~,num_lambdas] = size(lambdas);
    pred_error = [];
    fitting_error = [];
    for i = 1:num_lambdas
        x_rbf_transform = rbf_transform(x,alphas_rbf,lambdas(i));
        phi_rbf = inv(x_rbf_transform * x_rbf_transform') * x_rbf_transform * z';
        pred_err = rms(phi_rbf' * x_rbf_transform - y);
        pred_error = [pred_error;pred_err];
        fit_err = rms(phi_rbf' * x_rbf_transform - z);
        fitting_error = [fitting_error;fit_err];
    end
    [min_pred_err, index]  = min(pred_error);
    min_pred_err_lambda = lambdas(index);
    [min_fit_err, index] = min(fitting_error);
    min_fit_err_lambda = lambdas(index);
    plot(lambdas,pred_error);
    xlabel('Lambda value');
    ylabel('Prediction Error');
    title('Prediction Error vs Lambda Value');
    print -dpng plots/pred_error_vs_lambda_rbf_1.png
    plot(lambdas,fitting_error);
    xlabel('Lambda value');
    ylabel('Fitting Error');
    title('Fitting Error vs Lambda Value');
    print -dpng plots/fit_error_vs_lambda_rbf_1.png
end