function [d] = ternary_decode_R(post_decrypt_arr)
    % INPUT: post_decrypt_arr with 32 column (each row is a block of 32)
    % OUTPUT: decode message d
    
    % recover each block initial dimension and convert from base 3 to dec
    [r, ~] = size(post_decrypt_arr);
    
    % prealloc full ascii encoded message in char
    a = 15;
    char_ascii_arr = zeros(1, r*a/3);
    for i=1:r
        block = post_decrypt_arr(i, :);
        
        % find 1st non zero (unpadded message)
        ind = find(block);
        block = block(ind:end);
        
        % from arr into char (base3)
        block = arrayfun(@(x)sprintf('%d',x), block);
        
        % from base 3 to dec
        block = base2dec(block, 3);
        
        % from dec to str
        block = num2str(block, a);
        
        % str to char so we can work with indexing
        block = convertStringsToChars(block);
        
        % 2 cases to fix the padding
        % 1st case is the front padding of whole message
        if i == 1 && block(1) == '9'
            block(1) = '0';
        end
        % 2nd case is value in front of each block is lost
        if length(block) ~= a
            for k=1:a-length(block)
                block = append('0', block);
            end
        end
        
        % each block now is of size 15, where every 3 digit is 1 ascii val
        for j=1:a/3
            char_ascii_arr((i-1)*a/3+j) = str2double(block((j-1)*3+1:j*3));
        end
    end
    % remove zero padding at the end
    char_ascii_arr = flip(char_ascii_arr);
    ind = find(char_ascii_arr);
    char_ascii_arr = char_ascii_arr(ind:end);
    char_ascii_arr = flip(char_ascii_arr);
    
    % ascii to message
    d = char(char_ascii_arr);
end