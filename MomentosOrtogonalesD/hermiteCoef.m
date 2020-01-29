function [diag, cmtx]=hermiteCoef(im)
% hermiteCoef - 2-D discrete Hermite coefficients sized to the image size
% Wrapper to MATLAB for hermiteCoef.c
%
% The decomposition takes place by first creating squared filters of the
% same size as the input image. The maximun degree of the derivative is 
% given by the máximun size of the input image.
% 
% Synopsis:
% diag = hermiteCoef(im)
% diag = hermiteCoef(im, option)
% [diag, cmtx] = hermiteCoef(im)
%
% Inputs:
% im - input image of Class double
% option - 1 for verbose mode on
%
% Outputs:
% diag - a vector representing the sum of all coefficients of the same
%        derivative degree
% cmtx - a matrix representing the coefficients of all decomposition
%
% This function was written in C
% Compilation line: 
% mex ('CFLAGS="\$CFLAGS -std=c99"', 'hermiteCoef.c', 'statistics.c', 
%      'krawtchouk.c', 'binomials.c', 'matrixoper.c')
%
% Author: Alfonso Estudillo Romero <alfonsoer at gmail.com>
% History:
% Last version April 14th 2015.