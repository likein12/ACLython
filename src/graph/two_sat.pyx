# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
from libcpp.vector cimport vector
cdef extern from "<atcoder/twosat>" namespace "atcoder":
    cdef cppclass two_sat:
        two_sat(int n)
        void add_clause(int i, bool f, int j, bool g)
        bool satisfiable()
        vector[bool] answer()

cdef class TwoSat:
    cdef two_sat *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new two_sat(n)
    cpdef void add_clause(self, int i, bool f, int j, bool g):
        self._thisptr.add_clause(i, f, j, g)
    cpdef bool satisfiable(self): 
        return self._thisptr.satisfiable()
    cpdef vector[bool] answer(self): 
        return self._thisptr.answer()