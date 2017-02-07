# Machine Learning for Computer Vision : EE5177
## Problem 1 - parameter_estimation
This folder contains the MATLAB scripts for solving the first problem of the programming assignment. The MATLAB files included are:
+ estimate_parameter : The main file which needs to be run for all the calculations and plot generations
+ compute : Computes the distance of ML,MAP and Bayesian Estimates from the ground truth values
+ MLEstimate : Helper function for calculating the ML estimate of data
+ MAPEstimate : Helper function for calculating the MAP estimate of data
+ BayesianEstimate : Helper function for calculating the Bayesian estimate of data
+ calculateBhattacharyaDistance : Helper function for calculating the bhattacharya distance
+ plotDvsN : Helper function to plot the d vs. n graphs for ML,MAP,Bayesian estimate distances from the ground truth values for prior-1 and prior-2

## Usage 
For running the required script for problem 1, do the following in the MATLAB command window :
```sh
>> cd <path to folder>/ee14b127-pa1/parameter_estimation/
>> run estimate_parameter.m
```

## Problem 2 - face_detection
This folder contains the MATLAB scripts for solving the second problem of the programming assignment. The MATLAB files included are:
+ main : The main file which needs to be run for all calculations and plot generations
+ evaluate : Helper function to evaluate the learnt model on the test data set
+ learnMLParameters : Helper function to learn the Maximum Likelihood parameters of the training data
+ pca : Helper function to do SVD on the covariance matrix and get the matrix of eigen vectors
+ projectData : Helper function to project the data to lower dimension for dimensionality reduction
+ loglikehood : Helper function to return the loglikehood value of a vector x
+ plotClassificationAccuracy : Helper function to plot the classification accuracy
+ plotLikelihood : Helper function to plot the likelihood scores for the training data
+ plotROC : Helper function to plot the ROC curve for face and non face models

## Usage 
For running the required script for problem 1, do the following in the MATLAB command window :
```sh
>> cd <path to folder>/ee14b127-pa1/face_detection/
>> run main.m
```