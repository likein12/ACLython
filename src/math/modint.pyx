# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
cdef extern from "<atcoder/modint>" namespace "atcoder":
    cdef cppclass modint998244353:
        modint998244353(long v)
        modint998244353 operator+(const modint998244353& lhs, const modint998244353& rhs)
        modint998244353 operator-(const modint998244353& lhs, const modint998244353& rhs)
        modint998244353 operator*(const modint998244353& lhs, const modint998244353& rhs)
        int val()

cdef class MInt:
    cdef modint998244353 *_thisptr
    def __cinit__(self, long v):
        self._thisptr = new modint998244353(v)
    cpdef int val(self):
        return self._thisptr.val()
    cpdef MInt add(self, MInt other):
        return MInt((self._thisptr[0] + other._thisptr[0]).val())
    def __add__(self, other):
        return self.add(other)
    cpdef MInt sub(self, MInt other):
        return MInt((self._thisptr[0] - other._thisptr[0]).val())
    def __sub__(self, other):
        return self.sub(other)
    cpdef MInt mul(self, MInt other):
        return MInt((self._thisptr[0] * other._thisptr[0]).val())
    def __mul__(self, other):
        return self.mul(other)
