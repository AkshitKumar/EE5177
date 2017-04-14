function [bestC,bestSigma,bestcv] = parameterSelection(X_train,y_train)
    C = 2.^(-5:5);
    sigma = 2.^(-5:5);
    bestcv = 0;
    for c = 1:length(C)
        for s = 1:length(sigma)
            param = ['-s ', num2str(0), '-t ', num2str(2) , '-c ', num2str(C(c)),' -g ', num2str(sigma(s))];
            cv_acc = k_fold_cross_validation(X_train,y_train,param);
            if(cv_acc >= bestcv)
                bestcv = cv_acc;
                bestC = C(c);
                bestSigma = sigma(s);
            end
        end
    end
end

