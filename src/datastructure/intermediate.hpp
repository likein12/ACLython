
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
