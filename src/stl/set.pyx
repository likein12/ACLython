# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.set cimport set
from libcpp cimport bool
from cython.operator cimport preincrement
from cython.operator cimport predecrement
from cython.operator cimport dereference
cdef extern from *:
    ctypedef long long ll "long long"

cdef class Set:
    cdef set[ll] *_thisptr
    def __cinit__(self):
        self._thisptr = new set[ll]()
    cpdef int size(self):
        return self._thisptr.size()
    cpdef bool empty(self):
        return self._thisptr.empty()
    cpdef void add(self, ll x):
        self._thisptr.insert(x)
    cpdef void remove(self, ll x):
        self._thisptr.erase(self._thisptr.find(x))
    cpdef ll min(self):
        return dereference(self._thisptr.begin())
    cpdef ll max(self):
        return dereference(self._thisptr.rbegin())
    cpdef ll lower_bound(self, ll x):
        return dereference(self._thisptr.lower_bound(x))
    cpdef ll upper_bound(self, ll x):
        return dereference(self._thisptr.upper_bound(x))
    cpdef ll next(self, ll x):
        cdef set[ll].iterator itr = self._thisptr.find(x)
        preincrement(itr)
        return dereference(itr)
    cpdef ll prev(self, ll x):
        cdef set[ll].iterator itr = self._thisptr.find(x)
        predecrement(itr)
        return dereference(itr)
    cpdef ll pop_min(self):
        cdef set[ll].iterator itr = self._thisptr.begin()
        cdef ll ret = dereference(itr)
        self._thisptr.erase(itr)
        return ret
    cpdef ll pop_max(self):
        cdef set[ll].reverse_iterator itr = self._thisptr.rbegin()
        cdef ll ret = dereference(itr)
        self._thisptr.erase(self._thisptr.find(ret))
        return ret
    def __contains__(self, x):
        if self._thisptr.find(x)==self._thisptr.end():
            return False
        else:
            return True