def read_input():
    str = []
    with open('day6/inputs/6') as f:
        while True:
            c = f.read(1)
            if not c:
                return str
            str.append(c)

def valid(str):
    return len(set(str)) == len(str)

def solve1(str):
    tracker = [] * 4
    for (i,c) in enumerate(str):
        tracker += c 
        if (l := len(tracker) == 4) and not (v := valid(tracker)):
            tracker.pop(0)
        elif l and v:
            return i + 1
def solve2(str):
    tracker = [] * 4
    for (i,c) in enumerate(str):
        tracker += c 
        if (l := len(tracker) == 14) and not (v := valid(tracker)):
            tracker.pop(0)
        elif l and v:
            return i + 1
            
        
def main():
    input = read_input()
    print(solve1(input))
    print(solve2(input))
main()