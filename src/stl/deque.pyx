# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.deque cimport deque
from cython.operator cimport dereference
from libcpp cimport bool

cdef extern from *:
    ctypedef long long ll "long long"

cdef class Deque:
    cdef deque[ll] *_thisptr
    def __cinit__(self):
        self._thisptr = new deque[ll]()
    cpdef void append(self, ll l):
        self._thisptr.push_back(l)
    cpdef void appendleft(self, ll l):
        self._thisptr.push_front(l)
    cpdef ll pop(self):
        cdef ll l = dereference(self._thisptr.rbegin())
        self._thisptr.pop_back()
        return l
    cpdef ll popleft(self):
        cdef ll l = dereference(self._thisptr.begin())
        self._thisptr.pop_front()
        return l
    def __getitem__(self, x):
        return self._thisptr[0][x]
    cpdef bool empty(self):
        return self._thisptr.empty()
    cpdef int size(self):
        return self._thisptr.size()