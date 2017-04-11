function [pred_error,fitting_error,min_pred_err,min_pred_err_lambda,min_fit_err,min_fit_err_lambda] = fitting_arctan(lambdas,alphas,x,y,z)
    alphas_arctan = alphas;
    [~,num_lambdas] = size(lambdas);
    pred_error = [];
    fitting_error = [];
    for i = 1:num_lambdas
        x_arctan_transform = arctan_transform(x,alphas_arctan,lambdas(i));
        phi_arctan = inv(x_arctan_transform * x_arctan_transform') * x_arctan_transform * z';
        pred_err = rms(phi_arctan' * x_arctan_transform - y);
        pred_error = [pred_error; pred_err];
        fit_err = rms(phi_arctan' * x_arctan_transform - z);
        fitting_error = [fitting_error; fit_err];
    end
    [min_pred_err, index]  = min(pred_error);
    min_pred_err_lambda = lambdas(index);
    [min_fit_err, index] = min(fitting_error);
    min_fit_err_lambda = lambdas(index);
    plot(lambdas,pred_error);
    xlabel('Lambda value');
    ylabel('Prediction Error');
    title('Prediction Error vs Lambda Value');
    print -dpng plots/pred_error_vs_lambda_arctan.png
    plot(lambdas,fitting_error);
    xlabel('Lambda value');
    ylabel('Fitting Error');
    title('Fitting Error vs Lambda Value');
    print -dpng plots/fit_error_vs_lambda_arctan.png
end