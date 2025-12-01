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
			pos = (pos - rotateBy%RollAt + RollAt) % RollAt
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
	pos := StartingDialPos
	count := 0
	for _, element := range lines {

		rotate := element[0]
		rotateBy := utils.ParseInt(element[1:])

		var newPos int
		var zeroCrossings int

		if rotate == 'L' {
			if pos > 0 && rotateBy >= pos {
				zeroCrossings = (rotateBy-pos)/RollAt + 1
			} else if pos == 0 && rotateBy > 0 {
				zeroCrossings = rotateBy / RollAt
			}
			newPos = (pos - rotateBy%RollAt + RollAt) % RollAt
		} else {
			zeroCrossings = (pos + rotateBy) / RollAt
			newPos = (pos + rotateBy) % RollAt
		}

		// fmt.Printf("The dial is rotated %s to point at %d; during this rotation, it points at 0 %d times\n", element, newPos, zeroCrossings)
		count += zeroCrossings
		pos = newPos
	}
	return count
}

func main() {
	lines, err := utils.ReadLines("inputs/day1_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
