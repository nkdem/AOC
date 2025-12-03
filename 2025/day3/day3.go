package main

import (
	"fmt"

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

func part2(lines []string) int {
	return 0
}

func main() {
	lines, err := utils.ReadLines("inputs/day3_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
