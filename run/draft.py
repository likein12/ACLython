from atcoder import Compression

A = list(range(1,10000000,100))

def Compression2(L):
    L = list(set(L))
    L.sort()
    return L, {q:p for p,q in enumerate(L)}

a,b = Compression(A)
