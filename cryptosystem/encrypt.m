function [e_poly_Rq] = encrypt(params, m_poly, public_key)
    [N, p, q, d] = params{:};
    h_poly_Rq = public_key;
    
    % coef of m_poly satisfies -0.5p <= m_i <= 0.5p
    % m_poly is \in R and is center-lift of a poly in Rp
    % m_poly = [0, -1, 0, 1, 1, -1, 1];
    % r_poly as noise \in T(d, d)
    r_poly = random_poly(N, d, d);
    
    % e_poly_Rq is encrypt text in Rq: e = ph(x) * r(x) + m(x) in Rq
    e_poly = ring_conv(p*h_poly_Rq, r_poly); % r is ternary
    e_poly_Rq = mod(e_poly + m_poly, q);
end