function [f_poly, Fp_poly, Fq_poly] = sample_key(params)
    % f_poly \in T(d + 1, d); check for inverses Fp_poly and Fq_poly
    % if either fails to exist, choose new f_poly; make use of proposition 7.45
    % Fp_poly is inverse of f_poly in Rp
    % Fq_poly_Rq is inverse of f_poly in Rq
    safe_prime = [5 7 11 23 47 59 83 107 167 179 227 263 347 359 383 467 479 503];
    [N, p, q, ~] = params{:};
    if N == safe_prime(1)
        % N = 5; q = 64;
        f_poly = [1, 0, -1, 1, 0];
        Fp_poly = mod([-1, -1, -1, 1, 0], p);
        Fq_poly = mod([12, -6, -29, -17, -23], q);
    end
    
    if N == safe_prime(2)
        % N = 7; q = 64;
        f_poly = [0, -1, 1, 0, 1, -1, 1];
        Fp_poly = mod([0, 1, -1, 0, -1, 0, -1], p);
        Fq_poly = mod([9, -7, -4, -28, -30, -18, 15], q);
    end
    
    if N == safe_prime(3)
        % N = 11; q = 64;
        f_poly = [1, -1, -1, 0, 1, 0, 1, -1, 0, 1, 0];
        Fp_poly = mod([1, 1, -1, 0, 0, 0, 1, 1, 0, 0, 1], p);
        Fq_poly = mod([-26, -12, 25, 15, -30, -4, 9, -18, -29, -6, 13], q);
    end
    
    if N == safe_prime(4)
        % N = 23; q = 128;
        f_poly = [1, 1, 1, 0, 0, 0, 0, -1, 1, -1, -1, 0, 1, 1, 0, 0, -1, 0, -1, -1, -1, 1, 1];
        Fp_poly = [0, 0, -1, -1, 0, -1, 1, 0, 0, -1, 0, 1, 0, 0, -1, 0, 1, 0, 1, 1, 0, -1, -1];
        Fq_poly = [-57, 9, 2, -38, -63, 25, 38, -15, 64, -28, -55, 22, 2, -14, -20, 16, 57, 7, 11, -56, -29, 53, -58];
    end
    
    if N == safe_prime(5)
        % N = 47; q = 128;
        f_poly = [-1, 0, 0, 0, -1, 1, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, -1, 1, 1, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, -1, 1, 0, 0, 0, -1, 0];
        Fp_poly = [1, 1, 0, 0, 0, 1, -1, 0, 0, 0, 0, -1, 0, 0, 1, 1, 0, 1, 1, 0,...
            -1, 1, 0, -1, 1, -1, 0, -1, -1, 1, 1, -1, 1, 1, 1, -1, 0, 0, -1, 1, -1, 0, 1, -1, -1, 1, 0];
        Fq_poly = [45, 54, -62, -3, 28, 55, 52, 2, 29, -16, -38, -47, -9, 51, -1, 25, 5, -19, -52, -27,...
            29, -49, 7, 2, -39, 15, -10, 10, -61, -48, -44, -34, -37, -54, -55, 14, 34, -36, 34, 55, -63,...
            -31, -63, 57, 4, -51, -41];
    end
    
    if N == safe_prime(6)
        % N = 59; q = 128;
        f_poly = [0, -1, -1, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, -1, 0, 1, 0,...
            0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0];
        Fp_poly = [-1, -1, 0, -1, 1, 0, 0, 1, 0, -1, 0, 0, -1, -1, 0, 1, 1, -1, -1, 0, -1, 0, 0, 1, 0, 0,...
            1, 1, 1, 1, 1, 1, 0, 1, 1, -1, 0, 0, 0, -1, -1, -1, -1, 0, -1, 0, 0, 0, 1, -1, 0, 0, -1, 1, 1,...
            0, 0, -1, 0];
        Fq_poly = [-6, -32, 11, 44, -9, 33, -10, 0, 15, -31, 56, -34, 32, 42, 9, -58, -7, -29, 49, 53, -27,...
            -63, -38, 45, -41, -50, -62, -24, 8, -23, -43, -5, 27, -16, -10, 62, 46, -49, 45, 49, 28, -36,...
            -19, -44, 50, -37, 23, -41, -17, 35, 29, -58, -52, 56, -32, 44, -7, -52, 44];
    end
    
    if N == safe_prime(7)
        % N = 83; q = 128;
        f_poly = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0,...
            0, -1, -1, 0, -1, 0, 0, 1, -1, 0, -1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, -1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        Fp_poly = [1, -1, -1, 1, -1, 0, 0, -1, 0, 0, -1, 1, -1, -1, 0, -1, -1, -1, 1, -1, 0, 0, 0, -1, -1,...
            0, 0, 0, -1, 0, 0, -1, 0, 1, 1, 1, 1, -1, 1, -1, 0, 1, 1, 0, 1, 1, 1, -1, 1, 0, 1, 0, 0, 1, 1,...
            1, 0, 1, 1, 0, -1, -1, 0, -1, 0, 0, 0, -1, 1, -1, 0, -1, 0, 1, 1, 1, -1, 1, -1, -1, 0, 0, -1];
        Fq_poly = [35, -15, 49, 38, -42, -57, 55, -17, -41, 50, 38, -11, 26, 38, -34, 36, 51, 38, -63, 62,...
            -3, 55, 34, 18, 24, -58, 8, 47, 31, 39, -19, -41, -60, -36, -62, -49, 57, 45, 18, -52, -7, 34,...
            52, -8, 16, -50, 16, 23, 64, -41, -27, -25, 51, 21, 9, 26, 32, -37, -43, 19, 46, -33, 2, -24,...
            23, 60, 17, 62, 54, -6, -41, 28, 29, 37, -62, 27, -16, -18, 46, 43, -9, 41, -22];
    end
    
    if N == safe_prime(8)
        % N = 107; q = 128;
        f_poly = [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,...
            0, 0, 0, 0, 1, -1, 0, 0, -1, 0, 0, 0, 1, 0, 1, 0];
        Fp_poly = [1, 1, -1, 1, -1, 0, 0, -1, -1, 0, -1, -1, 1, 0, -1, -1, 1, -1, 1, -1, -1, 1, -1, 1, -1,...
            0, 0, 1, 1, 1, 0, -1, 1, 0, 1, 0, 0, 1, 1, 1, -1, -1, 1, 1, 0, 0, -1, -1, 1, 0, 1, 1, 1, -1, 1,...
            0, -1, -1, 1, 1, 0, 0, 1, 1, 0, 1, -1, -1, 0, 1, 0, 1, -1, 1, 1, 0, -1, -1, -1, 1, 1, 1, 0, 1,...
            1, 1, 0, 1, -1, 1, 1, -1, -1, 0, 1, 1, 1, 1, -1, -1, 0, -1, 0, -1, 1, -1, -1];
        Fq_poly = [16, 16, -20, 6, 57, 56, 5, -36, -43, -9, 59, 58, -48, -47, 16, -58, -47, 24, -20, 34,...
            50, 10, -15, -14, -22, 27, -19, 60, 44, 12, 0, 2, 53, 46, 22, 36, 41, -22, 35, 61, -4, -8, 12,...
            -50, -31, 26, -7, 62, 9, -20, 63, 26, 21, -50, 0, 6, -40, 7, -27, 63, -37, 36, 52, -49, -57, 22,...
            -43, -4, 5, -45, -56, 26, -40, -38, 43, -19, -54, -3, -54, 0, -23, 51, 42, 58, 43, -12, -35, -15,...
            -4, -60, 51, 11, 58, -27, 19, -61, -41, -13, 38, 15, -59, 40, 64, -21, 38, -38, -31];
    end
    
    if N == safe_prime(9)
        % N = 167; q = 128;
        f_poly = [0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,...
            0, -1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,...
            0, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        Fp_poly = [1, -1, -1, 0, 1, 0, 0, -1, -1, 1, 1, 1, -1, -1, 1, 1, 1, 0, -1, 0, 0, 1, 0, 0, 1, -1, 0, 0, 1, 1, -1, 1, 1, 0,...
            0, 0, 0, 1, 0, 0, 1, 0, -1, -1, 1, 0, 0, -1, -1, -1, 1, -1, 1, 0, -1, 0, 1, 0, 0, 1, 1, 0, -1, 1, 0, -1, 1, 0, -1, 0, 0,...
            -1, 0, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1, 0, -1, -1, -1, 1, -1, -1, 0, 1, 0, 1, 0, 1, 0, 0, 1, -1, 0, 1, -1, -1, 1, -1, 0,...
            -1, -1, 0, 1, -1, 1, 0, 0, 1, -1, -1, 0, -1, 0, 0, -1, 1, -1, 1, 1, -1, -1, 1, 0, 1, 0, 1, 1, -1, 1, -1, 0, -1, 0, 0, -1,...
            -1, 1, 0, -1, 1, 0, 1, 1, 0, 0, 0, -1, -1, -1, 1, -1, 1, 0, -1, 1, 0, 0, 0, 0];
        Fq_poly = [-55, -54, -58, -14, 43, 58, 51, -8, -55, 59, -52, -13, 0, -26, 30, 16, -31, 45, 2, 19, -2, -22, -56, 7, 52, -59,...
            -39, -43, 64, -61, -14, -62, 26, -50, -30, -44, 62, 29, -22, -2, -12, -37, 41, 62, -54, 40, 18, -7, -23, 46, -33, 39, -44,...
            29, 7, 32, -43, 51, 23, -62, -37, -21, -37, 39, -60, 12, -10, -26, -48, 15, 56, -5, 54, -52, -43, 12, 22, -26, -3, 12, 32,...
            -13, 24, -1, -3, -57, -46, -56, 8, -40, 48, 21, 60, -42, 25, -34, 15, -39, -23, -1, 42, 40, 20, -48, -50, -7, 1, 52, -25,...
            -40, -57, -60, 18, 58, 27, -21, 54, -4, -1, 64, -3, -14, -35, 29, -23, 15, -28, 59, 62, 7, 28, -10, -17, 29, -46, -62, 63,...
            -11, -21, -3, 47, -46, 38, -3, -25, -31, -49, -44, 2, 48, 46, 32, -56, 42, -36, 60, 14, 32, -24, -36, 46, 53, -23, 33, 39,...
            33, -25];
    end
    
    if N == safe_prime(10)
        % N = 179; q = 128;
        f_poly = [0, 0, 0, 1, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, -1, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0,...
            0, 0, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0,...
            0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
        Fp_poly = [0, 1, -1, 1, -1, -1, 1, 0, -1, -1, -1, 0, 0, -1, -1, -1, -1, -1, 1, 0, -1, 0, -1, -1, -1, 1, 1, -1, 0, 0, -1, 1, 1, -1,...
            -1, 1, 0, -1, 1, -1, -1, 1, 0, 0, 0, 0, -1, -1, -1, 1, 0, -1, 1, 1, 0, 1, 0, 0, -1, -1, 1, -1, 1, -1, 0, 1, -1, -1, 0, 1, 1, 1,...
            0, 1, 1, 1, 1, -1, 1, 0, 1, 1, 0, 1, -1, -1, 1, 0, 0, 1, 0, 0, 1, 0, 0, -1, 1, -1, 0, 0, 1, 0, 1, 1, 1, 0, -1, 0, 1, -1, 0, 0,...
            0, -1, 0, -1, 0, 0, 1, 1, -1, 1, -1, 1, 1, 1, -1, 0, 1, -1, 0, 0, 0, -1, -1, -1, 1, 0, 1, -1, 0, -1, 0, -1, 0, 0, 0, 0, -1, -1,...
            -1, 0, 1, 0, 0, 1, -1, -1, -1, 0, -1, 0, -1, 0, 1, 1, 0, 0, 1, 1, 1, 0, -1, -1, 0, -1, 1, 1, 1];
        Fq_poly = [16, -23, -36, 25, -19, -62, 7, -16, -10, -51, -43, 45, 34, -60, 19, -7, 46, 41, -58, -49, 9, 59, 45, -6, -25, -12, -6,...
            -1, 1, -62, -18, 20, -59, 36, 4, -6, 41, -1, 26, -42, -8, -7, -29, 46, 54, -62, 7, 4, 30, 33, 13, 48, 18, 49, 50, -24, -7, 10,...
            6, -56, 39, 13, 49, 45, 48, -17, 16, -27, -60, 62, -61, 25, 29, 50, -5, -18, -42, -14, 10, -48, -30, -31, -58, -53, 21, -22, 30,...
            30, -15, 43, 47, 39, -51, -22, -24, -10, 14, -33, 21, -59, -38, 23, 51, 62, -17, -13, 54, 52, -13, -55, -60, -23, 13, 57, -25,...
            41, -11, 3, 11, 4, -57, -20, 13, 39, -63, -52, 32, 7, 20, 53, -50, -43, 15, 50, -51, -49, 18, 32, -53, -61, -31, 31, -8, -61, 28,...
            54, -41, -26, -57, -22, 34, -47, -47, 10, 11, 31, 63, 46, 63, 30, -61, 26, -47, -41, 59, -44, 48, -24, 36, 37, -31, 9, -22, 54,...
            -56, 60, -32, -46, -45];
    end
    
    if N == safe_prime(11)
        % N = 227; q = 128;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(12)
        % N = 263; q = 128;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(13)
        % N = 347; q = 128;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(14)
        % N = 359; q = 128;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(15)
        % N = 383; q = 128;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(16)
        % N = 467; q = 256;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(17)
        % N = 479; q = 256;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
    
    if N == safe_prime(18)
        % N = 503; q = 256;
        f_poly = 0;
        Fp_poly = 0;
        Fq_poly = 0;
    end
end