//
// Advent of Code 2015 Day 20
//

import AoCTools
import Foundation

struct Day20: AdventOfCodeDay {
    let title = "Infinite Elves and Infinite Houses"

    let target: Int

    init(input: String) {
        target = Int(input)!
    }

    func part1() async -> Int {
        for i in 1..<Int.max {
            let p = divisors(of: i).reduce(0, +) * 10
            if p >= target {
                return i
            }
        }
        fatalError()
    }

    func part2() async -> Int {
        for i in 1..<Int.max {
            let p = divisors(of: i, limit: 50).reduce(0, +) * 11
            if p >= target {
                return i
            }
        }
        fatalError()
    }

    private func divisors(of n: Int, limit: Int = 0) -> [Int] {
        var d: [Int] = []
        var i = 1
        while i <= Int(sqrt(Double(n))) {
            if n.isMultiple(of: i) {
                let j = n / i
                if limit == 0 || j <= limit {
                    d.append(i)
                }
                if i != j && (limit == 0 || i <= limit) {
                    d.append(j)
                }
            }
            i += 1
        }
        return d
    }

}
