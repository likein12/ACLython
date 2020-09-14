# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
cdef extern from "<atcoder/fenwicktree>" namespace "atcoder" nogil:
    cdef cppclass fenwick_tree[T]:
        fenwick_tree(int n)
        void add(int p, T x)
        T sum(int l, int r)

cdef class FenwickTree:
    cdef fenwick_tree[long long] *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new fenwick_tree[long long](n)
    cpdef void add(self, int p, long long x):
        self._thisptr.add(p, x)
    cpdef long long sum(self, int l, int r):
        return self._thisptr.sum(l, r)