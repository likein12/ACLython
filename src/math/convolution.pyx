# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector

cdef extern from *:
    ctypedef int MOD_t "998244353"
    ctypedef long long ll "long long"

cdef extern from "<atcoder/convolution>" namespace "atcoder":
    vector[int] convolution[M](vector[int] a, vector[int] b)
    vector[ll] convolution_ll(vector[ll] a, vector[ll] b)

cpdef vector[int] Conv(vector[int] a, vector[int] b):
    return convolution[MOD_t](a, b)

cpdef vector[ll] ConvL(vector[ll] a, vector[ll] b):
    return convolution_ll(a, b)

