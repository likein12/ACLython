
code = """

# distutils: language=c++
# distutils: include_dirs=[/home/USERNAME/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False

from libcpp.vector cimport vector
from libc.stdio cimport getchar, printf
from libcpp.string cimport string
cpdef inline vector[int] ReadInt(int n):
    cdef int b, c
    cdef vector[int] *v = new vector[int]()
    for i in range(n):
        c = 0
        while 1:
            b = getchar() - 48
            if b < 0: break
            c = c * 10 + b
        v.push_back(c)
    return v[0]

cpdef inline vector[string] Read(int n):
    cdef char c
    cdef vector[string] *vs = new vector[string]()
    cdef string *s
    for i in range(n):
        s = new string()
        while 1:
            c = getchar()
            if c<=32: break
            s.push_back(c)
        vs.push_back(s[0])
    return vs[0]

cpdef inline void PrintLongN(vector[long] l, int n):
    for i in range(n): printf("%ld\\n", l[i])

cpdef inline void PrintLong(vector[long] l, int n):
    for i in range(n): printf("%ld ", l[i])
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] z_algorithm(string s)
    vector[int] z_algorithm[ll](vector[ll])

def ZAlgorithm(s):
    return z_algorithm(s)

cpdef vector[int] ZAlgorithmNum(vector[ll] s):
    return z_algorithm(s)
"""


import os, sys, getpass

if sys.argv[-1] == 'ONLINE_JUDGE':
    code.replace("USERNAME", getpass.getuser())
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
    sys.exit(0)


from atcoder import Read, ZAlgorithm, PrintLong

A = Read(1)
print(A[0].decode())
ans = ZAlgorithm(A[0])
PrintLong(ans, len(ans))