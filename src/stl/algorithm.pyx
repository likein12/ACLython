# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.algorithm cimport sort
from libcpp.vector cimport vector

cdef extern from *:
    ctypedef long long ll "long long"

cpdef void Sort(vector[ll] v):
    sort(v.begin(), v.end())
