# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
from libcpp.string cimport string
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] lcp_array(string s, vector[int] sa)
    vector[int] lcp_array[ll](vector[ll] s, vector[int] sa)

cpdef vector[int] LcpArray(string s, vector[int] sa):
    return lcp_array(s, sa)

cpdef vector[int] LcpArrayNum(vector[ll] s, vector[int] sa):
    return lcp_array(s, sa)