package utils

import (
	"bufio"
	"os"
	"strings"
)

func ReadLines(filepath string) ([]string, error) {
	file, err := os.Open(filepath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

func ReadFile(filepath string) (string, error) {
	data, err := os.ReadFile(filepath)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

func ReadSections(filepath string) ([]string, error) {
	content, err := ReadFile(filepath)
	if err != nil {
		return nil, err
	}
	return strings.Split(strings.TrimSpace(content), "\n\n"), nil
}
