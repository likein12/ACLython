from atcoder import SccGraph, ReadInt

def main():
    N, M = ReadInt(2)
    sg = SccGraph(N)
    for i in range(M):
        a, b = ReadInt(2)
        sg.add_edge(a, b)
    ans = sg.scc()
    print(len(ans))
    for i in range(len(ans)):
        print(len(ans[i]),*ans[i])

if __name__=="__main__":
    main()