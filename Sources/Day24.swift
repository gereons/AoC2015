//
// Advent of Code 2015 Day 24
//

import AoCTools

struct Day24: AdventOfCodeDay {
    let title = "It Hangs in the Balance"

    let weights: [Int]

    init(input: String) {
        weights = input.lines.map { Int($0)! }
    }

    func part1() async -> Int {
        let sum = weights.reduce(0, +) / 3
        var sets = [[Int]]()
        findSubsets(weights, sum: sum, [], &sets)

        sets.sort { set1, set2 in
            if set1.count == set2.count {
                let qe1 = set1.reduce(1, mul)
                let qe2 = set2.reduce(1, mul)

                return qe1 < qe2
            }
            return set1.count < set2.count
        }

        return sets[0].reduce(1, *)
    }

    func part2() async -> Int {
        let sum = weights.reduce(0, +) / 4
        var sets = [[Int]]()
        findSubsets(weights, sum: sum, [], &sets)

        sets.sort { set1, set2 in
            if set1.count == set2.count {
                let qe1 = set1.reduce(1, mul)
                let qe2 = set2.reduce(1, mul)

                return qe1 < qe2
            }
            return set1.count < set2.count
        }

        return sets[0].reduce(1, *)
    }

    private func mul(_ i1: Int, i2: Int) -> Int {
        let (r, ov) = i1.multipliedReportingOverflow(by: i2)
        return ov ? Int.max : r
    }

    private func findSubsets(_ weights: [Int], sum: Int, _ working: [Int], _ results: inout [[Int]]) {
        for i in 0 ..< weights.count {
            let w = weights[i]
            let workingSum = working.reduce(0, +)
            if workingSum + w <= sum {
                var working = working
                working.append(w)
                findSubsets(Array(weights.dropFirst(i + 1)), sum: sum, working, &results)
            } else if workingSum > sum {
                break
            }
        }

        if working.reduce(0, +) == sum {
            // print(working)
            results.append(working)
        }
    }
}
