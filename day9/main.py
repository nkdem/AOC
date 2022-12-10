X, Y = 0, 1
def read_input():
    arr = []
    with open('day9/inputs/9') as f:
        while (l := f.readline().split()):
            arr.append([l[0], int(l[1])])
    return arr 

def adjacent(head,tail):
    return abs(head[X] - tail[X]) <= 1 and abs(head[Y] - tail[Y]) <= 1

def fix(head, tail):
    x = head[X] - tail[X]
    y = head[Y] - tail[Y]
    if abs(x) <= 1 and abs(y) <= 1:
        pass # Nothing to fix since it's a legal play 
    else:
        tail[X] += x if abs(x) <= 1 else x - (x // abs(x)) 
        tail[Y] += y if abs(y) <= 1 else y - (y // abs(y))

def move(cords, pos):
    match pos:
        case 'U': cords[Y] += 1
        case 'R': cords[X] += 1
        case 'D': cords[Y] -= 1
        case 'L': cords[X] -= 1
def solve(knots, instrs):
    knots = [[0,0] for _ in range(knots)]
    visited = {(0,0): True}
    for (pos, steps) in instrs:
        while (steps > 0):
            move(knots[0],pos)
            steps -= 1
            for i in range(len(knots) - 1):
                fix(knots[i], knots[i+1])
            visited[(knots[-1][X], knots[-1][Y])] = True
    print(len(visited))


def main():
    solve(2, read_input())
    solve(10, read_input())
main()