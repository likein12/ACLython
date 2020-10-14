import re
import os

cython_code = """
# distutils: language=c++
# distutils: include_dirs=[/home/USERNAME/.local/lib/python3.8/site-packages/numpy/core/include, /opt/ac-library]
# cython: boundscheck=False
# cython: wraparound=False
"""

class_path_dict = {}

for line in open("../meta/class.csv", "r"):
    items = line.rstrip().split(",")
    if len(items)==2:
        class_name, path = items
        class_path_dict[class_name] = path

def read_class(class_path):
    class_code = []
    lib_set = set()
    for line in open(class_path, "r"):
        if not (re.match(r' *#',line.rstrip()) is None):
            continue
        if not (re.match(r'\t*from +\S+ +cimport +\S',line.rstrip()) is None):
            lib_set.add(line.strip())
        else:
            class_code.append(line.rstrip())
    return "\n".join(class_code), lib_set

class_code_list = []
lib_set = set()

class_path_set = set([class_path for _, class_path in class_path_dict.items()])

for class_path in class_path_set:
    class_code, ls = read_class(os.path.join("../src",class_path))
    class_code_list.append(class_code)    
    lib_set = lib_set | ls

cython_code += "\n".join(list(lib_set)) + "\n" + "\n".join(class_code_list)

open("atcoder.pyx", "w").write(cython_code)

os.system('cythonize -i -3 -b atcoder.pyx')