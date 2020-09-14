# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
cdef extern from "<atcoder/scc>" namespace "atcoder":
    cdef cppclass scc_graph:
        scc_graph(int n)
        void add_edge(int fr, int to)
        vector[vector[int]] scc()
 
cdef class SccGraph:
    cdef scc_graph *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new scc_graph(n)
    cpdef void add_edge(self, int fr, int to):
        self._thisptr.add_edge(fr, to)
    cpdef vector[vector[int]] scc(self):
        return self._thisptr.scc()