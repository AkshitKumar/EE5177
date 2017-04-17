function [tp,tn,fp,fn] = findConfusionMatrix(phi,test_data_class_0, test_data_class_1)
    test_class_0 = round(sigmoid(test_data_class_0 * phi));
    tn = size(test_class_0,1) - nnz(test_class_0);
    fp = nnz(test_class_0);
    test_class_1 = round(sigmoid(test_data_class_1 * phi));
    tp = nnz(test_class_1);
    fn = size(test_class_1,1) - nnz(test_class_1);
end

