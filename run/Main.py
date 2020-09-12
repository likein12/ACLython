"""
c_r_5さんの
https://atcoder.jp/contests/practice2/submissions/16626085
を参考に
"""

code = """
# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
cdef extern from "/opt/atcoder-stl/atcoder/dsu.hpp" namespace "atcoder":
    cdef cppclass dsu:
        dsu(int n)
        int merge(int a, int b)
        bool same(int a, int b)
        int leader(int a)
        int size(int a)
cdef class DSU:
    cdef dsu *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new dsu(n)
    cpdef int merge(self, int a, int b):
        return self._thisptr.merge(a, b)
    cpdef bool same(self, int a, int b):
        return self._thisptr.same(a, b)
    cpdef int leader(self, int a):
        return self._thisptr.leader(a)
    cpdef int size(self, int a):
        return self._thisptr.size(a)
"""
import os,sys
if sys.argv[-1] == 'ONLINE_JUDGE':
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
 
# ↑ここまでライブラリ↓ここから解法
 
import sys
import atcoder
input = sys.stdin.buffer.readline
n, q = map(int, input().split())
dsu = atcoder.DSU(n)
res = []
for i in range(q):
    t, u, v = map(int, input().split())
    if t:
        if dsu.same(u, v): res.append(1)
        else: res.append(0)
    else:
        dsu.merge(u, v)
print('\n'.join(map(str, res)))