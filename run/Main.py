header_code = """













#include "/opt/atcoder-stl/atcoder/internal_bit.hpp"
#include "/opt/atcoder-stl/atcoder/lazysegtree.hpp"
#include "/opt/atcoder-stl/atcoder/modint.hpp"
#include <vector>
#include <algorithm>
#include <cassert>

namespace aclython {

template <class S, S (*op)(S, S), S (*e)()> struct segtree {
  public:
    segtree() : segtree(0) {}
    segtree(int n) : segtree(std::vector<S>(n, e())) {}
    segtree(const std::vector<S>& v) : _n(int(v.size())) {
        log = atcoder::internal::ceil_pow2(_n);
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

using mint = atcoder::modint998244353;

struct S {
    mint a;
    int size;
    S(mint _a, int _size) : a(_a) ,size(_size) {}
    S(int _a, int _size) : a(_a) ,size(_size) {}
    S(const S &s) : a(s.a), size(s.size) {}
    int get_a() { return (int)a.val(); }
};

struct F {
    mint a, b;
    F(mint _a, mint _b) : a(_a), b(_b) {}
    F(int _a, int _b) : a(_a), b(_b) {}
    F(const F &f) : a(f.a), b(f.b) {}
    int get_a() { return (int)a.val(); }
    int get_b() { return (int)b.val(); }
};

S op(S l, S r) { return S{l.a + r.a, l.size + r.size}; }

S e() { return S{0, 0}; }

S mapping(F l, S r) { return S{r.a * l.a + r.size * l.b, r.size}; }

F composition(F l, F r) { return F{r.a * l.a, r.b * l.a + l.b}; }

F id() { return F{1, 0}; }

struct lazy_segtree{
    lazy_segtree() : lazy_segtree(0) {}
    lazy_segtree(int n) : lazy_segtree(std::vector<S>(n, e())) {}
    lazy_segtree(const std::vector<S>& vec) : seg(vec) {}
    void set(int p, S x) { seg.set(p, x); }
    S get(int p) { return seg.get(p); }
    S prod(int l, int r) { return seg.prod(l, r); }
    S all_prod() { return seg.all_prod(); }
    void apply(int p, F f) { seg.apply(p, f); }
    void apply(int l, int r, F f) { seg.apply(l, r, f); }
    private:
        atcoder::lazy_segtree<S, op, e, F, mapping, composition, id> seg;
};

}
"""

code = """

# distutils: language=c++
# distutils: include_dirs=[/home/USERNAME/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False

from libc.stdio cimport getchar, printf
from libcpp.vector cimport vector
from libcpp.string cimport string
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
"""


import os, sys, getpass

if sys.argv[-1] == 'ONLINE_JUDGE':
    code = code.replace("USERNAME", getpass.getuser())
    open('intermediate.hpp','w').write(header_code)
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
    sys.exit(0)


from atcoder import SccGraph, ReadInt

def main():
    N, M = ReadInt(2)
    sg = SccGraph(N)
    for i in range(M):
        a, b = ReadInt(2)
        sg.add_edge(a, b)
    ans = sg.scc()
    print(len(ans))
    for i in range(len(ans)):
        print(len(ans[i]),*ans[i])

if __name__=="__main__":
    main()