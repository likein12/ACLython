# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
from libcpp.vector cimport vector
cdef extern from "<atcoder/segtree>" namespace "atcoder" nogil: 
    cdef cppclass lazysegtree[S, OP, E, F, M, CMP, ID]: 
        lazysegtree(vector[S] v)
        void set(int p, S x)
        S get(int p)
        S prod(int l, int r)
        S all_prod()
        void apply(int p, S x)
        void apply(int l, int r, S x)
        int max_right[G](int l)
        int min_left[G](int r)
