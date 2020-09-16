header_code = """
#include <vector>
#include <algorithm>
#include <cassert>
#include <vector>

namespace aclython {

int ceil_pow2(int n) {
    int x = 0;
    while ((1U << x) < (unsigned int)(n)) x++;
    return x;
}

template <class S, S (*op)(S, S), S (*e)()> struct segtree {
  public:
    segtree() : segtree(0) {}
    segtree(int n) : segtree(std::vector<S>(n, e())) {}
    segtree(const std::vector<S>& v) : _n(int(v.size())) {
        log = ceil_pow2(_n);
        size = 1 << log;
        d = std::vector<S>(2 * size, e());
        for (int i = 0; i < _n; i++) d[size + i] = v[i];
        for (int i = size - 1; i >= 1; i--) {
            update(i);
        }
    }

    void set(int p, S x) {
        assert(0 <= p && p < _n);
        p += size;
        d[p] = x;
        for (int i = 1; i <= log; i++) update(p >> i);
    }

    S get(int p) {
        assert(0 <= p && p < _n);
        return d[p + size];
    }

    S prod(int l, int r) {
        assert(0 <= l && l <= r && r <= _n);
        S sml = e(), smr = e();
        l += size;
        r += size;

        while (l < r) {
            if (l & 1) sml = op(sml, d[l++]);
            if (r & 1) smr = op(d[--r], smr);
            l >>= 1;
            r >>= 1;
        }
        return op(sml, smr);
    }

    S all_prod() { return d[1]; }

    template <bool (*f)(S)> int max_right(int l, S b) {
        return max_right(l, b, [](S x, S y) { return f(x, y); });
    }
    template <class F> int max_right(int l, S b, F f) {
        assert(0 <= l && l <= _n);
        assert(f(e()));
        if (l == _n) return _n;
        l += size;
        S sm = e();
        do {
            while (l % 2 == 0) l >>= 1;
            if (!f(op(sm, d[l]), b)) {
                while (l < size) {
                    l = (2 * l);
                    if (f(op(sm, d[l]), b)) {
                        sm = op(sm, d[l]);
                        l++;
                    }
                }
                return l - size;
            }
            sm = op(sm, d[l]);
            l++;
        } while ((l & -l) != l);
        return _n;
    }

    template <bool (*f)(S)> int min_left(int r, S b) {
        return min_left(r, b, [](S x, S y) { return f(x, y); });
    }
    template <class F> int min_left(int r, S b, F f) {
        assert(0 <= r && r <= _n);
        assert(f(e()));
        if (r == 0) return 0;
        r += size;
        S sm = e();
        do {
            r--;
            while (r > 1 && (r % 2)) r >>= 1;
            if (!f(op(d[r], sm), b)) {
                while (r < size) {
                    r = (2 * r + 1);
                    if (f(op(d[r], sm), b)) {
                        sm = op(d[r], sm);
                        r--;
                    }
                }
                return r + 1 - size;
            }
            sm = op(d[r], sm);
        } while ((r & -r) != r);
        return 0;
    }

  private:
    int _n, size, log;
    std::vector<S> d;

    void update(int k) { d[k] = op(d[2 * k], d[2 * k + 1]); }
};



int min_op(int n, int m){
    return std::min(n, m);
}

int min_e(){
    return (int)1e9;
}

struct segtree_min {
    public:
        segtree_min() : segtree_min(0) {}
        segtree_min(int n) : segtree_min(std::vector<int>(n, min_e())) {}
        segtree_min(const std::vector<int>& vec) : seg(vec) {}

        void set(int p, int x) {seg.set(p, x);}
        int get(int p) {return seg.get(p);}
        int prod(int l, int r) {return seg.prod(l, r);}
        int all_prod() {return seg.all_prod();}

        int max_right(int l, int v) {return seg.max_right(l, v, [](int x, int y) { return x<y; });}
        int min_left(int r, int v) {return seg.min_left(r, v, [](int x, int y) { return x<y; });}

    private:
        segtree<int, min_op, min_e> seg;
};

int max_op(int n, int m){
    return std::max(n, m);
}

int max_e(){
    return 0;
}

struct segtree_max {
    public:
        segtree_max() : segtree_max(0) {}
        segtree_max(int n) : segtree_max(std::vector<int>(n, max_e())) {}
        segtree_max(const std::vector<int>& vec) : seg(vec) {}

        void set(int p, int x) {seg.set(p, x);}
        int get(int p) {return seg.get(p);}
        int prod(int l, int r) {return seg.prod(l, r);}
        int all_prod() {return seg.all_prod();}

        int max_right(int l, int v) {return seg.max_right(l, v, [](int x, int y) { return x<y; });}
        int min_left(int r, int v) {return seg.min_left(r, v, [](int x, int y) { return x<y; });}

    private:
        segtree<int, max_op, max_e> seg;
};


}
"""

