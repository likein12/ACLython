import re
import os
import sys
import getpass

preprocess_code = """

import os,sys

if sys.argv[-1] == 'ONLINE_JUDGE':
    open('atcoder.pyx','w').write(code)
    os.system('cythonize -i -3 -b atcoder.pyx')
    sys.exit(0)

"""
code = []
class_set = set()

for line in open("./draft.py", "r"):
    if not (re.match(r'\t*from +atcoder +import +\S+',line.rstrip()) is None):
        class_string = "".join(line.strip().split()[3:])
        class_set = class_set | set(re.split(r' *, *', class_string))
    elif not (re.match(r'\t*import +\S+',line.rstrip()) is None):
        import_string = "".join(line.strip().split()[1:])
        for class_name in re.split(r' *, *', import_string):
            if class_name.split(".")[0] == "atcoder":
                class_set.add(class_name.split(".")[1])
    code.append(line.rstrip())

code = "\n".join(code)

cython_code = """
code = \"\"\"

# distutils: language=c++
# distutils: include_dirs=[/home/contestant/.local/lib/python3.8/site-packages/numpy/core/include, /opt/atcoder-stl]
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

for class_name in class_set:
    class_code, ls = read_class(os.path.join("../src",class_path_dict[class_name]))
    class_code_list.append(class_code)    
    lib_set = lib_set | ls

cython_code += "\n".join(list(lib_set)) + "\n" + "\n".join(class_code_list) + "\n" + "\"\"\""

cython_code_local = cython_code.replace("contestant", getpass.getuser())

main_code = "\n".join([cython_code, preprocess_code, code])
main_code_local = "\n".join([cython_code_local, preprocess_code, code])

open("./Main.py", "w").write(main_code)
open("./Main_local.py", "w").write(main_code_local)

print("imported", ", ".join(class_set))

print("created Main.py and Main_local.py")