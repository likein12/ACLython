# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
cdef extern from "<atcoder/convolution>" namespace "atcoder":
    vector[long] convolution(vector[long] &a, vector[long] &b)

cpdef vector[long] Conv(vector[long] A, vector[long] B):
    return convolution(A, B)