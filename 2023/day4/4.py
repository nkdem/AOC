import functools


flatten = lambda l: [item for sublist in l for item in sublist]

class Game:
    def __init__(self, winningHand, currentHand):
        self.winningHand = winningHand
        self.currentHand = currentHand
    def __repr__(self):
        return f"Game({self.winningHand}, {self.currentHand})"
        
def common(games: list[Game]) -> int:
    return list(map(len, map((lambda x: list(x.winningHand.intersection(x.currentHand))), games)))

def solve1(common: list[list[int]]) -> int:
    return sum(map(lambda x : 2 ** (x-1), filter(lambda x: x > 0, common)))


def solve2(guide: list[int]) -> int:
    cards = [i for i in range(1, len(guide) + 1)]
    starting = len(cards)
    cache = {i : [j for j in range(i + 1,i + 1 + guide[i - 1])] for i in range(1, len(guide) + 1)}
    total = 0
    while (len(cards) > 0):
        old_len = len(cards)
        n = cards.pop(0)
        cards += cache[n]
        total += len(cache[n])
        print(len(cards), total)
    return (total, starting)
with open("inputs/input", "r") as file:
    games: list[Game] = []
    while (line := file.readline().strip()):
        # line.split(':')
        (_, numbers) = line.split(':')
        numbers = numbers.split(' ')
        # remove empty string
        numbers = list(filter(lambda x: x != '', numbers))
        numbers = list(map(lambda x: -1 if x == '|' else int(x), numbers))
        index_of_end = numbers.index(-1)
        winning = numbers[:index_of_end]
        losing = numbers[index_of_end + 1:]
        games.append(Game(set(winning), set(losing)))
    print(solve1(common(games)))
    print(solve2(common(games)))
