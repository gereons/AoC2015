//
// Advent of Code 2015 Day 10
//

import AoCTools

struct Day10: AdventOfCodeDay {
    let title = "Elves Look, Elves Say"

    let digits: [Int]

    init(input: String) {
        self.digits = input.compactMap { Int(String($0)) }
    }

    func part1() async -> Int {
        await part1(count: 40)
    }

    func part1(count: Int) async -> Int {
        lookAndSay(digits: digits, count: count)
    }

    func part2() async -> Int {
        lookAndSay(digits: digits, count: 50)
    }

    private func lookAndSay(digits: [Int], count: Int) -> Int {
        var digits = digits
        for _ in 0 ..< count {
            digits = lookAndSay(digits)
        }
        return digits.count
    }

    private func lookAndSay(_ input: [Int]) -> [Int] {
        var prev = input[0]
        var count = 0
        var output = [Int]()

        for ch in input {
            if ch == prev {
                count += 1
            } else {
                output.append(count)
                output.append(prev)
                count = 1
            }
            prev = ch
        }

        output.append(count)
        output.append(prev)

        return output
    }
}
