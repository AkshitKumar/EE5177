function plotClassificationAccuracy(confusion_matrix)
    tp = confusion_matrix(:,1);
    fn = confusion_matrix(:,2);
    fp = confusion_matrix(:,3);
    tn = confusion_matrix(:,4);
    %precision = tp ./ (tp + fp);
    %recall = tp ./ (tp + fn);
    %f1_score = 2 * (precision .* recall) ./ (precision + recall);
    f1_score = (tp + tn) ./ (tp + tn + fn + fp);
    points = [1:size(confusion_matrix,1)];
    plot(points,f1_score,'color','r');
end