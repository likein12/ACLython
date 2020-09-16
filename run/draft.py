from atcoder import ReadInt, SegTree, PrintLongN

N,Q = ReadInt(2)
ST = SegTree(ReadInt(N), "max")

ans = []
for i in range(Q):
    T = ReadInt(1)[0]
    if T==1:
        X,V = ReadInt(2)
        X -= 1
        ST.set(X,V)
    elif T==2:
        L,R = ReadInt(2)
        ans.append(ST.prod(L-1,R))
    else:
        X,V = ReadInt(2)
        X -= 1
        ans.append(ST.max_right(X,V)+1)
PrintLongN(ans,len(ans))