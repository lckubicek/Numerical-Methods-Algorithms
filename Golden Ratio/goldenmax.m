function [x_max,fx,ea,iter] = goldenmax(func,xl,xu,es,maxiter)
% This function uses the golden section approximation method to approximate
% the maximum of a function. The function must be entered as:
%                   func = @(variable) function of variable
%   Inputs:
%       func - the function being evaluated
%       xl - the lower guess
%       xu - the upper guess
%       es - the desired relative error (should default to 0.0001%)
%       maxiter - the number of iterations desired (should default to 200)
%   Outputs:
%       x_max - the estimated root location
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
phi = (1 + sqrt(5))/2
while(1)
    d = (phi - 1)*(xu - xl)
    x1 = xl + d
    x2 = xu - d
    iter = iter + 1
    if feval(func,x1) > feval(func,x2)
        x_max = x1;
        xl = x2;
    elseif feval(func,x1) < feval(func,x2)
        x_max = x2;
        xu = x1;
    end
    ea = (2 - phi)*abs((xu-xl)/x_max)*100;
    if ea < es || iter >= maxiter
        break
    end
end
fx = feval(func,x_max);
fprintf('Maximum approximation: %d\nFunction value at approximation: %d\nRelative approximate error: %d\nNumber of iterations: %d\n',x_max,fx,ea,iter);
end

