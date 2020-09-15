# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
from libcpp.string cimport string
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] suffix_array(string s)
    vector[int] suffix_array[ll](vector[ll] s)
    vector[int] suffix_array(vector[int] s, int upper)

def SuffixArray(s):
    cdef cs = s.encode()
    return suffix_array(cs)

cpdef vector[int] SuffixArrayNum(vector[ll] s):
    return suffix_array(s)

cpdef vector[int] SuffixArrayNumUp(vector[int] s, int upper):
    return suffix_array(s, upper)
