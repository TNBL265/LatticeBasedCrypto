import sys
import logging
from scipy.io import savemat
from cryptanalysis import *
""" expiremet 1 : test collision time 
N, p, q = 17, 3, 64
# N, p, q = 5, 3, 8
for i in range(20):
    L = make_L(N, p, q)
    if count_hit(L) > 0:
        print(i)
# print(L)
print(count_hit(L))
print('end')

N, p, q = 23, 3, 64
L = make_L(N, p, q)
L_L = LLL(L)
L_G, _ = GAME(L,3,10)
print(H(L_L), H(L_G))
"""




""" Fix n, change r (rounds of BIROT) """
logging.basicConfig(filename='test.txt')

def fix_n(N, p, q, r, t, id_):
    H_O = 0
    H_L = 0
    res = np.zeros(r+1)
    max_v = np.full(r+1, -np.inf)
    min_v = np.full(r+1, np.inf)
    t_hit = []

    for test in range(t):
        # print(test)
        L = make_L(N, p, q)
        logging.info(L)
        H_O += H(L)
        L = LLL(L)
        H_L += H(L)

        _, test_res = GAME(L, 1, r)
        logging.info('original test_res')
        logging.info(test_res)
        t_hit.append(r)
        for i in range(r+1-len(test_res)):
            test_res.append(test_res[-1])
        res += test_res
        max_v = np.maximum(max_v, test_res)
        min_v = np.minimum(min_v, test_res)

    H_O /= t
    H_L /= t
    res /= t
    savemat(f'fix_n_N{N}_p{p}_q{q}_r{r}_t{t}_id{id_}.mat', {
        'H_G': res, 'H_O': H_O, 'H_L': H_L, 'N': N, 'p': p, 'q': q, 'r': r, 't': t, 'min_v': min_v, 'max_v': max_v, 't_hit': t_hit,
        })

    print(H_O)
    print(H_L)
    print(max_v)
    print(min_v)
    print(res)
    
if __name__ == '__main__':
    # fix_n(11, 3, 32, 20, 20)
    N = int(sys.argv[1])
    p = int(sys.argv[2])
    q = int(sys.argv[3])
    r = int(sys.argv[4])
    t = int(sys.argv[5])
    id_ = int(sys.argv[6])
    fix_n(N, p, q, r, t, id_)
    # fix_n(23, 3, 128, 20, 20)
    # fix_n(4)
    # fix_n(23, 3, 64, 20, 20)
