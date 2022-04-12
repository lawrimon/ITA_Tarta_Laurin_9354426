%% Function to test and run the functionalities of the differtiation-tool
function runMyNewton

myNewton( ...
    "function", @MyFunc, ...
    "startValue", 0, ...
    "maxIter", 50, ...
    "feps", 1e-6, ...
    "xeps", 1e-6, ...
    "livePlot", 'off');
end 


%runMyNewton - Running the MyNewton Function 
% Syntax:  runMyNewton
%
% Inputs:
%    function - to be analyzed function 
%    startValue - start value for analyzation process
%    maxIter - maximum ammount of iterations 
%    feps - value to describe accuracy
%    xeps - value to describe accuracy
%    livePlot - if the live plot should be shown

% Outputs:
%    xOld - zero value of the function derivate
%
% Example: 
%    runMyNewton
%    >> "Using this differntiation: " "Backward"
%    >> 3.0000
%
% Other m-files required: myFunc.m, dMyFunc.m, myNewton.m
% Subfunctions: none
% MAT-files required: none
%

% Author: Patrick Laurin Tarta
% email: tarta.laurin@arcor.de
% April 2022; Last revision: 4-April-2022
