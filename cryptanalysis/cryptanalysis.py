from ntru.ntrucipher import NtruCipher
import numpy as np
from numpy.linalg import det, slogdet, norm
from scipy.linalg import circulant, qr
import logging
logging.basicConfig(filename='log.txt', level=logging.INFO)

def generate(N, p, q):
    ntru = NtruCipher(N, p, q)
    ntru.generate_random_keys()
    attrs = ['f_poly', 'f_p_poly', 'f_q_poly', 'g_poly', 'h_poly']
    return tuple(np.array(getattr(ntru, attr_name).all_coeffs()[::-1], dtype=float) for attr_name in attrs)

def birotate(v, k):
    assert len(v) % 2 == 0
    N = int(len(v) / 2)
    return np.append(np.roll(v[:N], k), np.roll(v[N:], k))

def BIROT(M, m, n):
    # if norm(M[m]) == norm(M[n]):
        # return M, False
    N = int(len(M)/2)
    M = np.copy(M)
    a = abs(det(M))
    for i in range(1, N):
        back_track = np.copy(M[n])
        M[n] = birotate(M[m], i)
        b = abs(det(M))
        # logging.INFO(f'a={a}, b={b}')
        if a == b:
            comp = M[n] == back_track
            if not np.all(comp):
                logging.info('old vec')
                logging.info(back_track)
                logging.info('new vec')
                logging.info(M[n])
                return M, True
        M[n] = back_track
    return M, False

def make_L(N,p,q):
    while True:
        try:
            f, Fp, Fq, g, h = generate(N,p,q)
            L = np.zeros((2*N,2*N), dtype=float)
            L[:N,:N] = np.eye(N)
            L[N:,N:] = q * np.eye(N)
            # print('h = ')
            # print(h)
            L[:N,N:] = circulant(h)
            break
        except ValueError:
            pass
        except Exception as e:
            raise e

    return L
            

def weight(L):
    return np.prod(norm(L,axis=1))

def mu(vi, vj):
    # a=vi@vj
    # b=vj@vj
    # print(a,b)
    # print(vi@vj/(vj@vj))
    return vi@vj/(vj@vj)

def proj(vi, vj):
    return mu(vi, vj) * vj

def gs(L):
    n = len(L)
    L2 = np.copy(L)
    # print(L2)
    for i in range(1, n):
        L2[i] -= sum(proj(L[i], L2[j]) for j in range(i))
    return L2

def LLL(L, delta=3/4):
    n = len(L)
    L = np.copy(L)
    L2 = gs(L)
    k = 1
    while k < n:
        for j in range(k-1, -1, -1):
            mu_kj = mu(L[k], L2[j])
            if abs(mu_kj) > 0.5:
                L[k] -= L[j] * round(mu_kj)
                L2 = gs(L)

        if L2[k]@L2[k] >= (delta - mu(L[k], L2[k-1])**2) * (L2[k-1]@L2[k-1]):
            k += 1
        else:
            L[[k, k-1]] = L[[k-1, k]]
            L2 = gs(L)
            k = max(k-1, 1)
    return L


def sorted_mat(L):
    idx = np.argsort(norm(L,axis=1))
    return L[idx]


def count_hit(L):
    L = sorted_mat(L)
    n = len(L)
    cnt = 0
    for i in range(1,n):
        for j in range(i):
            _, check = BIROT(L, j, i)
            if check:
                cnt += 1
    return cnt

def GAME(L, p, r, delta=3/4):
    L = np.copy(L)
    n = len(L)
    res = [H(LLL(L))]
    for round_ in range(r):
        L2 = L
        L = LLL(L, delta)
        for i in range(p-1):
            np.random.shuffle(L2)
            L3 = LLL(L2, delta)
            if weight(L3) < weight(L):
                L = L3
        
        L = sorted_mat(L)
        # print(norm(L,axis=1,keepdims=1))
        improved = False
        j = 1 if norm(L[0]) != (n/2)**0.5 else 2
        for i in range(n-1, j, -1):
            L2, imporved = BIROT(L, j, i)
            if imporved: 
                # print('old L = ')
                # print(L)
                # print('new L = ')
                # print(L2)
                L = L2
                res.append(H(L))
                logging.info('IMPROVED by BIROT')
                logging.info(f'j = {j}, i = {i}')
                break

        if not imporved:
            logging.warn(f'GAME ends earlier because there is no hit when r = {round_}!')
            # t_hit.append(round_)
            break

    return L, res

def H(L):
    n = len(L)
    return (abs(det(L))/weight(L))**(1/n)

def compare(N,p,q):
    L = make_L(N,p,q)
    L_L = LLL(L)
    L_G = GAME(L, 3, 10)[0]
    print(L_L)
    print(L_G)
    print('LLL: ',H(L_L))
    print('GAME:',H(L_G))

if __name__ == '__main__':
    compare(N,p,q)
