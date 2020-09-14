# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
from libcpp.vector cimport vector
 cdef extern from "<atcoder/segtree>" namespace "atcoder" nogil: 
    cdef cppclass segtree[S, OP, E]: 
        segtree(vector[S] v)
        void set(int p, S x)
        S get(int p)
        S prod(int l, int r)
        S all_prod()
        int max_right[F](int l)
        int min_left[F](int r)


 
