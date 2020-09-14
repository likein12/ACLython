import sys
from atcoder import SccGraph, MfGraph

read = sys.stdin.buffer.read
readline = sys.stdin.buffer.readline
readlines = sys.stdin.buffer.readlines
 
N, M = list(map(int, readline().split()))
AB = [list(map(int, readline().split())) for i in range(M)]

SccGraph(3)