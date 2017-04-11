function min_num_kernel = fitting_kernel(lambda,x,y,z)
    pred_error = [];
    for i = 2:2:50
        alphas_rbf = get_alphas(i);
        x_rbf_transform = rbf_transform(x,alphas_rbf,lambda);
        phi_rbf = pinv(x_rbf_transform * x_rbf_transform') * x_rbf_transform * z';
        pred_err = rms(phi_rbf' * x_rbf_transform - y);
        pred_error = [pred_error;pred_err];
    end
    num_kernel = 2:2:50;
    plot(num_kernel, pred_error);
    xlabel('No. of Kernels');
    ylabel('Prediction Error');
    title('Prediction Error vs Number of Kernels');
    print -dpng plots/pred_error_vs_num_kernels.png
    [~, index] = min(pred_error);
    min_num_kernel = num_kernel(index);
end