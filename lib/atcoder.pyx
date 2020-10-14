
# distutils: language=c++
# distutils: include_dirs=[/home/USERNAME/.local/lib/python3.8/site-packages/numpy/core/include, /opt/ac-library]
# cython: boundscheck=False
# cython: wraparound=False
from cython.operator cimport predecrement
from libcpp.string cimport string
from cython.operator cimport dereference
from libcpp.utility cimport pair
from libcpp.vector cimport vector
from libcpp.set cimport set
from libc.stdio cimport getchar, printf
from libcpp cimport bool
from cython.operator cimport preincrement

cdef extern from *:
    ctypedef int MOD_t "998244353"
    ctypedef long long ll "long long"

cdef extern from "<atcoder/convolution>" namespace "atcoder":
    vector[int] convolution[M](vector[int] a, vector[int] b)
    vector[ll] convolution_ll(vector[ll] a, vector[ll] b)

cpdef vector[int] Conv(vector[int] a, vector[int] b):
    return convolution[MOD_t](a, b)

cpdef vector[ll] ConvL(vector[ll] a, vector[ll] b):
    return convolution_ll(a, b)

cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] suffix_array(string s)
    vector[int] suffix_array[ll](vector[ll] s)
    vector[int] suffix_array(vector[int] s, int upper)

cpdef vector[int] SuffixArray(string s):
    return suffix_array(s)

cpdef vector[int] SuffixArrayNum(vector[ll] s):
    return suffix_array(s)

cpdef vector[int] SuffixArrayNumUp(vector[int] s, int upper):
    return suffix_array(s, upper)
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
    def lower_bound(self, ll x):
        cdef set[ll].iterator itr = self._thisptr.lower_bound(x)
        if itr == self._thisptr.end():
            return None
        else:
            return dereference(itr)
    def upper_bound(self, ll x):
        cdef set[ll].iterator itr = self._thisptr.upper_bound(x)
        if itr == self._thisptr.end():
            return None
        else:
            return dereference(itr)
    def next(self, ll x):
        if x >= self.max():
            return None
        cdef set[ll].iterator itr = self._thisptr.find(x)
        preincrement(itr)
        return dereference(itr)
    def prev(self, ll x):
        if x <= self.min():
            return None
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
cdef extern from "<atcoder/math>" namespace "atcoder":
    long long floor_sum(long long n, long long m, long long a, long long b)

cpdef long long FloorSum(long long n, long long m, long long a, long long b):
    return floor_sum(n, m, a, b)
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
cdef extern from "<atcoder/maxflow>" namespace "atcoder":
    cdef cppclass mf_graph[Cap]:
        mf_graph(int n)
        int add_edge(int fr, int to, Cap cap)
        Cap flow(int s, int t)
        Cap flow(int s, int t, Cap flow_limit)
        vector[bool] min_cut(int s)
        cppclass edge:
            int frm 'from'
            int to
            Cap cap
            Cap flow
            edge(edge &e)
        edge get_edge(int i)
        vector[edge] edges()
        void change_edge(int i, Cap new_cap, Cap new_flow)

cdef class MfGraph:
    cdef mf_graph[int] *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new mf_graph[int](n)
    cpdef int add_edge(self, int fr, int to, int cap):
        return self._thisptr.add_edge(fr, to, cap)
    cpdef int flow(self, int s, int t):
        return self._thisptr.flow(s, t)
    cpdef int flow_with_limit(self, int s, int t, int flow_limit):
        return self._thisptr.flow(s, t, flow_limit)
    cpdef vector[bool] min_cut(self, int s):
        return self._thisptr.min_cut(s)

    cpdef vector[int] get_edge(self, int i):
        cdef mf_graph[int].edge *e = new mf_graph[int].edge(self._thisptr.get_edge(i))
        cdef vector[int] *ret_e = new vector[int]()
        ret_e.push_back(e.frm)
        ret_e.push_back(e.to)
        ret_e.push_back(e.cap)
        ret_e.push_back(e.flow)
        return ret_e[0]

    cpdef vector[vector[int]] edges(self):
        cdef vector[mf_graph[int].edge] es = self._thisptr.edges()
        cdef vector[vector[int]] *ret_es = new vector[vector[int]](es.size())
        for i in range(es.size()):
            ret_es.at(i).push_back(es.at(i).frm)
            ret_es.at(i).push_back(es.at(i).to)
            ret_es.at(i).push_back(es.at(i).cap)
            ret_es.at(i).push_back(es.at(i).flow)
        return ret_es[0]
    cpdef void change_edge(self, int i, int new_cap, int new_flow):
        self._thisptr.change_edge(i, new_cap, new_flow)
