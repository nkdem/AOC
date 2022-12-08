from math import prod 
def read_input():
    arr = []
    with open('day8/inputs/8') as f:
        while (l := f.readline().strip()):
            arr.append(list(map(int, l)))
    return arr 

def solve1(arr):
    count = 0
    for i in range((r := len(arr))):
        for j in range(c := len(arr[i])):
            if i == 0 or i == r - 1 or j == 0 or j == c - 1: # edges
                count += 1
            else:
                top = [x[j] for x in arr[0:i]]
                right = arr[i][j+1:]
                bottom = [x[j] for x in arr[i+1:r]]
                left = arr[i][0:j]
                mid = arr[i][j]
                top_max, right_max, bottom_max, left_max = map(lambda x: max(x), [top,right,bottom,left])
                if len(list(filter(lambda x: mid > x, [top_max, right_max, bottom_max, left_max]))) > 0:
                    count += 1
    print(count)
def solve2(arr):
    score = 1
    for i in range((r := len(arr))):
        for j in range(c := len(arr[i])):
            if i == 0 or i == r - 1 or j == 0 or j == c - 1: # edges
                continue
            else:
                top = [x[j] for x in arr[0:i]]
                right = arr[i][j+1:]
                bottom = [x[j] for x in arr[i+1:r]]
                left = arr[i][0:j]
                mid = arr[i][j]
            
                score = max(score, prod(map(lambda x: blocksAfter(mid, x), [reversed(top), right, bottom, reversed(left)])))
    print(score)
    
def blocksAfter(current, arr):
    count = 0
    for x in arr:
        count += 1
        if current <= x:
            break
    return count

def main():
    arr = read_input()
    solve1(arr)
    solve2(arr)
main()