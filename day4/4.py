def main():
    task1 = 0 
    task2 = 0
    with open('day4/inputs/4') as f:
        for line in f:
            print(line)
            line = line[:-1].split(',')
            a = list(map(int, line[0].split('-')))
            b = list(map(int, line[1].split('-')))
            x = set(range(a[0], a[1] + 1))
            y = set(range(b[0], b[1] + 1))
            if x <= y or y <= x:
                task1 += 1
            if len(x.intersection(y)) != 0:
                task2 += 1
    print(task1)
    print(task2)

main()  