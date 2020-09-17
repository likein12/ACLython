from atcoder import SccGraph, readInt

def main():
    N, M = readInt(2)
    sg = SccGraph(N)
    for i in range(M):
        a, b = readInt(2)
        sg.add_edge(a, b)
    ans = sg.scc()
    print(len(ans))
    for i in range(len(ans)):
        print(len(ans[i]),*ans[i])

main()