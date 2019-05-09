function [x_min,fx,ea,iter] = goldenmin(func,xl,xu,es,maxiter)
% This function uses the golden section approximation method to approximate
% the minimum of a function. The function must be entered as:
%                   func = @(variable) function of variable
%   Inputs:
%       func - the function being evaluated
%       xl - the lower guess
%       xu - the upper guess
%       es - the desired relative error (should default to 0.0001%)
%       maxiter - the number of iterations desired (should default to 200)
%   Outputs:
%       x_min - the estimated min location
%       fx - the function evaluated at the root location
%       ea - the approximate relative error (%)
%       iter - how many iterations were performed

if nargin < 3
    error('at least 3 input arguments required');
end
if nargin < 4 || isempty(es)
    es = 0.0001;
end
if nargin < 5 || isempty(maxiter)
    maxiter = 200;
end

iter = 0;
ea = 100;
phi = (1 + sqrt(5))/2;
while(1)
    d = (phi - 1)*(xu - xl);
    x1 = xl + d;
    x2 = xu - d;
    iter = iter + 1;
    if feval(func,x1) < feval(func,x2)
        x_min = x1;
        xl = x2;
    elseif feval(func,x1) > feval(func,x2)
        x_min = x2;
        xu = x1;
    end
    ea = (2 - phi)*abs((xu-xl)/x_min)*100;
    if ea < es || iter >= maxiter
        break
    end
end
fx = feval(func,x_min);
fprintf('Minimum approximation: %d\nFunction value at approximation: %d\nRelative approximate error: %d\nNumber of iterations: %d\n',x_min,fx,ea,iter);
end

