from atcoder import Read, SuffixArray, LcpArray

def main():
    S = Read(1)[0]
    sa = SuffixArray(S)
    ans = (len(S) * (len(S)+1))//2
    for x in LcpArray(S, sa):
        ans -= x
    print(ans)
if __name__=="__main__":
    main()