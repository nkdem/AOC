package main

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/nkdem/AOC/2025/utils"
)

func getEqualSubstrings(value string, n int) []string {
	values := []string{}

	// needs to be divisible by n
	if len(value)%n != 0 {
		return values
	}

	for i := 0; i <= len(value)-n; i += n {
		values = append(values, value[i:i+n])
	}
	return values
}

func part1(lines []string) int {
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
					continue
				}
				candidates := getEqualSubstrings(candidate, len(candidate)/2)
				if len(candidate) == 0 {
					continue
				}
				// fmt.Println(candidates)
				for _, v := range candidates {
					if v != candidates[0] {
						goto skip
					}
				}
				total += i
			skip:
				continue
			}
		}

	}
	return total
}

func part2(lines []string) int {
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
				found := false
				for j := 2; j <= len(candidate); j++ {
					// fmt.Println("Trying j", j)
					if len(candidate)%j != 0 {
						continue
					}
					candidates := getEqualSubstrings(candidate, len(candidate)/j)
					if len(candidates) == 0 {
						continue
					}
					// fmt.Println(candidates)
					allEqual := true
					for _, v := range candidates {
						if v != candidates[0] {
							allEqual = false
							break
						}
					}
					if allEqual {
						total += i
						found = true
						break
					}
				}
				if found {
					continue
				}
			}
		}

	}
	return total
}

func main() {
	lines, err := utils.ReadLines("inputs/day2_input")
	if err != nil {
		panic(err)
	}

	fmt.Println("Part 1:", part1(lines))
	fmt.Println("Part 2:", part2(lines))
}
