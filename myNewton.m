function [xZero, abortFlag, iters] = myNewton(varargin)
%% do the varargin
for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};   
    end
end

%% check for necessary parameters
if ~exist('func','var')
    error('No valid function');
end

%% Checking for derivative method 

if ~exist('dfunc','var')
    diffway = questdlg(...
        'Which Method shall be used?','Select Method of Differentiation', ...
        'Forward' , 'Central', 'Backward', 'Forward');
        if isempty(diffway) %%Exercise 1 // Checking if no differntiation is selected
            disp("No method of Differentiation has been selected. Deliver a derrivative or choose a differentiation method.");
            return;
        end
        derivateAvailable = false;
        disp( ["Using this way of differentiation: ", diffway]);
else
    derivateAvailable = true;
    disp(["Use of given derivative ", func2str(dfunc)]);
end

%%

if ~exist('x0','var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ',num2str(x0)]);
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

%% start of algorithm
if strcmp(livePlot,'on')
   h = figure('Name','Newton visualization');
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
end
xOld = x0;
abortFlag = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if f < feps
        abortFlag = 'feps';
        break;
    end

%% Checking if derivate is given
%% Running the NummDiff function with the method selected if not
    if derivateAvailable
        df = dfunc(xOld);
    else
        df = numDiff(func, xOld, diffway);
    end 
    if df == 0
        abortFlag = 'df = 0';
        break;
    end

    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
disp(xZero);
end

%myNewton - function running the Newton-Raphson algorithm
% Syntax:  myNewton(function parameters)
%
% Inputs:
%    function - to be analyzed function 
%    startValue - start value for analyzation process
%    maxIter - maximum ammount of iterations 
%    feps - value to describe accuracy
%    xeps - value to describe accuracy
%    livePlot - if the live plot should be shown

% Outputs:
%    xZero - the zero value of the derivation of the given function
%
% Example: 
%    myNewton
%    >> "Using this differntiation: " "Backward"
%    >> 3.0000
%
% Other m-files required: myFunc.m, dMyFunc.m
% Subfunctions: none
% MAT-files required: none
%

% Author: Patrick Laurin Tarta
% email: tarta.laurin@arcor.de
% April 2022; Last revision: 4-April-2022
