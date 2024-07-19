import sys

lines = []
for line in sys.stdin:
  if line.strip() != "":
    lines.append(line.strip())
print(f"#const nrows={lines[0]}.\n#const ncols={lines[1]}.")
print(f"dim({lines[0]},{lines[1]}).")

i = 0
for line in lines[2:]:
  j = 0
  for c in line:
    if c.islower():
      print(f"end({c},c({i},{j})).")
    elif c == '#':
      print(f"obs({i},{j}).")
    j += 1
  i += 1
