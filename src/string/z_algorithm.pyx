# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
from libcpp.string cimport string
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] z_algorithm(string s)
    vector[int] z_algorithm[ll](vector[ll])

def ZAlgorithm(s):
    return z_algorithm(s)

cpdef vector[int] ZAlgorithmNum(vector[ll] s):
    return z_algorithm(s)