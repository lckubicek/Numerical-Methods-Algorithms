function I = Simpson(x,y)
% Created by: London Kubicek
% This function numerically evaluates the integral of the vector of function
% values ‘y’ with respect to ‘x’ using Simpson's 1/3 Rule. In the case of
% an odd number of sections (even number of points) the trapezoidal
% approximation method is used for the last section.
%
% Inputs:
%   • x = row vector of independent variables
%   • y = row vector of dependent variables evaluated at each independent
%   value
% Outpus:
%   • I = approximate integral

m = length(x);
n = length(y);
if n ~= m                                       % checks that x and y are the same length
    error('inputs are not the same length')
end

xx = linspace(x(1),x(m),m);                     % checks for equal spacing
test = x == xx;
if sum(test) ~= m
    error('x input is not equally spaced');
end

s = n-1;
w = 0;
if s/2 == round(s/2)                            % checks for even spacing
    for i = 2:n-1
        if i/2 == round(i/2)
            v = 4*y(i);
        else
            v = 2*y(i);
        end
        w = w + v;
    end
    warn = 0;
    I = (x(n) - x(1))/(3*s)*(y(1) + w + y(n));  % computes Simpson's 1/3 rule for even numbered spacing
else
    for i = 2:n-2
        if i/2 == round(i/2)
            v = 4*y(i);
        else
            v = 2*y(i);
        end
        w = w + v;
    end
    warn = 1;
    I = (x(n-1) - x(1))/(3*(s-1))*(y(1) + w + y(n-1)) + (x(n) - x(n-1))*(y(n) + y(n-1))/2; % computes integral using Simpson's 1/3 rule and trapezoidal approximation for the last section
end

fprintf('approximate integral: %f\n',I);        % displays approximate integral

if warn == 1
    warning('off','backtrace');
    warning('trapezoidal method was used on last section due to an odd number of sections'); % warns user that trapezoidal aprroximation was used
end
