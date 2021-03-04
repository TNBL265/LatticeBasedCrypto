function [M_NTRU] = NTRU_L_gen(params, public_key)
    % reformat the public key into NTRU lattice to perform cryptanalysis
    
    [N, ~, q, ~] = params{:};
    % preallocate upper right block (cyclical permutations of h_poly coef)
    h_NTRU = zeros(N, N);
    
    % the free coefficient should be the first one so let's flip
    h_NTRU(1, :) = flip(public_key);
    for i=2:N
        h_NTRU(i, :) = circshift(h_NTRU(i-1, :), 1);
    end
    M_NTRU = [eye(N) h_NTRU; zeros(N) q*eye(N)];
end