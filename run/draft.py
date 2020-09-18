from atcoder import ReadInt, TwoSat, PrintLongN

def main():
  N,D=ReadInt(2)
  xy = ReadInt(2*N)
  ts=TwoSat(N)
  for i in range(N-1):
    for j in range(i+1,N):
      for k1,k2 in [(0,0),(0,1),(1,0),(1,1)]:
        pos1,pos2 = xy[2*i+k1],xy[2*j+k2]
        if abs(pos2-pos1)<D:
          ts.add_clause(i,k1^1,j,k2^1)
 
  if ts.satisfiable():
    print('Yes')
    ans = ts.answer()
    ans = [xy[2*i+ans[i]] for i in range(N)]
    PrintLongN(ans, len(ans))
  else:
    print('No')
    
if __name__=="__main__":
  main()