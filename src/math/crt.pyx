# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.utility cimport pair
from libcpp.vector cimport vector
cdef extern from "<atcoder/math>" namespace "atcoder":
    pair[long long, long long] crt(vector[long long] r, vector[long long] m)

cpdef pair[long long, long long] Crt(vector[long long] r, vector[long long] m):
    return crt(r, m)