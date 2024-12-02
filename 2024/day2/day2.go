package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strings"
)

func main() {
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
	fmt.Println(list)

	candidates := [][]int{}
	for _, row := range list {
		prev := row[0]
		curr := row[1]
		increasing := true
		if prev > curr {
			increasing = false
		}
		finished := true
		for i := 1; i < len(row); i++ {
			curr = row[i]
			diff := int(math.Abs(float64(prev - curr)))
			if !(diff >= 1 && diff <= 3) {
				finished = false
				break
			}
			if increasing && prev > curr {
				finished = false
				break
			}
			if !increasing && prev < curr {
				finished = false
				break
			}
			prev = curr
		}
		if finished {
			candidates = append(candidates, row)
		}
	}
	fmt.Println(len(candidates))

	// sort the
}
