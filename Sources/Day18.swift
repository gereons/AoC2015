//
// Advent of Code 2015 Day 18
//

import AoCTools

struct Day18: AdventOfCodeDay {
    let title = "Like a GIF For Your Yard"

    final class Grid {
        private(set) var cells: [[Bool]]
        let dim: Int

        init(cells: [[Bool]]) {
            assert(cells.count == cells[0].count)
            dim = cells.count
            self.cells = cells
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

            for direction in Direction.allCases {
                let np = Point(x, y) + direction
                if np.x >= 0 && np.x < dim && np.y >= 0 && np.y < dim {
                    result.append(np)
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
            cells[0][dim - 1] = true
            cells[dim - 1][0] = true
            cells[dim - 1][dim - 1] = true
        }

        var lightsOn: Int {
            cells.reduce(0) { sum, line in
                sum + line.reduce(0) { sum, on in
                    sum + (on ? 1 : 0)
                }
            }
        }
    }

    let cells: [[Bool]]

    init(input: String) {
        let lines = input.lines
        let dim = lines.count
        assert(lines.count == lines[0].count)
        let empty = [Bool](repeating: false, count: dim)
        var cells = [[Bool]](repeating: empty, count: dim)

        for (y, line) in lines.enumerated() {
            for (x, ch) in line.enumerated() where ch == "#" {
                cells[y][x] = true
            }
        }
        self.cells = cells
    }

    func part1() async -> Int {
        await part1(steps: 100)
    }

    func part1(steps: Int) async -> Int {
        let grid = Grid(cells: cells)
        for _ in 0 ..< steps {
            grid.generation()
        }
        return grid.lightsOn
    }

    func part2() async -> Int {
        await part2(steps: 100)
    }

    func part2(steps: Int) async -> Int {
        let grid = Grid(cells: cells)
        grid.setFixedCorners()
        for _ in 0 ..< steps {
            grid.generation()
            grid.setFixedCorners()
        }
        return grid.lightsOn
    }
}
