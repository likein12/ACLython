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