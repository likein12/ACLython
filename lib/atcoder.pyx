

# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False

from libcpp.vector cimport vector
from libcpp cimport bool
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
