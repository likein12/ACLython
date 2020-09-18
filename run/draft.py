from atcoder import MultiSet, ReadInt

def main():
    ms = MultiSet()
    N = ReadInt(1)[0]
    for i in range(N):
        A = ReadInt(1)[0]
        if ms.empty():
            ms.add(A)
            continue
        if A <= ms.min():
            ms.add(A)
        else:
            b = ms.lower_bound(A)
            if b is None:
                ms.pop_max()
                ms.add(A)
            else:
                c = ms.prev(b)
                ms.remove(c)
                ms.add(A)
    print(ms.size())

if __name__ == "__main__":
    main()