code = """

# distutils: language=c++
# distutils: include_dirs=[/home/USERNAME/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False

from libc.stdio cimport getchar, printf
from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp cimport bool
cpdef inline vector[int] ReadInt(int n):
    cdef int b, c
    cdef vector[int] *v = new vector[int]()
    for i in range(n):
        c = 0
        while 1:
            b = getchar() - 48
            if b < 0: break
            c = c * 10 + b
        v.push_back(c)
    return v[0]

cpdef inline vector[string] Read(int n):
    cdef char c
    cdef vector[string] *vs = new vector[string]()
    cdef string *s
    for i in range(n):
        s = new string()
        while 1:
            c = getchar()
            if c<=32: break
            s.push_back(c)
        vs.push_back(s[0])
    return vs[0]

cpdef inline void PrintLongN(vector[long] l, int n):
    for i in range(n): printf("%ld\\n", l[i])

cpdef inline void PrintLong(vector[long] l, int n):
    for i in range(n): printf("%ld ", l[i])
cdef extern from "./intermediate.hpp" namespace "aclython" nogil:
    cdef cppclass segtree_min:
        segtree_min(vector[int] v)
        void set(int p, int x)
        int get(int p)
        int prod(int l, int r)
        int all_prod()
        int max_right(int l, int v)
        int min_left(int r, int v)

cdef class SegTreeMin:
    cdef segtree_min *_thisptr
    def __cinit__(self, vector[int] v):
        self._thisptr = new segtree_min(v)
    cpdef void set(self, int p, int x):
        self._thisptr.set(p, x)
    cpdef int get(self, int p):
        return self._thisptr.get(p)
    cpdef int prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef int all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l, int v):
        return self._thisptr.max_right(l, v)
    cpdef int min_left(self, int r, int v):
        self._thisptr.min_left(r, v)

cdef extern from "./intermediate.hpp" namespace "aclython" nogil:
    cdef cppclass segtree_max:
        segtree_max(vector[int] v)
        void set(int p, int x)
        int get(int p)
        int prod(int l, int r)
        int all_prod()
        int max_right(int l, int v)
        int min_left(int r, int v)

cdef class SegTreeMax:
    cdef segtree_max *_thisptr
    def __cinit__(self, vector[int] v):
        self._thisptr = new segtree_max(v)
    cpdef void set(self, int p, int x):
        self._thisptr.set(p, x)
    cpdef int get(self, int p):
        return self._thisptr.get(p)
    cpdef int prod(self, int l, int r):
        return self._thisptr.prod(l, r)
    cpdef int all_prod(self):
        return self._thisptr.all_prod()
    cpdef int max_right(self, int l, int v):
        return self._thisptr.max_right(l, v)
    cpdef int min_left(self, int r, int v):
        self._thisptr.min_left(r, v)


def SegTree(v, op):
    if op=="min":
        return SegTreeMin(v)
    elif op=="max":
        return SegTreeMax(v)

"""


import os, sys, getpass

if sys.argv[-1] == 'ONLINE_JUDGE':
    code = code.replace("USERNAME", getpass.getuser())
    open('intermediate.hpp','w').write(header_code)
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
    sys.exit(0)


from atcoder import ReadInt, SegTree, PrintLongN

N,Q = ReadInt(2)
ST = SegTree(ReadInt(N), "max")

ans = []
for i in range(Q):
    T = ReadInt(1)[0]
    if T==1:
        X,V = ReadInt(2)
        X -= 1
        ST.set(X,V)
    elif T==2:
        L,R = ReadInt(2)
        ans.append(ST.prod(L-1,R))
    else:
        X,V = ReadInt(2)
        X -= 1
        ans.append(ST.max_right(X,V)+1)
PrintLongN(ans,len(ans))