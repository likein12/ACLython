import sys
try:
    import pyperclip
except:
    print("pyperclip could not be imported.")
    sys.exit(0)

try:
    pyperclip.copy("\n".join([line.rstrip() for line in open("./Main.py", "r")]))
except:
    print("pyperclip.copy failed.")
    sys.exit(0)

print("Main.py was written in the clipboard.")