//
// Advent of Code 2015 Day 25
//

import AoCTools

struct Day25: AdventOfCodeDay {
    let title = "Let It Snow"

    let row: Int
    let column: Int

    init(input: String) {
        let ints = input.integers()
        self.row = ints[0]
        self.column = ints[1]
    }

    func part1() async -> Int {
        var number = 20151125
        let maxX = 2 * column + 10
        let maxY = 2 * column + 10
        let line = [Int](repeating: 0, count: maxX + 1)
        var grid = [[Int]](repeating: line, count: maxY + 1)
        for i in 0 ..< (maxX * maxY) {
            var r = i
            var c = 0

            repeat {
                if r + 1 == row && c + 1 == column {
                    return number
                }
                grid[r][c] = number
                number = (number * 252533) % 33554393

                r -= 1
                c += 1
            } while r >= 0
        }

        fatalError()
    }

    func part2() {}
}
