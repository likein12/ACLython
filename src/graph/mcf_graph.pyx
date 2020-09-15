# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
from libcpp.utilty cimport pair
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
    cpdef int add_edge(self, int fr, int to, int cap, Cost cost):
        return self._thisptr.add_edge(fr, to, cap, cost)
    cpdef pair[int, ll] flow(self, int s, int t):
        return self._thisptr.flow(s, t)
    cpdef pair[int, ll] flow_with_limit(self, int s, int t, int flow_limit):
        return self._thisptr.flow(s, t, flow_limit)

    # 20.9.15ここまで
    cpdef vector[pair[int, ll]] get_edge(self, int i):
        cdef mf_graph[int].edge *e = new mcf_graph[int, ll].edge(self._thisptr.get_edge(i))
        cdef vector[pair, ll] *ret_e = new vector[int]()        
        ret_e.push_back(e.frm)
        ret_e.push_back(e.to)
        ret_e.push_back(e.cap)
        ret_e.push_back(e.flow)
        return ret_e[0]

    cpdef vector[pair[int, ll]] edges(self):
        cdef vector[mf_graph[int].edge] es = self._thisptr.edges()
        cdef vector[vector[int]] *ret_es = new vector[vector[int]](es.size())
        for i in range(es.size()):
            ret_es.at(i).push_back(es.at(i).frm)
            ret_es.at(i).push_back(es.at(i).to)
            ret_es.at(i).push_back(es.at(i).cap)
            ret_es.at(i).push_back(es.at(i).flow)
        return ret_es[0]
