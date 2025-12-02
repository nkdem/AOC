package main

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/nkdem/AOC/2025/utils"
)

func part1(lines []string) int {
	fmt.Println(lines)
	total := 0
	for _, element := range lines {
		ranges := strings.Split(element, ",")
		for _, a := range ranges {
			b := strings.Split(a, "-")
			if len(b) == 1 {
				continue
			}
			start, _ := strconv.Atoi(b[0])
			end, _ := strconv.Atoi(b[1])
			// fmt.Printf("Start=%d, End=%d, diff=%d\n", start, end, end-start)
			for i := start; i <= end; i++ {
				candidate := strconv.Itoa(i)
				if len(candidate)%2 != 0 {
					// fmt.Println("Skipping")
					continue
				}
				firstHalf := candidate[0 : len(candidate)/2]
				secondHalf := candidate[len(candidate)/2:]
				// fmt.Println(firstHalf, secondHalf)
				if firstHalf == secondHalf {
					total += i
				}
			}
		}

	}
	return total
}

func part2(lines []string) int {
	return 0
}

func main() {
	lines, err := utils.ReadLines("inputs/day2_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
