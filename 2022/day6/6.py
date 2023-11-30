def read_input():
    str = []
    with open('day6/inputs/6') as f:
        while (c := f.read(1)):
            str.append(c)
        return str

def valid(str):
    return len(set(str)) == len(str)

def solve(str, length):
    for i in range(0, len(str)):
        if len(set(str[i:length + i])) == length:
            return i + length
            
        
def main():
    input = read_input()
    print(solve(input,4))
    print(solve(input,14))
main()