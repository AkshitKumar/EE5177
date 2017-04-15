function [bestC,bestSigma,bestcv] = parameterSelection(X_train,y_train,numFolds,kernel_type)
    bestC = 0;
    bestSigma = 0;
    bestcv = 0;
    % Parameter Selection for Linear Kernel
    if kernel_type == 0
        C = logspace(-10,1,10);
        for c = 1:length(C)
            param = ['-s ', num2str(0), ' -t ', num2str(kernel_type) , ' -c ', num2str(C(c)),' -v ', num2str(numFolds)];
            cv_acc = svmtrain(y_train,X_train,param);
            if(cv_acc >= bestcv)
                bestcv = cv_acc;
                bestC = C(c);
            end
        end
    end
    
    % Parameter Selection for RBF Kernel
    if kernel_type == 2
        C = logspace(-10,1,10);
        Sigma = logspace(-10,1,10);
        bestcv = 0;
        for c = 1:length(C)
            for s = 1:length(Sigma)
                param = ['-s ', num2str(0), ' -t ', num2str(kernel_type) , ' -c ', num2str(C(c)),' -g ', num2str(Sigma(s)), ' -v ', num2str(numFolds)];
                cv_acc = svmtrain(y_train,X_train,param);
                if(cv_acc >= bestcv)
                    bestcv = cv_acc;
                    bestC = C(c);
                    bestSigma = Sigma(s);
                end
            end
        end
    end
    
end

