# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False
cdef extern from "<atcoder/math>" namespace "atcoder":
    long long floor_sum(long long n, long long m, long long a, long long b)

cpdef long long FloorSum(long long n, long long m, long long a, long long b):
    return floor_sum(n, m, a, b)
