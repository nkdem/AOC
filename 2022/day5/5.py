import re

def read_row(line):
    stack = []  
    for i in range(1,len(line), 4):
        stack.append(line[i])
    return stack

def construct_stack(arr, max_height):
    stack = []
    for j in range(max_height):
        tmp_stack = []
        for i in range(len(arr)-1,-1, -1):
            crate = arr[i][j]
            if (crate != ' '):
                tmp_stack.append(crate)
        stack.append(tmp_stack.copy())
        tmp_stack.clear()
    return stack

def task5(partb=False):
    stack = []
    constructed_crate = False
    with open('day5/inputs/5') as f:
        max_height = 0  
        arr = []
        while (line := f.readline()):
            if (' 1' not in line) and not constructed_crate:
                if (r:= read_row(line)):
                    arr.append(r)
                    max_height = max(max_height, len(r))
            elif (line != '\n'):
                digits = list(map(int, re.findall(r'\d+', line)))
                if not constructed_crate:
                    stack = construct_stack(arr, max_height)
                    constructed_crate = True
                else:
                    pop_n_times, from_index, to_index = digits
                    part2 = partb and pop_n_times > 1
                    while pop_n_times > 0:
                        if len(stack[from_index -1]) == 0:
                            break 
                        if part2:
                            stack[to_index -1].append(stack[from_index-1].pop(len(stack[from_index -1]) - pop_n_times))
                        else:
                            stack[to_index -1].append(stack[from_index-1].pop())
                        pop_n_times -= 1
        topmost = []
        for s in stack:
            if len(s) != 0:
                topmost.append(s[-1])
        return ("".join(str(x) for x in topmost))        

def main():
    print(task5())
    print(task5(True))
main()