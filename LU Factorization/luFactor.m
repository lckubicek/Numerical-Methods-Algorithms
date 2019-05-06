function [L,U,P] = luFactor(A)
% This function uses LU factorization with partial pivoting to output the
% lower triangular matrix, upper triangular matrix and pivot matrix for a
% given matrix
% Inputs:
% • A - coefficient matrix
% Outputs:
% • L - lower triangular matrix
% • U - upper triangular matrix
% • P - the pivot matrix

[m,n] = size(A);
if m ~= n                                           % checks if A is a square matrix
    error('a square matrix must be entered');
elseif n == 1
    error('a non-scalar square matrix must be entered');    % checks if A is not a scalar
end

L = eye(n);                                         % establishes matricies
U = A;
P = eye(n);

for i = 1:n-1
        [Umax,row] = max(abs(U(i:n,i)));            % determines maximum coefficient in a given column and switches that row with the top row
        row = row+i-1;                              % adjusts the row relative to the number of iterations
        L([i,row],1:i-1) = L([row,i],1:i-1);
        U([i,row],i:n) = U([row,i],i:n);
        P([i,row],:) = P([row,i],:);
    for j = i+1:n
        L(j,i) = U(j,i)/U(i,i);                     % determines elimination factor
        U(j,i:n) = U(j,i:n) - L(j,i)*U(i,i:n);      % subtracts the previous row from the current one
    end
    
end

