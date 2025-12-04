package main

import (
	"fmt"

	"github.com/nkdem/AOC/2025/utils"
)

const AccessableRoll = 4
const ToiletRoll = '@'

func part1(lines []string) int {
	total := 0
	grid := utils.ParseGrid(lines)
	rowsLength := len(grid)
	colsLength := len(grid[0])
	for i, rows := range grid {
		for j, _ := range rows {
			if grid[i][j] != ToiletRoll {
				continue
			}
			point := utils.Point{
				Row: i,
				Col: j,
			}
			neighbours := point.Neighbors8(rowsLength, colsLength)

			numberOfRolls := 0
			for _, p := range neighbours {
				if grid[p.Row][p.Col] == ToiletRoll {
					numberOfRolls++
				}

				if numberOfRolls > AccessableRoll {
					break
				}
			}

			if numberOfRolls < AccessableRoll {
				// fmt.Printf("Point at (%d,%d) can be accessed \n", i, j)
				total++
			}

		}
	}
	return total
}

func part2(lines []string) int {
	return 0
}

func main() {
	lines, err := utils.ReadLines("inputs/day4_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
