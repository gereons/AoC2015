//
// Advent of Code 2015 Day 1
//

import AoCTools

struct Day01: AdventOfCodeDay {
    let title = "Not Quite Lisp"

    let instructions: String

    init(input: String) {
        self.instructions = input
    }

    func part1() async -> Int {
        var floor = 0
        instructions.forEach { ch in
            switch ch {
            case "(": floor += 1
            case ")": floor -= 1
            default: fatalError()
            }
        }
        return floor
    }

    func part2() async -> Int {
        var floor = 0
        for (index, ch) in instructions.enumerated() {
            switch ch {
            case "(": floor += 1
            case ")": floor -= 1
            default: fatalError()
            }
            if floor < 0 {
                return index + 1
            }
        }
        fatalError()
    }
}
