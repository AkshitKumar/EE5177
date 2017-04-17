% Initialization step
clear; clc; close all;

% Loading the data from the data set
data = load('../data/Q1_log_regression/DS2.mat');
X = data.DS2(:,:);

y = X(:,3);
pos_indices = find(y == 1);
neg_indices = find(y == -1);
x_pos = X(pos_indices,1:2);
x_neg = X(neg_indices,1:2);
X = X(:,1:2);


[m,n] = size(X);

q = -1 * ones(m,1);
h = zeros(m,1);
G = -1 * eye(m);
G = [G ; eye(m)];

C = 10.^(0:5);
lambda = 10;
for k = 1:length(C)
    P = (y * y') .* kernelfunction(X',X',lambda);
    %h = zeros(m,1);
    h = [zeros(m,1) ; C(k) * ones(m,1)];
    cvx_begin
        variable x(m)
        minimize(1/2*x'*P*x + q'*x)
        subject to 
            G*x <= h
    cvx_end

    threshold = x > 1.0000e-05;
    optimal_x = threshold .* x;
    prediction = indicatorFunction(X,X,optimal_x,y,lambda); 
    %num_alpha = [num_alpha ; nnz(optimal_x)];
    %optimal_alpha = [optimal_alpha , optimal_x];
    x_axis = linspace(-5,8);
    y_axis = linspace(-5,8);
    [X_axis Y_axis] = meshgrid(x_axis,y_axis);
    Z = zeros(size(X_axis));
    for i = 1:length(X_axis)
        for j = 1:length(Y_axis)
            Z(i,j) = indicatorFunction([X_axis(i,j) Y_axis(i,j)],X,optimal_x,y,lambda);
        end
    end
    figure
    plot(x_pos(:,1),x_pos(:,2),'x',x_neg(:,1),x_neg(:,2),'o');
    hold on;    
    contour(X_axis,Y_axis,Z,[-1,0,1]);
    title(strcat('Contour Plot for \lambda = 10 and C = ', num2str(C(k))));
    saveas(gcf,strcat(strcat('plot_C_',num2str(C(k))),'.png'));
end