cdef extern from "<atcoder/math>" namespace "atcoder":
    pair[long long, long long] crt(vector[long long] r, vector[long long] m)

cpdef pair[long long, long long] Crt(vector[long long] r, vector[long long] m):
    return crt(r, m)
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/mincostflow>" namespace "atcoder":
    cdef cppclass mcf_graph[Cap, Cost]:
        mcf_graph(int n)
        int add_edge(int fr, int to, Cap cap, Cost cost)
        pair[Cap, Cost] flow(int s, int t)
        pair[Cap, Cost] flow(int s, int t, Cap flow_limit)
        vector[pair[Cap, Cost]] slope(int s, int t)
        vector[pair[Cap, Cost]] slope(int s, int t, Cap flow_limit)
        cppclass edge:
            int frm 'from'
            int to
            Cap cap
            Cap flow
            Cost cost
            edge(edge &e)
        edge get_edge(int i)
        vector[edge] edges()

cdef class McfGraph:
    cdef mcf_graph[int, ll] *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new mcf_graph[int, ll](n)
    cpdef int add_edge(self, int fr, int to, int cap, ll cost):
        return self._thisptr.add_edge(fr, to, cap, cost)
    cpdef pair[int, ll] flow(self, int s, int t):
        return self._thisptr.flow(s, t)
    cpdef pair[int, ll] flow_with_limit(self, int s, int t, int flow_limit):
        return self._thisptr.flow(s, t, flow_limit)
    cpdef vector[pair[int, ll]] slope(self, int s, int t):
        return self._thisptr.slope(s, t)
    cpdef vector[pair[int, ll]] slope_with_limit(self, int s, int t, int flow_limit):
        return self._thisptr.slope(s, t, flow_limit)

    cpdef pair[vector[int], ll] get_edge(self, int i):
        cdef mcf_graph[int, ll].edge *e = new mcf_graph[int, ll].edge(self._thisptr.get_edge(i))
        cdef pair[vector[int], ll] *ret_e = new pair[vector[int], ll]()
        ret_e.first.push_back(e.frm)
        ret_e.first.push_back(e.to)
        ret_e.first.push_back(e.cap)
        ret_e.first.push_back(e.flow)
        ret_e.second = e.cost
        return ret_e[0]

    cpdef vector[pair[vector[int], ll]] edges(self):
        cdef vector[mcf_graph[int, ll].edge] es = self._thisptr.edges()
        cdef vector[pair[vector[int], ll]] *ret_es = new vector[pair[vector[int], ll]](es.size())
        for i in range(es.size()):
            ret_es.at(i).first.push_back(es.at(i).frm)
            ret_es.at(i).first.push_back(es.at(i).to)
            ret_es.at(i).first.push_back(es.at(i).cap)
            ret_es.at(i).first.push_back(es.at(i).flow)
            ret_es.at(i).second = es.at(i).cost
        return ret_es[0]
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
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] lcp_array(string s, vector[int] sa)
    vector[int] lcp_array[ll](vector[ll] s, vector[int] sa)

cpdef vector[int] LcpArray(string s, vector[int] sa):
    return lcp_array(s, sa)

