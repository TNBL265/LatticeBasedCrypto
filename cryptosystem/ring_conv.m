function [poly] = ring_conv(p1, p2)
    N = length(p1);
    tmp_poly = conv(p1, p2);
    poly = [0, tmp_poly(1:N-1)] + tmp_poly(N:end);
end