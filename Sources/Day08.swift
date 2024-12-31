//
// Advent of Code 2015 Day 8
//

import AoCTools

struct Day08: AdventOfCodeDay {
    let title = "Matchsticks"

    let input: [String]

    init(input: String) {
        self.input = input.lines
    }

    func part1() async -> Int {
        var chars = 0
        var inMemory = 0
        for line in input {
            chars += line.count

            var memChars = 0
            var index = line.index(line.startIndex, offsetBy: 1)
            var nextIndex = line.index(after: index)
            while nextIndex != line.endIndex {
                memChars += 1
                let nextCh = line[nextIndex]
                if line[index] == "\\" {
                    var skip = 0
                    if nextCh == "\\" || nextCh == "\"" { skip = 1 }
                    if nextCh == "x" { skip = 3 }
                    nextIndex = line.index(nextIndex, offsetBy: skip)
                }

                index = nextIndex
                nextIndex = line.index(after: nextIndex)
            }

            inMemory += memChars

            // print(line, line.count, memChars)
        }
        return chars - inMemory
    }

    func part2() async -> Int {
        var chars = 0
        var encoded = 0
        for line in input {
            chars += line.count
            var enc = line.count + 2

            for ch in line {
                if ch == "\"" || ch == "\\" {
                    enc += 1
                }
            }
            encoded += enc
            // print(line, line.count, enc)
        }

        return encoded - chars
    }
}
