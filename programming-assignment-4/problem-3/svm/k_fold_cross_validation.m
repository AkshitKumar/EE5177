function [acc] = k_fold_cross_validation(X_train,y_train,param)
    numFolds = 10;
    indices = crossvalind('Kfold',length(y_train),numFolds);
    %accuracy = zeros(numFolds,1);
    acc = 0;
    for i = 1:numFolds
        train = find(indices ~= i);
        test = find(indices == i);
        model = svmtrain(y_train(train),X_train(train,:),param);
        [pred,a,decv] = svmpredict(y_train(test),X_train(test,:),model,'-q');
        acc = acc + sum(y_train(test) == pred);
    end
    acc = acc / length(y_train);
end

