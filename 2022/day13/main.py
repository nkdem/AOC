from functools import cmp_to_key

def read_input():
    inputs = [] 
    with open('day13/inputs/13') as f:
        while (l := f.readline()):
            if l != '\n':
                x = list(eval(l))
                inputs.append(x)
    return inputs

def evaluate(l,r):
    match (isinstance(l, int), isinstance(r, int)):
        case (True, True): # both are ints SCENARIO 1 
            return 0 if l == r else 1 if l > r else -1
        case (True, False): # right is a list # SCENARIO 3
            return evaluate([l], r)
        case (False, True): # left is a list # SCENARIO 3
            return evaluate(l, [r])
        case (False, False): # both are lists # SCENARIO 2
            match (l,r):
                case ([x, *xs], [y, *ys]):
                    match (evaluate(x,y)):
                        case 0: # if equal, compare the rest of the lists
                            return evaluate(xs, ys)
                        case -1: 
                            return -1
                        case 1:
                            return 1
                case ([], [y, *_]): # left runs out first 
                    return -1
                case ([x, *_], []): # right runs out first
                    return 1
                case ([], []): # both run out at the same time
                    return 0
def solve1(inputs):
    total = 0
    left = inputs[::2]
    right = inputs[1::2]
    for (i, (l,r)) in enumerate(zip(left,right)):
        if evaluate(l,r) == -1:
            total += i + 1
    print(total)
def solve2(inputs):
    inputs.extend([[2], [6]])
    inputs = sorted(inputs, key=cmp_to_key(evaluate)) # https://stackoverflow.com/questions/46851479/python-sort-list-with-two-arguments-in-compare-function/46851576#46851576
    return (inputs.index([2]) + 1) * (inputs.index([6]) + 1)
            
print(solve1(read_input()))
print(solve2(read_input()))