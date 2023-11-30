import os 
from collections import Counter

def priority(c):
    if c.islower():
        return ord(c) - 96 
    else:
        return ord(c) - 38

def solve1():
    total = 0 
    with open(os.getcwd() + "/day3/inputs/3") as f: 
        for line in f:
            line = line.strip()
            if line:
                x = list(map(priority, line))
                mid = len(x) // 2
                c1, c2 = Counter(x[0:mid]), Counter(x[mid:])
                for c in c1:
                    if c in c2:
                        total += c
    return total
def solve2():
    total = 0 
    with open(os.getcwd() + "/day3/inputs/3") as f: 
        lines = f.read().splitlines()
        i = 0 
        while i < len(lines):
            c1 = Counter(list(map(priority, lines[i])))
            c2 = Counter(list(map(priority, lines[i+1])))
            c3 = Counter(list(map(priority, lines[i+2])))
            for c in c1:
                if c in c2 and c in c3:
                    total += c
            i += 3         
    return total
print(solve1())
print(solve2())