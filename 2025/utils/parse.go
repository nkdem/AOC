package utils

import (
	"strconv"
	"strings"
)

func ParseInt(s string) int {
	n, err := strconv.Atoi(s)
	if err != nil {
		panic(err)
	}
	return n
}

func ParseInts(s string) []int {
	fields := strings.Fields(s)
	nums := make([]int, len(fields))
	for i, f := range fields {
		nums[i] = ParseInt(f)
	}
	return nums
}

func SplitInts(s string, sep string) []int {
	parts := strings.Split(s, sep)
	nums := make([]int, 0, len(parts))
	for _, p := range parts {
		p = strings.TrimSpace(p)
		if p != "" {
			nums = append(nums, ParseInt(p))
		}
	}
	return nums
}
