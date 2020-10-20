# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
from libcpp.vector cimport vector
from libcpp.unordered_set cimport unordered_set
from libcpp.unordered_map cimport unordered_map
from libcpp.algorithm cimport sort
from libcpp.utility cimport pair
from cython.operator cimport preincrement
from cython.operator cimport dereference
cdef extern from *:
    ctypedef long long ll "long long"

cpdef pair[vector[ll], unordered_map[ll, int]] Compression(vector[ll] l):
    cdef unordered_set[ll] *s = new unordered_set[ll]()
    cdef int i = 0
    cdef int lsize = int(l.size())
    while i < lsize:    
        s.insert(l.at(i))
        i += 1
    cdef vector[ll] *v = new vector[ll]()
    cdef int ssize = s.size()
    cdef unordered_set[ll].iterator itr = s.begin()
    i = 0
    while i < ssize:
        v.push_back(dereference(itr))
        i += 1
        preincrement(itr)
    sort(v.begin(),v.end())

    cdef unordered_map[ll,int] *umap = new unordered_map[ll,int]()
    i = 0
    while i < ssize:
        umap[0][v.at(i)] = i
        i += 1
    cdef pair[vector[ll], unordered_map[ll, int]] *p = new pair[vector[ll], unordered_map[ll, int]](v[0], umap[0])
    return p[0]