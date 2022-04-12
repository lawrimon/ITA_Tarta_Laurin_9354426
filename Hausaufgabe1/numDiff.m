%% Function checking what type of differentiation shall be used
%% Formula for derivation implemented

function diff = numDiff(func, x, diffway)

%%Exercise 1 
if diffway == "Forward"
    h = 10^-8;
    diff = (func(x)-func(x-h))/h;

%%Exercise 2
elseif diffway == "Backward"
    h = 10^-8;
    diff = (func(x)-func(x-h))/(2*h);

elseif diffway  == "Central"
    h = 10^-6;
    diff = (func(x+h)-func(x-h))/(2*h);

end
end


%numDiff - Numerical differentiation of my function
% Syntax:  numDiff(functionname, variable, differentiationWay)
%
% Inputs:
%    func - to be analyzed function 
%    x - variable that is used
%    diffway - prefered way of differentiation 

% Outputs:
%    diff - differentiation of function 
%
%
% Other m-files required: myFunc.m, dMyFunc.m, myNewton.m
% Subfunctions: none
% MAT-files required: none
%

% Author: Patrick Laurin Tarta
% email: tarta.laurin@arcor.de
% April 2022; Last revision: 4-April-2022
