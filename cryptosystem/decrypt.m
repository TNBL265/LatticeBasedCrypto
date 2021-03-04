function [d_poly] = decrypt(params, private_key, e_poly_Rq)
    [~, p, q, ~] = params{:};
    f_poly = private_key(1, :);
    Fp_poly = private_key(2, :);
    
    % a_poly_Rq = f_poly * e_poly in Rq (coef <= 0.5q)
    a_poly = ring_conv(f_poly, e_poly_Rq); % f is ternary
    a_poly_Rq = mod(a_poly, q);
    
    % center lift a_poly to R (this should recovers the exact value as long as q>(6d+1)p)
    a_poly = center_lift(a_poly_Rq, q);
    
    % d_poly_Rp = Fp_poly_Rp * a_poly (mod p); 
    d_poly = ring_conv(Fp_poly, a_poly);
    d_poly_Rp = mod(d_poly, p);
    
    % center-lift d_poly_Rp to d_poly
    d_poly = center_lift(d_poly_Rp, p);
end