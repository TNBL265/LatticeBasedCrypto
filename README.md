# LatticeBasedCryto

## 1. Information:
- A short 6-week research project under the [SHARP special programme](https://www.sutd.edu.sg/SHARP) in SUTD supervised by lecturer [Wong Wei Pin](https://esd.sutd.edu.sg/people/faculty/wong-wei-pin)
- Lattice-Based Cryptography (LBC) has faster encryption/decryption and more importantly, it's quantum resistance. 
- We learned about the basics of lattices and hard lattice problems like Shortest Vectors Problem or Closet Vectors Problem. 
- We then proceed to implement the NTRU Public Key Cryptosystem using Matlab and try to perform cryptanalysis (recover `private keys` given `public keys` and `public parameters`) on this system using Python.

## 2. Implementation:
### a. [Research Poster](Complementing_LLL_Lattice_Reduction_Algorithm_with_BIROT_to_find_SVPs.pdf)
### b. Cryptosystem
- Based on [NTRUEncrypt protocol](https://en.wikipedia.org/wiki/NTRUEncrypt) and its detailed formulation in the textbook [An Introduction to Mathematical Cryptography](https://www.springer.com/gp/book/9781441926746), we were able to write a Matlab program (making used of Matlab's vectorization for faster encryption and decryption)that can simulate the full process of encoding, encrypting, decrypting and decoding a message:
    - **Message**: `m = "I love you!"`
    - **Public parameters**: `[N, p, q, d] = [47, 3, 128, 7]`
    some other possible parameters choices according to NTRU protocol to ensure 1-1 encrypt-decrypt are:
            |  N  |  p  |  q  |  d  |
            | :-: | :-: | :-: | :-: |
            |  5  |  3  |  64 |  1  |
            |  7  |  3  |  64 |  2  |
            | 11  |  3  |  64 |  3  |
            | 23  |  3  | 128 |  7  |
            | 47  |  3  | 128 |  7  |
            | 59  |  3  | 128 |  7  |
            | 83  |  3  | 128 |  7  |
    - **Key Generation**: Generate `public_key` and `private_key` from the public parameters to be used for encryption and decryption. `public_key` will be used by Bob to encrypt the message while `private_key` will be used by Alice to decrypt the message (a form of *assymetric cryptography*)
    - **Encoding** (there can be more efficient protocol, we just find one that work for us so we can quickly try out the full encryption system): 
        - first, we turn a string into its ASCII numeric values. Then, we add padding so all ASCII values are 3-letter long. If the very fist digit in the message is `0`, this information will be lost when we convert base 10 to base 3 number (encyprting purposes). In this case, we convert the very first `0` into `9` (No ASCII value will reach 900 so this can be easily converted back during decoding).
            | Letter | ASCII (DEC) | Final (3 digits) |
            | :----: | :---------: | :--------------: |
            |    I   |     73      |        973       |
            | <space>|     32      |        032       |
            |    l   |     108     |        108       |
            |    o   |     111     |        111       |
            |    v   |     118     |        118       |
            |    e   |     101     |        101       |
            | <space>|     032     |        032       |
            |    u   |     117     |        117       |
            |    !   |     33      |        033       |
        - then we will split the full sequence `973032108111118101032117033` into blocks of 15 digits each (Matlab's precision is 16 digits by default). This is equivalent to 5 character per block. There will be zero-padding at the end of the last block if there is less than 15 digits:
        `973032108111118` && `101032117033000`
        - each of this block will then be converted to base 3 (ternary) number. This is equivalent to a block size  <br>`C = 32` ($3^{31} \approx 10e^{15}$). If less then 32 bits are required, there will be zero-padding at the front:
        `11201121012221221121210211222201` && `00111020201120112221121021110111`
        - the result is an `R x 32` ternary array where `R` is the total number of blocks required to encode `m`.
    - Encrypting:
        - using NTRUEncrypt protocol, we convert this array into completely random coefficients. Since we chose <br>`N = 47` and NTRU is based on Polynomial Rings, the encrypted message will be in the form of a `n x 47` array (block size of 47). Below we show 2 completely random encryption after 2 run:
            - Run 1:<br>
                ![](https://i.imgur.com/6vuwBzy.png)
            - Run 2:<br>
                ![](https://i.imgur.com/9gS6cWT.png)
    - **Decrypting and Decoding**: If the encrypted message is passed back for decryption, we can easily convert back to the original post-encoded message. Then with the relevant block number information, we can reshape this back for decoding. 
    - **Example**: If you have Matlab installed, simply clone this repository and use codes inside the [cryptosystem](cryptosystem) folder to try out the program. A screenshot will be shown below to show you the expected output of our program:
        - Choosing *messages*, *parameters* and generate `public_key` and `private_key`:
        ![](https://i.imgur.com/XiFUrsl.png)
            - Run 2: Complementing_LLL_Lattice_Reduction_Algorithm_with_BIROT_to_find_SVPs.pdf
        - Encoding and Encrypting:<br>
        ![](https://i.imgur.com/AjBQuJF.png)
        - Decrypting and Decoding:<br>
        ![](https://i.imgur.com/WR1YTQG.png)
    
### c. Cryptanalysis:
- Due to time constraint, we could not write a full Matlab script for cryptanalysis. Hence, we refered to a previously done python script for NTRUEncrypt by [jkrauze](https://github.com/jkrauze/ntru) in Python and build our attack using Python from there (codes in [cryptanalysis](cryptanalysis) folder).
- We use a Latice Reduction Method called [Lenstra–Lenstra–Lovász](https://en.wikipedia.org/wiki/Lenstra%E2%80%93Lenstra%E2%80%93Lov%C3%A1sz_lattice_basis_reduction_algorithm) (LLL) in combination with the idea in this master thesis on [Parallel Symmetric Attack](Mater_Thesis.pdf
) by Daniel Socek.
- The main results are shown in our [research poster](Complementing_LLL_Lattice_Reduction_Algorithm_with_BIROT_to_find_SVPs.pdf). 
