from atcoder import Read, ReadInt

def smax(a,b):
    return a if a>b else b

def analyze(S):
    max_r = 0
    r = 0
    for i in range(len(S)):
        if S[i]=="(":
            r-=1
        else:
            r+=1
            max_r = smax(r,max_r)
    max_l = 0
    l = 0
    for i in range(len(S)):
        if S[len(S)-i-1]==")":
            l-=1
        else:
            l+=1
            max_l = smax(l,max_l)
    return max_r, max_l


def main():
    N = ReadInt(1)[0]
    res = [Read() for i in range(N)]
    res.sort(lambda x:x[0])
    res.sort(lambda x:x[1],reverse=True)



if __name__=="__main__":
    main()