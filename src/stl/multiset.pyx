# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
from libcpp.utility cimport pair
from cython.operator cimport preincrement
from cython.operator cimport predecrement
from cython.operator cimport dereference
cdef extern from "<set>" namespace "std" nogil:
    cdef cppclass multiset[T]:
        ctypedef T value_type
        cppclass iterator:
            T& operator*()
            iterator operator++()
            iterator operator--()
            bint operator==(iterator)
            bint operator!=(iterator)
        cppclass reverse_iterator:
            T& operator*()
            iterator operator++()
            iterator operator--()
            bint operator==(reverse_iterator)
            bint operator!=(reverse_iterator)
        cppclass const_iterator(iterator):
            pass
        cppclass const_reverse_iterator(reverse_iterator):
            pass
        multiset() except +
        multiset(multiset&) except +
        iterator begin()
        reverse_iterator rbegin()
        size_t count(const T&)
        bint empty()
        iterator end()
        reverse_iterator rend()
        iterator find(T&)
        size_t size()
        iterator upper_bound(const T&)
        iterator lower_bound(T&)
        pair[iterator, bint] insert(const T&) except +
        iterator erase(iterator)

cdef extern from *:
    ctypedef long long ll "long long"


cdef class MultiSet:
    cdef multiset[ll] *_thisptr
    def __cinit__(self):
        self._thisptr = new multiset[ll]()
    cpdef int size(self):
        return self._thisptr.size()
    cpdef bool empty(self):
        return self._thisptr.empty()
    cpdef void add(self, ll x):
        self._thisptr.insert(x)
    cpdef void remove(self, ll x):
        self._thisptr.erase(self._thisptr.find(x))
    cpdef int count(self, ll x):
        return self._thisptr.count(x)
    cpdef ll min(self):
        return dereference(self._thisptr.begin())
    cpdef ll max(self):
        return dereference(self._thisptr.rbegin())
    def lower_bound(self, x):
        cdef multiset[ll].iterator itr = self._thisptr.lower_bound(x)
        if itr == self._thisptr.end():
            return None
        else:
            return dereference(itr)
    def upper_bound(self, ll x):
        cdef multiset[ll].iterator itr = self._thisptr.upper_bound(x)
        if itr == self._thisptr.end():
            return None
        else:
            return dereference(itr)
    def next(self, x):
        if x >= self.max():
            return None
        cdef multiset[ll].iterator itr = self._thisptr.find(x)
        cdef int c = self._thisptr.count(x)
        for i in range(c):
            preincrement(itr)
        return dereference(itr)
    cpdef prev(self, x):
        if x <= self.min():
            return None
        cdef multiset[ll].iterator itr = self._thisptr.find(x)
        predecrement(itr)
        return dereference(itr)
    cpdef ll pop_min(self):
        cdef multiset[ll].iterator itr = self._thisptr.begin()
        cdef ll ret = dereference(itr)
        self._thisptr.erase(itr)
        return ret
    cpdef ll pop_max(self):
        cdef multiset[ll].reverse_iterator itr = self._thisptr.rbegin()
        cdef ll ret = dereference(itr)
        self._thisptr.erase(self._thisptr.find(ret))
        return ret
    def __contains__(self, x):
        if self._thisptr.find(x)==self._thisptr.end():
            return False
        else:
            return True