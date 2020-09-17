# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
from libcpp.vector cimport vector
cdef extern from "./intermediate.hpp" namespace "aclython" nogil: 
    cdef cppclass segtree_min: 
        segtree_min(vector[int] v)
        void set(int p, int x)
        int get(int p)
        int prod(int l, int r)
        int all_prod()
        int max_right(int l, int v)
        int min_left(int r, int v)

cdef class SegTreeMin:
    cdef segtree_min *_thisptr
    def __cinit__(self, vector[int] v):
        self._thisptr = new segtree_min(v)
    cpdef void set(self, int p, int x):
        self._thisptr.set(p, x)
    cpdef int get(self, int p):
        return self._thisptr.get(p)
    cpdef int prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef int all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l, int v):
        return self._thisptr.max_right(l, v)
    cpdef int min_left(self, int r, int v):
        self._thisptr.min_left(r, v)

cdef extern from "./intermediate.hpp" namespace "aclython" nogil:
    cdef cppclass segtree_max:
        segtree_max(vector[int] v)
        void set(int p, int x)
        int get(int p)
        int prod(int l, int r)
        int all_prod()
        int max_right(int l, int v)
        int min_left(int r, int v)

cdef class SegTreeMax:
    cdef segtree_max *_thisptr
    def __cinit__(self, vector[int] v):
        self._thisptr = new segtree_max(v)
    cpdef void set(self, int p, int x):
        self._thisptr.set(p, x)
    cpdef int get(self, int p):
        return self._thisptr.get(p)
    cpdef int prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef int all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l, int v):
        return self._thisptr.max_right(l, v)
    cpdef int min_left(self, int r, int v):
        self._thisptr.min_left(r, v)


def SegTree(v, op):
    if op=="min":
        return SegTreeMin(v)
    elif op=="max":
        return SegTreeMax(v)

cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "./intermediate.hpp" namespace "aclython" nogil: 
    cdef cppclass S:
        S(int, int)
        S(S &)
        int get_a()
        int size
    cdef cppclass F:
        F(int, int)
        F(F &)
        int get_a()
        int get_b()
    cdef cppclass lazy_segtree: 
        lazy_segtree(vector[S] v)
        void set(int p, S x)
        S get(int p)
        S prod(int l, int r)
        S all_prod()
        void apply(int p, F f)
        void apply(int l, int r, F f)

cdef class LazySegTree:
    cdef lazy_segtree *_thisptr
    def __cinit__(self, vector[vector[int]] v):
        cdef int n = v.size()
        cdef vector[S] *sv = new vector[S]()
        cdef S *s
        for i in range(n):
            s = new S(v.at(i).at(0), v.at(i).at(1))
            sv.push_back(s[0])
        self._thisptr = new lazy_segtree(sv[0])
    cpdef void set(self, int p, vector[int] v):
        cdef S *s = new S(v.at(0), v.at(1))
        self._thisptr.set(p, s[0])
    cpdef vector[int] get(self, int p):
        cdef S *s = new S(self._thisptr.get(p))
        cdef vector[int] *v = new vector[int]()
        v.push_back(s.get_a())
        v.push_back(s.size)
        return v[0]
    cpdef vector[int] prod(self, int l, int r):
        cdef S *s = new S(self._thisptr.prod(l, r))
        cdef vector[int] *v = new vector[int]()
        v.push_back(s.get_a())
        v.push_back(s.size)
        return v[0]
    cpdef vector[int] all_prod(self):
        cdef S *s = new S(self._thisptr.all_prod())
        cdef vector[int] *v = new vector[int]()
        v.push_back(s.get_a())
        v.push_back(s.size)
        return v[0]
    cpdef void apply(self, int p, vector[int] v):
        cdef F *f = new F(v.at(0), v.at(1))
        self._thisptr.apply(p, f[0])
    cpdef void apply_range(self, int l, int r, vector[int] v):
        cdef F *f = new F(v.at(0), v.at(1))
        self._thisptr.apply(l, r, f[0])
