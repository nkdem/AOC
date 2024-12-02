package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strings"
)

func RemoveIndex(s []int, index int) []int {
	new_s := []int{}
	for i, v := range s {
		if i != index {
			new_s = append(new_s, v)
		}
	}
	return new_s
}

func pop(slice []int) (int, []int) {
	return slice[0], slice[1:]
}

func isSafeRow(row []int) bool {
	prev := row[0]
	curr := row[1]
	increasing := true
	if prev > curr {
		increasing = false
	}
	for j := 1; j < len(row); j++ {
		curr = row[j]
		diff := int(math.Abs(float64(prev - curr)))
		if !(diff >= 1 && diff <= 3) {
			return false
		}
		if increasing && prev > curr {
			return false
		}
		if !increasing && prev < curr {
			return false
		}
		prev = curr
	}
	return true
}

func main() {
	// fi, err := os.Open("day2_sample")
	fi, err := os.Open("day2_input")
	if err != nil {
		panic(err)
	}
	defer fi.Close()

	scanner := bufio.NewScanner(fi)

	list := [][]int{}
	for scanner.Scan() {
		line := scanner.Text()
		field := strings.Fields(line)
		row := []int{}
		for _, f := range field {
			num := 0
			fmt.Sscanf(f, "%d", &num)
			row = append(row, num)
		}
		list = append(list, row)
	}

	candidates := make(map[int]bool)
	for i, row := range list {
		candidates[i] = isSafeRow(row)
	}
	partA := 0
	for _, v := range candidates {
		if v {
			partA++
		}
	}

	fmt.Println(partA)

	// brute force approach for b
	// 1. get all unsafe indexes (false)
	// 2. for each unsafe row, remove first element and check if it is safe, second element, and so on, if at least one is safe, then it is safe
	// and we can remove it from the unsafe list
	unsafe := []int{}
	for i, v := range candidates {
		if !v {
			unsafe = append(unsafe, i)
		}
	}

	for len(unsafe) > 0 {
		i, rest := pop(unsafe)
		unsafe = rest
		row := list[i]
		n := len(row)
		for j := 0; j < n; j++ {
			new_row := RemoveIndex(row, j)

			fmt.Println(new_row)
			if isSafeRow(new_row) {
				fmt.Println("safe")
				candidates[i] = true
				break
			}
		}
	}

	partB := 0
	for _, v := range candidates {
		if v {
			partB++
		}
	}
	fmt.Println(partB)

}
