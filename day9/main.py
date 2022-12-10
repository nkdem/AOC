X, Y = 0, 1
def read_input():
    arr = []
    with open('day9/inputs/9') as f:
        while (l := f.readline().split()):
            arr.append([l[0], int(l[1])])
    return arr 

def adjacent(head,tail):
    return abs(head[X] - tail[X]) <= 1 and abs(head[Y] - tail[Y]) <= 1

def up(cords):
    cords[Y] += 1
def right(cords):
    cords[X] += 1
def down(cords):
    cords[Y] -= 1
def left(cords):
    cords[X] -= 1
def solve1(instrs):
    head = [0,0]
    tail = [0,0]
    visited = {(0,0): True}
    for (pos, steps) in instrs:
        initial = head
        while (steps > 0):
            initial = head.copy()
            match pos:
                case 'U':
                    up(head)
                case 'R':
                    right(head)
                case 'D':
                    down(head)
                case 'L':
                    left(head)
            steps -= 1
            if not adjacent(head,tail):
                tail = initial
            visited[(tail[X], tail[Y])] = True
    print(len(visited))
            

                

def main():
    solve1(read_input())

main()