import re
from math import gcd
from functools import reduce
class Monkey():
    inspected = 0
    def __init__(self,items,operation, test, test_true, test_false):
        self.items = list(map(int,items))
        self.test = int(test)
        operator, by  = operation.split()
        if operator == '*':
            self.operation = lambda x: (x * x) if (by == 'old') else (x * int(by))
        else:
            self.operation = lambda x: (x + x) if (by == 'old') else (x + int(by))
        self.test_true = int(test_true)
        self.test_false = int(test_false)
    def __repr__(self):
        return f'{self.items}'
    def inspect(self):
        self.inspected += 1
        # if (new := self.operation(self.items.pop(0)) // 3) % self.test == 0: PART 1
        if (new := self.operation(self.items.pop(0))) % self.test == 0:
            return (self.test_true, new)
        return (self.test_false, new)
def read_input():
    monkeys = []
    with open('day11/inputs/11') as f:
        while (f.readline()):
            items,operation,test,test_true, test_false = f.readline().strip(), f.readline().strip(),f.readline().strip(),f.readline().strip(),f.readline().strip()
            monkeys.append(Monkey(re.findall('\d+', items),operation[21:],re.findall('\d+', test)[0],re.findall('\d+', test_true)[0], re.findall('\d+', test_false)[0]))
            f.readline()
    return monkeys

def solve(monkeys, limit, mod):
    rounds = 1
    while (rounds <= limit ):
        for monkey in monkeys:
            while (monkey.items):
                (to,val) = monkey.inspect()
                # monkeys[to].items.append(val) PART 1
                monkeys[to].items.append(val % mod)
        rounds += 1
def lcm(a,b):
    return abs(a*b) // gcd(a,b)
def main():
    monkeys = read_input()
    mod = reduce(lcm, [m.test for m in monkeys])
    solve(monkeys, 20, mod)
    s = sorted(([m.inspected for m in monkeys]))
    print(s[-1] * s[-2])

main()