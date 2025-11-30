package main

import (
	"fmt"

	"github.com/nkdem/AOC/2025/utils"
)

func part1(lines []string) int {
	return 0
}

func part2(lines []string) int {
	return 0
}

func main() {
	lines, err := utils.ReadLines("inputs/dayN_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