cpdef vector[int] LcpArrayNum(vector[ll] s, vector[int] sa):
    return lcp_array(s, sa)
cdef extern from "<atcoder/fenwicktree>" namespace "atcoder" nogil:
    cdef cppclass fenwick_tree[T]:
        fenwick_tree(int n)
        void add(int p, T x)
        T sum(int l, int r)

cdef class FenwickTree:
    cdef fenwick_tree[long long] *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new fenwick_tree[long long](n)
    cpdef void add(self, int p, long long x):
        self._thisptr.add(p, x)
    cpdef long long sum(self, int l, int r):
        return self._thisptr.sum(l, r)
cdef extern from "<atcoder/dsu>" namespace "atcoder":
    cdef cppclass dsu:
        dsu(int n)
        int merge(int a, int b)
        bool same(int a, int b)
        int leader(int a)
        int size(int a)
        vector[vector[int]] groups()

cdef class Dsu:
    cdef dsu *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new dsu(n)
    cpdef int merge(self, int a, int b):
        return self._thisptr.merge(a, b)
    cpdef bool same(self, int a, int b):
        return self._thisptr.same(a, b)
    cpdef int leader(self, int a):
        return self._thisptr.leader(a)
    cpdef int size(self, int a):
        return self._thisptr.size(a)
    cpdef vector[vector[int]] groups(self):
        return self._thisptr.groups()

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

cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "./intermediate.hpp" namespace "aclython" nogil:
    cdef cppclass S:
        S(int, int)
        S(S &)
        int get_a()
        int size
    cdef cppclass F:
        F(int, int)
        F(F &)
        int get_a()
        int get_b()
    cdef cppclass lazy_segtree:
        lazy_segtree(vector[S] v)
        void set(int p, S x)
        S get(int p)
        S prod(int l, int r)
        S all_prod()
        void apply(int p, F f)
        void apply(int l, int r, F f)

cdef class LazySegTree:
    cdef lazy_segtree *_thisptr
    def __cinit__(self, vector[vector[int]] v):
        cdef int n = v.size()
        cdef vector[S] *sv = new vector[S]()
        cdef S *s
        for i in range(n):
            s = new S(v.at(i).at(0), v.at(i).at(1))
            sv.push_back(s[0])
        self._thisptr = new lazy_segtree(sv[0])
    cpdef void set(self, int p, vector[int] v):
        cdef S *s = new S(v.at(0), v.at(1))
        self._thisptr.set(p, s[0])
    cpdef vector[int] get(self, int p):
        cdef S *s = new S(self._thisptr.get(p))
        cdef vector[int] *v = new vector[int]()
        v.push_back(s.get_a())
        v.push_back(s.size)
        return v[0]
    cpdef vector[int] prod(self, int l, int r):
        cdef S *s = new S(self._thisptr.prod(l, r))
        cdef vector[int] *v = new vector[int]()
        v.push_back(s.get_a())
        v.push_back(s.size)
        return v[0]
    cpdef vector[int] all_prod(self):
        cdef S *s = new S(self._thisptr.all_prod())
        cdef vector[int] *v = new vector[int]()
        v.push_back(s.get_a())
        v.push_back(s.size)
        return v[0]
    cpdef void apply(self, int p, vector[int] v):
        cdef F *f = new F(v.at(0), v.at(1))
        self._thisptr.apply(p, f[0])
    cpdef void apply_range(self, int l, int r, vector[int] v):
        cdef F *f = new F(v.at(0), v.at(1))
        self._thisptr.apply(l, r, f[0])
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
cdef extern from *:
    ctypedef long long ll "long long"

cdef extern from "<atcoder/string>" namespace "atcoder":
    vector[int] z_algorithm(string s)
    vector[int] z_algorithm[ll](vector[ll])

def ZAlgorithm(s):
    return z_algorithm(s)

cpdef vector[int] ZAlgorithmNum(vector[ll] s):
    return z_algorithm(s)
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