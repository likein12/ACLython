# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp cimport bool
from libcpp.vector cimport vector
cdef extern from "<atcoder/segtree>" namespace "atcoder" nogil: 
    cdef cppclass segtree[S, OP, E]: 
        segtree(vector[S] v)
        void set(int p, S x)
        S get(int p)
        S prod(int l, int r)
        S all_prod()
        int max_right[F](int l)
        int min_left[F](int r)

cdef extern from *
    ctypedef long minop "min_op"
    ctypedef long maxop "max_op"
    ctypedef long addop "add_op"
    cdef long min_op(long a, long b) nogil
    cdef long max_op(long a, long b) nogil
    cdef long add_op(long a, long b) nogil

    ctypedef long mine "min_e"
    ctypedef long maxe "max_e"
    ctypedef long adde "add_e"
    cdef long min_e() nogil
    cdef long max_e() nogil
    cdef long add_e() nogil

    ctypedef long minf "min_f"
    ctypedef long maxf "max_f"
    ctypedef long addf "add_f"
    cdef long comp(long k) nogil

cdef long min_op(long a, long b) nogil:
    if a > b: return b
    else: return a

cdef long max_op(long a, long b) nogil:
    if a < b: return b
    else: return a

cdef long add_op(long a, long b) nogil:
    return a + b

cdef long min_e() nogil:
    return -9223372036854775808

cdef long max_e() nogil:
    return 9223372036854775807

cdef long add_e() nogil:
    return 0

cdef long comp(int k) nogil:
    return k < v

cdef class SegTreeMin:
    cdef segtree[long, minop, mine] *_thisptr
    def __cinit__(self, vector[long] v):
        self._thisptr = new segtree[long, minop, mine](v)
    cpdef void set(self, int p, long x):
        self._thisptr.set(p, x)
    cpdef long get(self, int p):
        return self._thisptr.get(p)
    cpdef long prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef long all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l):
        return self._thisptr.max_right[comp](l)
    cpdef int min_left[comp](self, int r):
        return self._thisptr.min_left[comp](r)

cdef class SegTreeMax:
    cdef segtree[long, maxop, maxe] *_thisptr
    def __cinit__(self, vector[long] v):
        self._thisptr = new segtree[long, maxop, maxe](v)
    cpdef void set(self, int p, long x):
        self._thisptr.set(p, x)
    cpdef long get(self, int p):
        return self._thisptr.get(p)
    cpdef long prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef long all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l):
        return self._thisptr.max_right[comp](l)
    cpdef int min_left[comp](self, int r):
        return self._thisptr.min_left[comp](r)

cdef class SegTreeAdd:
    cdef segtree[long, addop, adde] *_thisptr
    def __cinit__(self, vector[long] v):
        self._thisptr = new segtree[long, addop, adde](v)
    cpdef void set(self, int p, long x):
        self._thisptr.set(p, x)
    cpdef long get(self, int p):
        return self._thisptr.get(p)
    cpdef long prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef long all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l):
        return self._thisptr.max_right[comp](l)
    cpdef int min_left[comp](self, int r):
        return self._thisptr.min_left[comp](r)

def SegTree(v, op):
    if op == "min":
        return SegTreeMin(v)
    elif op == "max":
        return SegTreeMax(v)
    elif op == "add":
        return SegTreeAdd(v)
