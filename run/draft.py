from atcoder import ReadInt,PrintLongN
from collections import Counter

def main():

    N,Q = ReadInt(2)
    s = Set()
    c = Counter(ReadInt(N))
    for k in c:
        if c[k]%2==1:
            s.add(k)

    ans = []

    for i in range(Q):
        l,r,x = ReadInt(3)
        g = s.lower_bound(l)
        a = 0
        count = 0
        if g is not None:
            while g <= r:
                a ^= g
                count += 1
                g1 = s.next(g)
                s.remove(g)
                g = g1
                if g is None:
                    break
        if count%2==1:
            if x in s:
                s.remove(x)
            else:
                s.add(x)
        ans.append(a)

    PrintLongN(ans)

if __name__ == "__main__":
    main()