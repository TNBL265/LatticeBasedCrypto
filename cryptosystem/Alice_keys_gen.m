function [cryptanalysis, public_key, private_key] = Alice_keys_gen(params)
    % public keys: f, Fp and private keys: h
    [N, ~, q, d] = params{:};

    [f_poly, Fp_poly, Fq_poly] = sample_key(params);
    % g_poly \in T(d, d), never has inverses
    g_poly = random_poly(N, d, d);
     
    % h_poly_Rq = Fq_poly * g_poly in Rq
    h_poly = ring_conv(Fq_poly, g_poly); % g is ternary
    h_poly_Rq = mod(h_poly, q);
    % turn h_poly into NTRU lattices L_NTRU_h spanned by rows of M_NTRU_h = [I, h_perm; 0, qI]
    % det(L_NTRU_h) = det(M_NTRU_h) = q^N (upper triangular matrices)) 
    
    % private_key = f_poly & Fp_poly 
    private_key = [f_poly; Fp_poly];
    % public_key = h_poly_Rq
    public_key = h_poly_Rq;
    % cryptanalysis result should recover f_poly and g_poly
    cryptanalysis = [f_poly; g_poly];
end