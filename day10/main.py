def solve1():
    x = 1
    strength = 0
    with open('day10/inputs/10') as f:
        cycle = 1
        while l := f.readline().split():
            _, *val = l
            cycle += 1
            if cycle == 20 or ((cycle - 20) % 40 == 0):
                strength += x * cycle
            if val:
                x += int(val[0])
                cycle += 1
                if cycle == 20 or ((cycle - 20) % 40 == 0):
                    strength += x * cycle
            
    print(cycle)
    print(strength)
def solve2():
    image = [['.'] * 40 for _ in range(6)]
    sprite_pos = 0
    hold = 1
    delay = 0
    with open('day10/inputs/10') as f:
        for row in range(len(image)):
            for pos in range(len(image[row])):
                if delay == 0:
                    sprite_pos += hold
                    _, *val = f.readline().split()
                    if val:
                        hold = int(val[0])
                        delay = 2
                    else:
                        hold = 0
                        delay = 1
                if abs(sprite_pos - pos) <= 1:
                    image[row][pos] = '#'
                delay -= 1
    for row in image:
        print(''.join(row))
            

def main():
    solve1()
    solve2()

main()