% theil_sen()
% This function computes the Theil-Sen regression coefficients
% for a linear model of type y ~ 1 + x 
%
% INPUT: 
%
% x,y: two 1D column vectors the first is the predictor, the second is the outcome
%
%
% OUTPUT:
%
% b_ts: a two-element vector with the regression coefficients
%       b_ts(1): intercept
%       b_ts(2): slope
%
% resid: residuals (y_observed - y_predicted)
%
%
%
% code written by Germano Gallicchio, germano.gallicchio@gmail.com

function [b_ts, resid] = theil_sen(x,y)

% sanity check: column vectors of the same length
if numel(x)==1  ||  numel(y)==1  ||  numel(x)~=length(x)  ||  numel(y)~=length(y)
    error('enter two vectors')
end
if diff(size(x))>0  ||  diff(size(x))>0
    error('vectors should be *column* vectors')
end
if length(x)~=length(y)
    error('vectors should have same length')
end


n = length(x);  % vector length

% create all possible combinations without repetition ("n choose 2")
comb = nchoosek(1:n,2);

% create difference pairs
deltay=diff(y(comb),1,2);
deltax=diff(x(comb),1,2);

% compute slopes
slopes = deltay ./ deltax;

% remove slopes created from the same x (i.e., Sen's main contribution to Theil's algorithm)
if sum(deltax==0)>0
    slopes(deltax==0)=[];
end

% sanity check: did anything bad happen with my implementation?
if sum(isnan(slopes))  ||  sum(isinf(slopes))
    error('The slopes computed include some NaN or Inf values. Check the algorithm')
end

% compute coefficients
b_ts(2) = median(slopes);
b_ts(1) = median(y-b_ts(2)*x);

% sanity check: (probably obsessive over checking: the preious check does the same)
if sum(isnan(b_ts))>0
    error('The coefficients have NaN. Check the algorithm')
end


% compute residuals
y_predicted = b_ts(1) + b_ts(2)*x;
resid = y - y_predicted;
