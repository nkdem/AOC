package utils

type Point struct {
	Row, Col int
}

type Direction struct {
	DR, DC int
}

var (
	Up    = Direction{-1, 0}
	Down  = Direction{1, 0}
	Left  = Direction{0, -1}
	Right = Direction{0, 1}
)

var Directions4 = []Direction{Up, Down, Left, Right}
var Directions8 = []Direction{Up, Down, Left, Right, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}}

func (p Point) Add(d Direction) Point {
	return Point{p.Row + d.DR, p.Col + d.DC}
}

func (p Point) InBounds(rows, cols int) bool {
	return p.Row >= 0 && p.Row < rows && p.Col >= 0 && p.Col < cols
}

func (p Point) Neighbors4(rows, cols int) []Point {
	neighbors := make([]Point, 0, 4)
	for _, d := range Directions4 {
		next := p.Add(d)
		if next.InBounds(rows, cols) {
			neighbors = append(neighbors, next)
		}
	}
	return neighbors
}

func (p Point) Neighbors8(rows, cols int) []Point {
	neighbors := make([]Point, 0, 8)
	for _, d := range Directions8 {
		next := p.Add(d)
		if next.InBounds(rows, cols) {
			neighbors = append(neighbors, next)
		}
	}
	return neighbors
}

func ParseGrid(lines []string) [][]rune {
	grid := make([][]rune, len(lines))
	for i, line := range lines {
		grid[i] = []rune(line)
	}
	return grid
}

func FindInGrid(grid [][]rune, target rune) *Point {
	for r, row := range grid {
		for c, val := range row {
			if val == target {
				return &Point{r, c}
			}
		}
	}
	return nil
}

func FindAllInGrid(grid [][]rune, target rune) []Point {
	points := []Point{}
	for r, row := range grid {
		for c, val := range row {
			if val == target {
				points = append(points, Point{r, c})
			}
		}
	}
	return points
}
