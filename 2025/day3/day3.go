package main

import (
	"fmt"
	"math"

	"github.com/nkdem/AOC/2025/utils"
)

func getHighestValueFromListStartingFrom(values []int, start int, noRequired int) int { // returns index
	startFrom := len(values) - noRequired
	max := values[startFrom]
	max_i := startFrom
	// fmt.Printf("Starting from %d and the current value is %d (index %d) and after ", startFrom, max, max_i)
	for i := startFrom - 1; i >= start; i-- {
		if values[i] >= max {
			max = values[i]
			max_i = i
		}

	}
	// fmt.Printf("running the loop the highest value was %d (index %d)\n", max, max_i)
	return max_i
}
func getDigitFromTwoDigits(x int, y int) int {
	return (x * 10) + y
}

func solve(lines []string, batteriesRequired int) int {
	total := 0

	for _, bank := range lines {
		values := utils.SplitInts(bank, "")
		indices := []int{}
		for i := range batteriesRequired {

			var start int
			if len(indices) == 0 {
				start = -1
			} else {
				start = indices[len(indices)-1]
			}
			index := getHighestValueFromListStartingFrom(values[start+1:], 0, batteriesRequired-i)
			index = index + start + 1
			indices = append(indices, index)
		}
		value := 0
		for i, x := range indices {
			value += int(math.Pow10(batteriesRequired-1-i)) * values[x]

		}
		total += value
	}
	return total
}

func part1(lines []string) int {
	return solve(lines, 2)
}

func part2(lines []string) int {
	return solve(lines, 12)
}

func main() {
	lines, err := utils.ReadLines("inputs/day3_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
