from atcoder import ReadInt, LazySegTree, PrintLongN

def main():
    N,Q = ReadInt(2)

    A = ReadInt(N)
    ans = []
    AS = [[a,1] for a in A]
    ST = LazySegTree(AS)
    for i in range(Q):
        t = ReadInt(1)[0]
        if t==0:
            l,r,c,d = ReadInt(4)
            ST.apply_range(l,r,[c,d])
        else:
            l,r = ReadInt(2)
            ans.append(ST.prod(l,r)[0])
    PrintLongN(ans,len(ans))


if __name__=="__main__":
    main()