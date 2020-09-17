
code = """

# distutils: language=c++
# distutils: include_dirs=[/home/USERNAME/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False

from libc.stdio cimport getchar, printf
from libcpp.vector cimport vector
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
cdef extern from "<atcoder/scc>" namespace "atcoder":
    cdef cppclass scc_graph:
        scc_graph(int n)
        void add_edge(int fr, int to)
        vector[vector[int]] scc()

cdef class SccGraph:
    cdef scc_graph *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new scc_graph(n)
    cpdef void add_edge(self, int fr, int to):
        self._thisptr.add_edge(fr, to)
    cpdef vector[vector[int]] scc(self):
        return self._thisptr.scc()
"""


import os, sys, getpass

if sys.argv[-1] == 'ONLINE_JUDGE':
    code.replace("USERNAME", getpass.getuser())
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
    sys.exit(0)


from atcoder import SccGraph, ReadInt

def main():
    N, M = ReadInt(2)
    sg = SccGraph(N)
    for i in range(M):
        a, b = ReadInt(2)
        sg.add_edge(a, b)
    ans = sg.scc()
    print(len(ans))
    for i in range(len(ans)):
        print(len(ans[i]),*ans[i])

if __name__=="__main__":
    main()