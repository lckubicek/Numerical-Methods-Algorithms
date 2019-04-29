function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
% This function uses the false position approximation method to approximate
% the zero of a function. The function must be entered as:
%                   func = @(variable) function of variable
%   Inputs:
%       func - the function being evaluated
%       xl - the lower guess
%       xu - the upper guess
%       es - the desired relative error (should default to 0.0001%)
%       maxiter - the number of iterations desired (should default to 200)
%   Outputs:
%       root - the estimated root location
%       fx - the function evaluated at the root location
%       ea - the approximate relative error (%)
%       iter - how many iterations were performed

test = feval(func,xl)*feval(func,xu);
if nargin < 3
    error('at least 3 input arguments required');
end
if nargin < 4 || isempty(es)
    es = 0.0001;
end
if nargin < 5 || isempty(maxiter)
    maxiter = 200;
end
if test > 0
    error('no sign change');
end
iter = 0;
ea = 100;
xr = 0;
while(1)
    xrold = xr;
    xr = xu - (feval(func,xu)*(xl-xu))/(feval(func,xl) - feval(func,xu));
    iter = iter + 1;
    if feval(func,xr) == 0
        break
    elseif feval(func,xr)*feval(func,xu) < 0
        xl = xr;
    elseif feval(func,xr)*feval(func,xl) < 0
        xu = xr;
    end
    ea = abs((xr-xrold)/xr)*100;
    if ea < es || iter >= maxiter
        break
    end
end
root = xr;
fx = feval(func,xr);
fprintf('Root approximation: %d\nFunction value at approximation: %d\nRelative approximate error: %d\nNumber of iterations: %d\n',root,fx,ea,iter);
end

