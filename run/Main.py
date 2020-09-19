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

from libcpp.utility cimport pair
from libcpp.string cimport string
from cython.operator cimport preincrement
from libc.stdio cimport getchar, printf
from cython.operator cimport dereference
from cython.operator cimport predecrement
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

cpdef inline void PrintLongN(vector[long] l):
    cdef int n = l.size()
    for i in range(n): printf("%ld\\n", l[i])

cpdef inline void PrintLong(vector[long] l):
    cdef int n = l.size()
    for i in range(n): printf("%ld ", l[i])
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
"""


import os, sys, getpass

if sys.argv[-1] == 'ONLINE_JUDGE':
    code = code.replace("USERNAME", getpass.getuser())
    open('intermediate.hpp','w').write(header_code)
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
    sys.exit(0)


from atcoder import MultiSet, ReadInt, PrintLongN

def main():
    N,Q = ReadInt(2)
    MS = [MultiSet() for i in range(2* (10**5))]
    mms = MultiSet()
    rate = [0]*N
    Y = [0]*N
    AB = ReadInt(2*N)
    for i in range(N):
        A,B = AB[2*i],AB[2*i+1]
        B-=1
        Y[i] = B
        rate[i] = A
        MS[B].add(A)
    ans = []
    for i in range(2*(10**5)):
        if not MS[i].empty():
            mms.add(MS[i].max())
    query = ReadInt(2*Q)
    for i in range(Q):
        C,D = query[2*i],query[2*i+1]
        C -= 1
        D -= 1
        prevD = Y[C]
        Y[C] = D
        prevMax = MS[prevD].max()
        MS[prevD].remove(rate[C])
        if MS[prevD].empty():
            mms.remove(prevMax)
        else:
            newMax = MS[prevD].max()
            if newMax!=prevMax:
                mms.remove(prevMax)
                mms.add(newMax)
        if MS[D].empty():
            MS[D].add(rate[C])
            mms.add(rate[C])
        else:
            prevMax = MS[D].max()
            MS[D].add(rate[C])
            newMax = MS[D].max()
            if newMax!=prevMax:
                mms.remove(prevMax)
                mms.add(newMax)
        ans.append(mms.min())
    PrintLongN(ans)


if __name__ == "__main__":
    main()