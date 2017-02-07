function plotConfusionMatrix(X)
    tps = X(:,1)';
    fns = X(:,2)';
    fps = X(:,3)';
    tns = X(:,4)';
    points = [1:size(X,1)];
    plot(points,tps,'color','r');
    hold on;
    plot(points,fps,'color','b');
    hold on;
    plot(points,fns,'color','g');
    hold on;
    plot(points,tns,'color','k');
end