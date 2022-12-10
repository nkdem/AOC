X, Y = 0, 1
def read_input():
    arr = []
    with open('day9/inputs/9') as f:
        while (l := f.readline().split()):
            arr.append([l[0], int(l[1])])
    return arr 

def adjacent(head,tail):
    return abs(head[X] - tail[X]) <= 1 and abs(head[Y] - tail[Y]) <= 1

def move(cords, pos):
    match pos:
        case 'U': cords[Y] += 1
        case 'R': cords[X] += 1
        case 'D': cords[Y] -= 1
        case 'L': cords[X] -= 1
def solve1(instrs):
    head = [0,0]
    tail = [0,0]
    visited = {(0,0): True}
    for (pos, steps) in instrs:
        while (steps > 0):
            initial = head.copy()
            move(head,pos)
            steps -= 1
            if not adjacent(head,tail):
                tail = initial
            visited[(tail[X], tail[Y])] = True
    print(len(visited))

def main():
    solve1(read_input())

main()