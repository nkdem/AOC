package main

import (
	"fmt"
	"math"

	"github.com/nkdem/AOC/2025/utils"
)

func getDigitFromTwoDigits(x int, y int) int {
	return (x * 10) + y
}

func part1(lines []string) int {
	total := 0
	for _, bank := range lines {
		values := utils.SplitInts(bank, "")
		firstDigit := values[0]
		secondDigit := values[1]

		for i := 1; i < len(values); i++ {
			if firstDigit < values[i] {
				if i == len(values)-1 {
					goto check2
				}
				firstDigit = values[i]
				secondDigit = values[i+1]
				continue
			}
		check2:
			if secondDigit < values[i] {
				secondDigit = values[i]
			}
		}

		fmt.Println(getDigitFromTwoDigits(firstDigit, secondDigit))

		total += getDigitFromTwoDigits(firstDigit, secondDigit)
	}
	return total
}

const BatteriesRequired = 12

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
func part2(lines []string) int {
	total := 0

	for _, bank := range lines {
		values := utils.SplitInts(bank, "")
		indices := []int{}
		for i := range BatteriesRequired {

			var start int
			if len(indices) == 0 {
				start = -1
			} else {
				start = indices[len(indices)-1]
			}
			index := getHighestValueFromListStartingFrom(values[start+1:], 0, BatteriesRequired-i)
			index = index + start + 1
			indices = append(indices, index)
		}
		value := 0
		for i, x := range indices {
			value += int(math.Pow10(BatteriesRequired-1-i)) * values[x]

		}
		total += value
	}
	return total
}

func main() {
	lines, err := utils.ReadLines("inputs/day3_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
