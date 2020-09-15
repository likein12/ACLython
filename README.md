# ACLython

自動でACLをwrapしてAtCoderに提出できるようにします。

## 使用可能な関数やクラス


|  wrapper名  |  ACL  | 開発済 |
| ---- | ---- | ---- | 
|Conv|convolution|〇|
|Dsu|dsu|〇|
|FenwickTree|fenwick_tree|〇|
|LazySegTree|lazy_segtree| |
|SegTree|segtree| |
|MfGraph|mf_graph|〇|
|SccGraph|scc_graph|〇|

他のライブラリも鋭意作成中。

## 使い方

###  導入法

gitで好きなディレクトリにダウンロードしてください。

```
$ git clone https://github.com/likein12/ACLython.git
```

### コードの自動生成

```run/draft.py```中に提出コードを書きます。例えば以下のようなコードを書いたとします。

```
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
```

ACLをwrapして作られたクラスや関数は全て```atcoder```モジュールから```import```できます。この例ではACLの```atcoder::fenwick_tree```のwrapperである```FenwickTree```を```import```しています。

書けたら```run/submission_maker.py```をpythonで実行してください。

```
$ cd ACLython/run
$ python submission_maker.py
```

すると```run/Main.py```に以下のようなコードが出力されます。

```
code = """

# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
# cython: boundscheck=False
# cython: wraparound=False


cdef extern from "<atcoder/fenwicktree>" namespace "atcoder" nogil:
    cdef cppclass fenwick_tree[T]:
        fenwick_tree(int n)
        void add(int p, T x)
        T sum(int l, int r)

cdef class FenwickTree:
    cdef fenwick_tree[long long] *_thisptr
    def __cinit__(self, int n):
        self._thisptr = new fenwick_tree[long long](n)
    cpdef void add(self, int p, long long x):
        self._thisptr.add(p, x)
    cpdef long long sum(self, int l, int r):
        return self._thisptr.sum(l, r)
"""


import os,sys
if sys.argv[-1] == 'ONLINE_JUDGE':
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')


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
```

これをAtCoderに提出してください。 言語はPython3.8.2です。

提出例：https://atcoder.jp/contests/practice2/submissions/16754274

### ローカルでのテスト

ローカル環境でテストを行えるようにします。このような環境を作っておくとデバッグが容易になります。ローカル環境は以下のように構築したものを使いました。

#### 環境

参考 : https://docs.google.com/spreadsheets/d/1PmsqufkF3wjKN6g1L0STS80yP4a6u-VdGiEv5uOHe0M/

- WSL 2 Ubuntu 18.04
- Python 3.8
- Cython

#### Python環境の構築

```
$ sudo add-apt-repository -y ppa:deadsnakes/ppa
$ sudo apt install -y python3.8 python3.8-dev python3-pip
$ python3.8 -m pip install -U Cython numba numpy scipy scikit-learn networkx
```

注 : cythonizeコマンドを使えるようにする必要があり、```$ echo export PATH='/usr/.local/bin:$PATH' >> ~/.bash_profile```でPATHを追加してあげる必要があるかもしれません。

#### ACLをWSL内にコピー

適当なディレクトリにACLをダウンロードします。

```
$ git clone https://github.com/atcoder/ac-library.git
$ sudo cp -r ./ac-library /opt/atcoder-stl
```
#### ローカルテスト

```/run/draft.py```にコードを書き、```input/input.txt```に入力をコピペします。```ACLython/run```に移動して```judge.sh```を実行すると、AtCoderのjudgeと同じ流れでテストができます。

```
$ ./judge.sh

Judge Started

Compiling /home/***/ACLython/run/atcoder.pyx because it changed.
[1/1] Cythonizing /home/***/ACLython/run/atcoder.pyx
running build_ext
building 'atcoder' extension
creating /home/***/ACLython/run/tmp69u3mb61/home
creating /home/***/ACLython/run/tmp69u3mb61/home/***
creating /home/***/ACLython/run/tmp69u3mb61/home/***/ACLython
creating /home/***/ACLython/run/tmp69u3mb61/home/***/ACLython/run
x86_64-linux-gnu-gcc -pthread -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O2 -Wall -g -fstack-protector-strong -Wformat -Werror=format-security -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -I/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include -I/opt/atcoder-stl -I/usr/include/python3.8 -c /home/***/ACLython/run/atcoder.cpp -o /home/***/ACLython/run/tmp69u3mb61/home/***/ACLython/run/atcoder.o
x86_64-linux-gnu-g++ -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-functions -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-Bsymbolic-functions -Wl,-z,relro -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 /home/***/ACLython/run/tmp69u3mb61/home/***/ACLython/run/atcoder.o -o /home/***/ACLython/run/atcoder.cpython-38-x86_64-linux-gnu.so

====================================
input
====================================
5 5
1 2 3 4 5
1 0 5
1 2 4
0 3 10
1 0 5
1 0 3
====================================
output
====================================
15
7
25
6

real    0m0.096s
user    0m0.031s
sys     0m0.063s
====================================
```

## 悪いところ

まだ碌に検証できてません。

## やりたいこと

- テストの作成
- ACLのwrap
- C++のSTLのwrap
- VS Codeなどでインテリセンスで補完できるようにする