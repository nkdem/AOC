package main

import (
	"fmt"

	"github.com/nkdem/AOC/2025/utils"
)

const StartingDialPos = 50
const RollAt = 100

// func

func part1(lines []string) int {
	pos := StartingDialPos
	count := 0
	for _, element := range lines {

		rotate := element[0]
		rotateBy := utils.ParseInt(element[1:])
		if rotate == 'L' {
			pos = (pos - rotateBy) % RollAt
		} else {
			pos = (pos + rotateBy) % RollAt
		}

		if pos == 0 {
			count += 1
		}

	}
	return count
}

func part2(lines []string) int {
	return 0
}

func main() {
	lines, err := utils.ReadLines("inputs/day1_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
