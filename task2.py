import re
Person = []
w = open('porlogfl.pl', 'w')
with open('Tree.ged') as f:
  for line in f:
    if re.search(r'GIVN',line):
      name = line[7:]
      name = name.replace("\n", "")
      r = f.readline()
      surn = r[7:]
      surn = surn.replace("\n", "")
      Person.append(name+"_"+surn)
      r = f.readline()
      s = r[6:]
      s = s.replace("\n", "")
      sex ="sex(" + name+"_"+ surn+ ", "+ s+ ").\n"
      w.write(sex)
    if re.search(r'HUSB',line):
      k = int(line[14])
      r = f.readline()
      m = int(r[14])
      r = f.readline()
      n =  int(r[14])
      parent = "parent("+Person[k-1]+", "+Person[n-1]+").\n"
      w.write(parent)
      parent = "parent("+Person[m-1]+", "+Person[n-1]+").\n"
      w.write(parent)
      r = f.readline()
f.close()
w.close()
