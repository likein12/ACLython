from atcoder import Set

s = Set()

l = [1,2,4,5,6]
for i in l:
    s.add(i)

print(s.pop_max())
print(s.pop_max())
print(s.pop_max())