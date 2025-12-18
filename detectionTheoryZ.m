% Zrate = detectionTheoryZ(rate, denominator)
% 
% Applies the normal inverse (norminv) transformation to detection theory rates.
% For rates of exactly 0 or 1, applies bias corrections based on Macmillan & 
% Creelman (2005) to avoid infinite Z-scores.
%
% Input:
%   rate       - Hit rate or false alarm rate (scalar between 0 and 1)
%   denominator - Number of trials (positive integer)
%
% Output:
%   Zrate      - Z-score of the input rate
%
% Code written by Germano Gallicchio, germano.gallicchio@gmail.com


function Zrate = detectionTheoryZ(rate, denominator)

% Validate inputs
if denominator <= 0
    error('denominator must be a positive integer');
end

if ~ismember(rate, [0 1])
    Zrate = norminv(rate);
else
    % Apply bias corrections based on Macmillan & Creelman (2005)
    % Converts perfect rates using 1 - 1/(2*N) or 1/(2*N) formulas
    if rate == 1
        Zrate = norminv(1 - 1/(2*denominator));
    elseif rate == 0
        Zrate = norminv(1/(2*denominator));
    end
end
