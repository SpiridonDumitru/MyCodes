#!/usr/bin/python3
import re
string = '''text before Abc 2:5a; 24:51d, 53; 1:9b, 22-23; 1:22-23c, 9; 1:22-23, 24-25;
text before (Def 2:5a; 24:51d, 53; 1:9b, 22-23; 1:22-23c, 9; 1:22-23, 24-25)
text before (3Gh 2:5a; 24:51d, 53; 1:9b, 22-23; 1:22-23c, 9; 1:22-23, 24-25)
text before 3Mo 2:5a; 24:51d, 53; 1:9b, 22-23; 1:22-23c, 9; 1:22-23, 24-25;
'''
pattern = '\b(\w{3})((?:\s[\d-]+:?[-\da-z]*[;,]?)+)'

#compute and apply the replacement:
sub_group_pat = re.compile(r"[\d-]+:?[-da-z]*[;,]?")
for prefix, block in re.findall(r"\b(\w{3})((?:\s[\d-]+:?[-\da-z]*[;,]?)+)", s):
    subgroups = sub_group_pat.findall(block)
    result = prefix + " " + f" {prefix} ".join(subgroups)
    s = s.replace(prefix + block , result)
print(result)
