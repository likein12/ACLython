# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.unordered_map cimport unordered_map

cdef extern from *:
    ctypedef long long ll "long long"

cdef class UMapLI:
    cdef unordered_map[ll,int] *_thisptr
    def __cinit__(self):
        self._thisptr = new unordered_map[ll,int]()
    def __getitem__(self, key):
        return self._thisptr[0][key]
    def __setitem__(self, key, value):
        self._thisptr[0][key] = value