# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.queue cimport priority_queue
from cython.operator cimport dereference
from libcpp cimport bool

cdef extern from *:
    ctypedef long long ll "long long"

cdef class PriorityQueue:
    cdef priority_queue[ll] *_thisptr
    def __cinit__(self):
        self._thisptr = new priority_queue[ll]()
    cpdef bool empty(self):
        return self._thisptr.empty()
    cpdef ll pop(self):
        cdef ll ret = self._thisptr.top()
        self._thisptr.pop()
        return ret
    cpdef void push(self, ll l):
        self._thisptr.push(l)
    cpdef int size(self):
        return self._thisptr.size()