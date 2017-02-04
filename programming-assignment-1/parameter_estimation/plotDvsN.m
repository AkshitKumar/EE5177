function plotDvsN(mean_ml,mean_map,mean_bayesian,prior_num)
    figure();
    x = 1:size(mean_ml,1);
    plot(x,mean_ml,x,mean_map);
    xlabel('n Data Points');
    ylabel('Bhattacharya Distance d');
    legend('ML','MAP');
    title(['ML and MAP for Prior ' num2str(prior_num) ' ']);
    
    figure();
    x = 1:size(mean_ml,1);
    plot(x,mean_map,x,mean_bayesian);
    xlabel('n Data Points');
    ylabel('Bhattacharya Distance d');
    legend('MAP','Bayesian');
    title(['MAP and Bayesian for Prior ' num2str(prior_num) ' ']);
end