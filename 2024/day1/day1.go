package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
	"strings"
)

func distance(left int, right int) int {
	abs := math.Abs(float64(left - right))
	return int(abs)
}

func main() {
	fi, err := os.Open("inputs/day1_input")
	if err != nil {
		panic(err)
	}
	defer fi.Close()

	scanner := bufio.NewScanner(fi)
	left_list := []int{}
	right_list := []int{}
	for scanner.Scan() {
		line := scanner.Text()
		field := strings.Fields(line)
		left, right := 0, 0
		fmt.Sscanf(field[0], "%d", &left)
		fmt.Sscanf(field[1], "%d", &right)

		left_list = append(left_list, left)
		right_list = append(right_list, right)
	}
	// Part A
	sort.Ints(left_list)
	sort.Ints(right_list)

	total_distance := 0
	for i := 0; i < len(left_list); i++ {
		total_distance += distance(left_list[i], right_list[i])
	}
	fmt.Println(total_distance)

	// Part B
	count_map := make(map[int]int)
	for i := 0; i < len(right_list); i++ {
		count_map[right_list[i]]++
	}

	total_simalrity := 0
	for i := 0; i < len(left_list); i++ {
		x := left_list[i]
		// check if x is in the right_list
		y := 0
		if count_map[x] > 0 {
			y = count_map[x]
		}
		total_simalrity += (x * y)
	}
	fmt.Println(total_simalrity)
}
