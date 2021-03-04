function [poly] = random_poly(N, d1, d2)
    % Create random ternary vector/poly with #d1 1 and #d2 -1, rest 0
    
    % Create a row vector with #d1 1 then #d2 -1 then #N-d1-d2 
    % d1 = 3; d2 = 2; N = 7;
    poly = [ones(1, d1) -1*ones(1, d2) zeros(1, N-d1-d2)];
    % permute
    i = randperm(N);
    poly = poly(i);
end