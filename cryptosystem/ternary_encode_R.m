function [pre_encrypt_arr] = ternary_encode_R(m)
    % convert a string m to array of ternary coefficients for encryption
    % each row of the array is a block size b = 32

    % str to ASCII
    encode = double(m); % some 2 letters, some 3

    % add padding
    encode = sprintfc('%03d', encode); % all are 3 letters

    % merge
    encode = [encode{:}]; % divisible by 3
    N = length(encode);

    % split to block size of 15 so MATLAB can store accurately
    % but first pad with 0 at the end so divisible by 15;
    a = 15; 
    pad = repelem('0', a - mod(N, a));
    encode = append(encode, pad);

    q = length(encode)/a;
    % preallocate strings array
    splitted_arr = strings(q, 1);
    for i=1:q
        splitted_arr(i) = encode((i-1)*a+1: i*a); 
    end

    % if first value is 0, convert to 9 so as not to lose data
    % 9 is just a big number that ascii wont reach 900 ish
    % it will also create an upper bound (32 bits) when convert to base 3 later
    first_str = convertStringsToChars(splitted_arr(1));
    if first_str(1) == '0'
        first_str(1) = '9';
    end
    splitted_arr(1) = convertCharsToStrings(first_str);

    % convert to base 3 then comvert to coef array for encryption
    b = 32;
    pre_encrypt_arr = zeros(q, b);
    for i=1:q
        block = splitted_arr(i);
        block = str2double(block);
        block = dec2base(block, 3);
        % sprintf('%15.f', block)

        % add padding
        c = length(block);
        if c ~= b
            % append in front so can easily remove later
            block = append(repelem('0', b - c), block);
        end
        single_arr = zeros(1, b);
        % convert into array for encryption
        for j=1:b
            single_arr(j) = str2double(block(j));
        end
        pre_encrypt_arr(i, :) = single_arr;
    end
end