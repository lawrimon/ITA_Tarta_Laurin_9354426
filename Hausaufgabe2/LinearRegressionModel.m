%LinearRegressionModel - Creating the model for the LinearRegression 
% Syntax:  LinearRegressionModel
%
% Inputs:
%    Data - needed Date for the model
%    Optimizer - GradienDescentOptimizer instance
% Outputs:
%    The attributes of the LinearRegessionModel are being printed out
%
% Example: 
%     LinearRegrssionModel
%     LinearRegressionModel with properties:
%
%       optimizer: []
%    trainingData: []
%           theta: [2×1 double]
%    thetaOptimum: []
%
% Other m-files required: GradientDescentOptimizer.m,
% LinearRegressionDataFormatter.m
% Subfunctions: none
% MAT-files required: none
%



classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            
            for i = 1:nargin
                if strcmp(varargin{i},'Data')
                    obj.trainingData= varargin{i+1};
                elseif strcmp(varargin{i},'Optimizer')
                    obj.optimizer= varargin{i+1};
                end
            end

            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            % compute the costs
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J
            J = (1/(2*m))* sum((obj.hypothesis() - obj.trainingData.commandVar).^2);
        end

        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code
            
            %multiply X with theta due to matrix dimensions -> theta * X
            %does not work
            hValue = X * obj.theta;

        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the contour command
            % add x and y label
            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            
            %Initializing a costsmatrix filled with zeros
            costsmatrix = zeros(length(theta0_vals), length(theta1_vals));
            
            for i = 1:length(theta0_vals)
                for k = 1:length(theta1_vals)
                    obj.setTheta(theta0_vals(i), theta1_vals(k));
                    costsmatrix(i,k) = obj.costFunction;
                end
            end
            
            %Transposing the costsmatrix is needed to make the axes in the correct
            %way
            costsmatrix = costsmatrix';
            %Creating the contour plot
            contour(theta0_vals, theta1_vals, costsmatrix)
            xlabel('theta0'); ylabel('theta1');
            hold on;
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);

        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the surf command
            % add x and y label
            
            %Initializing a costsmatrix filled with zeros
            costsmatrix = zeros(length(theta0_vals), length(theta1_vals));

            %Adding values to J_vals
            for i = 1:length(theta0_vals)
                for k = 1:length(theta1_vals)
                    obj.setTheta(theta0_vals(i), theta1_vals(k));
                    costsmatrix(i,k) = obj.costFunction;
                end
            end
            
            %Transposing costsmatrix is needed to make the axes in the correct
            %way
            costsmatrix = costsmatrix';
            surf(theta0_vals, theta1_vals, costsmatrix)
            xlabel('theta0'); ylabel('theta1')
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           % add the final trained model plot to the figure ('b-')
           % update the legend

           hold on;
           obj.setTheta(obj.thetaOptimum(1), obj.thetaOptimum(2))
           %adding final plot to b-
           plot(obj.trainingData.feature, obj.hypothesis(), 'b-');
           %updating the legend
           legend('Training-data', 'Linear regression');
           hold off;
           
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end


