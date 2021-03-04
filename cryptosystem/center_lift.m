function [poly] = center_lift(poly_Rx, x)
    upper_mask = poly_Rx > floor(x/2); % check for coefs exceed q/2
    lower_mask = poly_Rx < ceil(-x/2);  % check for coefs below -q/2
    poly = poly_Rx + x*(lower_mask - upper_mask);
end
