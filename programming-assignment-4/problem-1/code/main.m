% Initialization step
clear; clc; close all;

% Generate synthetic data
class_0 = normrnd(-2, 1.5, [100,1]);
class_1 = normrnd(2,1.5,[100 1]);

% Getting the training data
training_data_class_0 = class_0(1:80); 
training_data_class_1 = class_1(1:80);
training_data = [training_data_class_0 ; training_data_class_1];

% Adding the x-intercept term to the training data
training_data = [ones(size(training_data)) , training_data];

% Getting the test data
test_data_class_0 = class_0(81:100);
test_data_class_1 = class_1(81:100);
test_data_class_0 = [ones(size(test_data_class_0)) , test_data_class_0];
test_data_class_1 = [ones(size(test_data_class_1)) , test_data_class_1];

% Adding the label for the test and train data
y_training = [zeros(80,1) ; ones(80,1)];

% Setting the initial value of phi
initial_phi = zeros(size(training_data,2),1);

X = training_data;
w = y_training;

% Finding the optimal point
options = optimset('GradObj','on','Hessian','on','MaxIter',400);
[phi,fval,exitflag,output,grad,hessian] = fminunc(@(phi) cost(phi,X,w),initial_phi, options); 

% Finding the confusion matrix 
[tp,tn,fp,fn] = findConfusionMatrix(phi,test_data_class_0,test_data_class_1);

% Finding the decision boundary point
decision_boundary = -1 * phi(1) / phi(2);

x = -6:0.01:6;
x = x';
X = [ones(size(x)) x];
y = sigmoid(X * phi);

decision_boundary_line = decision_boundary * ones(101,1);
vertical_line = 0:0.01:1;

% Plotting the input data
plot(class_0,zeros(size(class_0)),'rx',class_1,0.05*ones(size(class_0)),'bx',x,y,decision_boundary,0.1,'o',decision_boundary_line,vertical_line,'--');
% scatter(class_0,zeros(size(class_0)));
% scatter(class_0,
legend('Class 0','Class 1','Sigmoid Function','Decision Boundary(Point)','Decision Boundary Line');
 