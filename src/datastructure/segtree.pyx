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

# modintを入れる
cdef extern from "./intermediate.hpp" namespace "aclython" nogil: 
    cdef cppclass 
    cdef cppclass lazy_segtree: 
        lazy_segtree(vector[S] v)
        void set(int p, S x)
        S get(int p)
        S prod(int l, int r)
        S all_prod()
        void apply(int p, S x)
        void apply(int l, int r, S x)

