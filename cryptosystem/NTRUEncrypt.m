% m = 'I love you!';
% params = [47, 3, 128, 7]; params = num2cell(params); % easier to unpack
% Step 1: key generation
% [cryptanalysis, public_key, private_key] = Alice_keys_gen(params);
function [R, e_poly_Rq_arr] = NTRUEncrypt(m, params, public_key)
    % INPUT: m is the string message
    %        params is a vector [N, p, q, d] represents the chosen NTRU
    %        public parameters to be used.
    %        pulic_key is the public key anyone can used (Bob) to encrypt
    %                  their message before sending to Alice.
    % OUTPUT: R is the number of blocks to reshape the message accrodingly 
    %           for decoding
    %         e_poly_Rq_arr is the encrypted message (random every run)
    [N, p, ~, ~] = params{:};

    % Step 2a: Message encoding
    disp("Bob's message: "); disp(m); fprintf('\n'); 
    disp("Press 'Enter' to continue!"); pause;
    m_arr = ternary_encode_R(m);
    disp("Bob's encoded message first 10 values: "); disp(m_arr(1:10)); 
    disp("Press 'Enter' to continue!")
    R = size(m_arr, 1) % number of blocks for reshaping after decryption
    
    % Step 2b: Split into block of size N for encryption
    % unroll m_arr so can resize
    m_arr = reshape(m_arr',1,[]);

    % add 0 padding in front
    mess_num = length(m_arr);
    pad_num = N - mod(mess_num, N);
    m_arr = [zeros(1, pad_num) m_arr];

    % split into block of size N and encrypt block by block
    block_num = length(m_arr)/N
    e_poly_Rq_arr = zeros(block_num, N);
    for i=1:N:length(m_arr)
    m_poly = m_arr(i:i+N-1);
    % center lift here since the ternary vector is 0 1 2 but m coef can only be -1 0 1
    m_poly = center_lift(m_poly, p);
    e_poly_Rq_arr((i-1)/N+1,:) = encrypt(params, m_poly, public_key);
    end
    disp("Bob's encrypted message first 10 values: "); disp(e_poly_Rq_arr(1:10)); 
    disp("You can try run NTRUDecrypt to decrypt this message.")
end