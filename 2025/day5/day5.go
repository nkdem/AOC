package main

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/nkdem/AOC/2025/utils"
)

type Range struct {
	Start int
	End   int
}

func part1(ranges []Range, ingredients []int) int {
	total := 0
	for _, x := range ingredients {
		for _, rg := range ranges {
			if x >= rg.Start && x <= rg.End {
				// fmt.Printf("%d falls in the range %d-%d\n", x, rg.Start, rg.End)
				total++
				break
			}

		}
	}
	return total
}

func part2(lines []string) int {
	return 0
}

func main() {
	lines, err := utils.ReadLines("inputs/day5_input")
	ranges := []Range{}
	ingredients := []int{}
	foundAllRanges := false
	for _, el := range lines {
		if !foundAllRanges && strings.Contains(el, "-") {
			val := strings.Split(el, "-")
			start, _ := strconv.Atoi(val[0])
			end, _ := strconv.Atoi(val[1])
			ranges = append(ranges, Range{
				Start: start,
				End:   end,
			})
		} else {
			foundAllRanges = true
			if el != "" {
				val, _ := strconv.Atoi(el)
				ingredients = append(ingredients, val)
			}

		}
	}
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(ranges, ingredients))
	fmt.Println("Part 2:", part2(lines))
}
