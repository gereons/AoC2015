// Solution for part 1: X
// Solution for part 2: Y

struct Day18 {
    let day = "18"
    let testData = [
        ".#.#.#",
        "...##.",
        "#....#",
        "..#...",
        "#.#..#",
        "####..",
    ]

    struct Point {
        let x, y: Int
    }

    class Grid {
        private var cells: [[Bool]]
        let dim: Int

        init(_ data: [String]) {
            dim = data.count
            assert(data.count == data[0].count)
            let empty = [Bool](repeating: false, count: dim)
            cells = [[Bool]](repeating: empty, count: dim)

            for (y, line) in data.enumerated() {
                for (x, ch) in line.enumerated() where ch == "#" {
                    cells[y][x] = true
                }
            }
        }

        func show() {
            for y in 0..<dim {
                for x in 0..<dim {
                    let ch = cells[y][x] ? "#" : "."
                    print(ch, terminator: "")
                }
                print()
            }
            print("---")
        }

        private func neighbors(for x: Int, _ y: Int) -> [Point] {
            var result = [Point]()
            let offsets = [
                (-1, -1), (0, -1), (1, -1),
                (-1,  0),           (1, 0),
                (-1,  1),  (0, 1),  (1, 1)
            ]

            for offset in offsets {
                let nx = x + offset.0
                let ny = y + offset.1
                if nx >= 0 && nx < dim && ny >= 0 && ny < dim {
                    result.append(Point(x: nx, y: ny))
                }
            }

            return result
        }

        private func neighborCount(at x: Int, _ y: Int) -> Int {
            let neighbors = neighbors(for: x, y)
            return neighbors.reduce(0) { sum, n in
                sum + (cells[n.y][n.x] ? 1 : 0)
            }
        }

        func generation() {
            var next = cells

            for y in 0..<dim {
                for x in 0..<dim {
                    let neighbors = neighborCount(at: x, y)
                    if cells[y][x] {
                        // on - stay on if 2 or 3 neighbors are on, turn off otherwise
                        if neighbors != 2 && neighbors != 3 {
                            next[y][x] = false
                        }
                    } else {
                        // off - turn on if 3 neighbors are on, remain off otherwise
                        if neighbors == 3 {
                            next[y][x] = true
                        }
                    }
                }
            }

            cells = next
        }

        func setFixedCorners() {
            cells[0][0] = true
            cells[0][dim-1] = true
            cells[dim-1][0] = true
            cells[dim-1][dim-1] = true
        }

        var lightsOn: Int {
            cells.reduce(0) { sum, line in
                sum + line.reduce(0) { sum, on in
                    sum + (on ? 1 : 0)
                }
            }
        }
    }

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let (grid, grid2) = Timer.time(day) {
            (Grid(data), Grid(data))
        }

        print("Solution for part 1: \(part1(grid))")
        print("Solution for part 2: \(part2(grid2))")
    }

    private func part1(_ grid: Grid) -> Int {
        let timer = Timer(day); defer { timer.show() }
        for _ in 0 ..< 100 {
            grid.generation()
        }
        return grid.lightsOn
    }

    private func part2(_ grid: Grid) -> Int {
        let timer = Timer(day); defer { timer.show() }
        grid.setFixedCorners()
        for _ in 0 ..< 100 {
            grid.generation()
            grid.setFixedCorners()
        }
        return grid.lightsOn
    }
}
