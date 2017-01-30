function [x,y] = evaluate(mu_face,sigma_face,mu_non_face,sigma_non_face,test_data)
    result = [];
    for i = 1:size(test_data,1)
        t = test_data(i,:);
        prob_face = loglikelihood(t,mu_face,sigma_face);
        prob_non_face = loglikelihood(t,mu_non_face,sigma_non_face);
        result = [result; prob_face > prob_non_face];
    end
    x = sum(result);
    y = size(test_data,1) - x;
end
        