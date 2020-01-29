function [Tmn, tm_hat, tn_hat] = computeChebMomentMukundan(im)

% Calculates the matrix of Chebyshev moments

% The function computes the matrix of Chebyshev moments (Tmn) for the input
% image (im).

[num_rows,num_cols] = size(im);

% Matrix of Chebyshev polynomials evaluated at x=0:1:num_rows-1. The degree
% (m) of the polynomials is in the range from 0 to num_rows-1

tm_hat = computePolyMatrix(num_rows);

% Matrix of Chebyshev polynomials evaluated at y=0:1:num_cols-1. The degree
% (n) of the polynomials is in the range from 0 to num_cols-1

tn_hat = computePolyMatrix(num_cols);

% Compute the matrix Tmn that contains the moments

% for m=1:1:num_rows
%     for n=1:1:num_cols
%         aux=tm_hat(:,m)'*im;
%         Tmn(m,n)=aux*tn_hat(:,n);                
%     end
% end

Tmn = tm_hat'*im*tn_hat;