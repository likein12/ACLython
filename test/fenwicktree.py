"""
問題
https://atcoder.jp/contests/practice2/tasks/practice2_b

提出コード
https://atcoder.jp/contests/practice2/submissions/16754274
"""
from atcoder import FenwickTree

N,Q = list(map(int,input().split()))
A = list(map(int,input().split()))
fw = FenwickTree(N)
for i, a in enumerate(A):
    fw.add(i,a)

for i in range(Q):
    a,b,c = list(map(int,input().split()))
    if a==0:
        fw.add(b,c)
    else:
        print(fw.sum(b,c))
