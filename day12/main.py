from queue import PriorityQueue

def read_input():
    grid = []
    start,end = None,None
    with open('day12/inputs/12') as f:
        for row,l in enumerate(f.read().splitlines()): 
            string = ""    
            for col,c in enumerate(l):
                if c == 'S':
                    c = 'a'
                    start = (row,col)
                elif c == 'E':
                    c = 'z'
                    end = (row,col) 
                string += c 
            grid.append(string)
    return grid,start,end

def get_neighbours(data, pos):
    neighbours = []
    for i, j in [(0,1), (0,-1), (1,0), (-1,0)]:
        if 0 <= pos[0] + i < len(data) and 0 <= pos[1] + j < len(data[0]): 
            u = data[pos[0]][pos[1]]
            v = data[pos[0]+i][pos[1]+j]
            if ord(u) + 1 >= ord(v):
                neighbours.append((pos[0] + i, pos[1] + j))
    return neighbours

def solve1(data, start,end ):
    visited = set()
    q = PriorityQueue()
    q.put((0, start))
    while not q.empty():
        cost, pos = q.get()
        if pos == end:
            return cost
        if pos in visited:
            continue
        visited.add(pos)
        for n in get_neighbours(data, pos):
            q.put((cost + 1, n))
    return float('inf')
def solve2(data, start,end ):
    flatten = lambda l: [item for sublist in l for item in sublist]
    candidates = flatten([[(row,col) for col,val in enumerate(x) if val == 'a'] for row,x in enumerate(data)])
    minim = float('inf')
    for candidate in candidates:
        minim = min(minim, solve1(data,candidate,end))
    return minim

print(solve1(*read_input()))
print(solve2(*read_input()))