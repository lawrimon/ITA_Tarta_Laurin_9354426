%% runScript: 
% runs the linear regression model and visulaize the reults
%
% See also: LinearRegressionDataFormatter, LinearRegressionModel, GradientDescentOptimizer,
% Author: Jannik Wiessler
% DHBW Stuttgart
% email: jannik.wiessler@daimler.com
% data: Q1 2021

%runScript - Running the Linear Regression Function 
% Syntax:  runScript
%
% Inputs:
%    LearningRate - to be analyzed function 
%    MaxIterations - start value for analyzation process
%    matfile- maximum ammount of iterations 

% Outputs:
%    The current costs for the theta and the elapsed time
%    Also graphs to show the LinearRegressionModel are shown
%
% Example: 
%    runScript
%    >>current costs for theta = [9;1]: 3673.2168, expected: 3673.2168
%    >>current costs for theta = [0;0]: 79994.0539, expected: 79994.0539
%    >>Elapsed time is 2.227704 seconds.
%
% Other m-files required: GradientDescentOptimizer.m,
% LinearRegressionDataFormatter.m, LinearRegressionModel.m
% Subfunctions: none
% MAT-files required: TemperatureMeasurement.mat
%

% Author: Patrick Laurin Tarta
% email: tarta.laurin@arcor.de
% April 2022; Last revision: 12-April-2022


%% mandatory
clear; clc; close all;

%% create data object for linear regression model
dataForLinearRegression = LinearRegressionDataFormatter('Data','TempearatureMeasurement.mat',...
    'Feature','T3','CommandVar','T4');

%% create optimizer object
gradientDescentOptimizer = GradientDescentOptimizer('LearningRate',9e-6,'MaxIterations',1.05e7);

%% create lineaer regression model object
LRMObject = LinearRegressionModel('Data',dataForLinearRegression,'Optimizer',gradientDescentOptimizer);

%% test cost function
LRMObject.setTheta(9,1)
cost = LRMObject.costFunction();
disp("current costs for theta = " + "[" + num2str(LRMObject.theta(1)) + ";" + num2str(LRMObject.theta(2)) + "]" +...
    ": " + num2str(cost) + ", expected: 3673.2168");

LRMObject.setTheta(0,0)
cost = LRMObject.costFunction();
disp("current costs for theta = " + "[" + num2str(LRMObject.theta(1)) + ";" + num2str(LRMObject.theta(2)) + "]" +...
    ": " + num2str(cost) + ", expected: 79994.0539");

%% show cost function area
costFunctionFigure = LRMObject.showCostFunctionArea();

%% perform the training
tic
LRMObject.optimizer.runTraining(LRMObject);
toc

%% show the resulting model
lrmFigure = LRMObject.showModel();

%% sho optimum in contour plot
optimumFigure = LRMObject.showOptimumInContour();

