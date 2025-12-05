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

func part2(ranges []Range) int {

	for i := 0; i < len(ranges); i++ {
		for j := i + 1; j < len(ranges); j++ {
			if ranges[i].Start > ranges[j].Start {
				ranges[i], ranges[j] = ranges[j], ranges[i]
			}
		}
	}

	merged := []Range{ranges[0]}
	for i := 1; i < len(ranges); i++ {
		last := &merged[len(merged)-1]
		current := ranges[i]

		if current.Start <= last.End+1 {
			// extend last range if necessary
			if current.End > last.End {
				last.End = current.End
			}
		} else {
			// unique range
			merged = append(merged, current)
		}
	}

	total := 0
	for _, rg := range merged {
		total += rg.End - rg.Start + 1
	}
	return total
}

// BRUTE FORCE appraoch
// func part2(ranges []Range) int {
// 	total := 0
// 	set := make(map[int]bool)
// 	for _, rg := range ranges {
// 		// diff := rg.End - rg.Start + 1
// 		for i := rg.Start; i <= rg.End; i++ {
// 			set[i] = true
// 		}
// 		// total += diff
// 	}
// 	for _, v := range set {
// 		if v == true {
// 			total += 1
// 		}

// 	}
// 	return total
// }

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
	fmt.Println("Part 2:", part2(ranges))
}
