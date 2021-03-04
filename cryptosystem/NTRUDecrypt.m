function [d] = NTRUDecrypt(e_poly_Rq_arr, R, params, private_key)
    % INPUT: e_poly_Rq_arr is the encrypted message
    %        R is the number of blocks for decoding
    %        params is the public parameters
    %        private_key is Bob's private key
    % OUTPUT: d is the fully decrypted and decoded message
    C = 32; % default block size of 32
    [block_num, ~] = size(e_poly_Rq_arr);
    [N, p, ~, ~] = params{:};
    
    % Step 3a: Decryption loop
    d_poly_arr = zeros(block_num, N);
    for i=1:block_num
    e_poly_Rq = e_poly_Rq_arr(i,:);
    d_poly_arr(i,:) = decrypt(params, private_key, e_poly_Rq);
    end
    % convert back to Rp
    d_poly_arr = mod(d_poly_arr, p);

    % Step 3b: Resplit into block for decode
    d_poly_arr = reshape(d_poly_arr',1,[]);

    % remove front zero padding
    ind = find(d_poly_arr);
    d_poly_arr = d_poly_arr(ind:end); 
    % reshape into decoding arr
    d_poly_arr = reshape(d_poly_arr, [C, R])';
    d = ternary_decode_R(d_poly_arr);
    fprintf('\n'); disp("Alice's decryption yield: "); disp(d);
end