%LinearRegressionDataFormatter - Formatting the data for the LinearRegression 
% Syntax:  LinearRegressionDataFormatter
%
% Inputs:
%    Data - needed Date for the model
%    Matfile - Matfile that includes the data that is analyzed
%
% Other m-files required: GradientDescentOptimizer.m,
% LinearRegressionModel.m
% Subfunctions: none
% MAT-files required: TemperatureMeasurement.mat
%


classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
    %DATAPRERPERATOR Class to model the training data for lineare
    %regression model object
   
    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
            %DATAPRERPERATOR Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin

            for i = 1:nargin
                if strcmp(varargin{i},'Data')
                    obj.data = load(varargin{i+1}).measurement;
                elseif strcmp(varargin{i},'Feature')
                    obj.featureName = varargin{i+1};
                elseif strcmp(varargin{i},'CommandVar')
                    obj.commandVarName = varargin{i+1}; 
                end
            end

     
            
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
           obj.numOfSamples = length(obj.feature); 
        end
    end
end

