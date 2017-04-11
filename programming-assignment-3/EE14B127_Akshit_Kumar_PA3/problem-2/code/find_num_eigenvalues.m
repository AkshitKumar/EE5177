function [count] = find_num_eigenvalues(train_hog_features)
    eigen_values = eig(cov(train_hog_features));
    eigen_values = sort(eigen_values,'descend');
    summation_eigen_values = sum(eigen_values);
    count = 0;
    for i = 1:size(eigen_values,1)
        count = count + 1;
        if (sum(eigen_values(1:i)) / summation_eigen_values >= 0.9)
            break;
        end
    end
    eigen_value_sum = cumsum(eigen_values);
    plot(1:length(eigen_values),eigen_value_sum/summation_eigen_values,count,eigen_value_sum(count)/summation_eigen_values,'-o');
    xlabel('Number of Eigen values');
    ylabel('Percentage of Eigenvalues');
    title('Number of eigenvalues vs Percentage of Eigenvalues');
    hold on;
    plot(1:length(eigen_values),0.9*ones(1,length(eigen_values)),'--');
    hold on;
    plot(count*ones(1,length([0:1])),0:1,'--');
    labelstr = sprintf('(%.2f,%.2f)', count, 0.9);
    text(count,0.9,labelstr);
    print -dpng eigenvalue.png
end

