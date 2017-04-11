function alphas = get_alphas(num_kernel_functions)
    step = (4 + 3) / (2 * num_kernel_functions + 1);
    generate_alpha_samples = -3:step:4;
    alphas = generate_alpha_samples(2:2:length(generate_alpha_samples) - 1); % Sampling alphas from uniform intervals
end

