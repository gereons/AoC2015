//
// Advent of Code 2015 Day 13
//

import AoCTools

struct Day13: AdventOfCodeDay {
    let title = "Knights of the Dinner Table"

    let happiness: [String: Int]
    let names: [String]

    init(input: String) {
        var happiness = [String: Int]()
        var names = Set<String>()
        input.lines.forEach { line in
            let tokens = line.components(separatedBy: " ")
            let name1 = tokens[0]
            let name2 = String(tokens[10].dropLast())
            let amount = Int(tokens[3])!
            let sign = tokens[2] == "gain" ? +1 : -1

            happiness["\(name1):\(name2)"] = sign * amount
            names.insert(name1)
        }

        self.happiness = happiness
        self.names = Array(names)
    }

    func part1() async -> Int {
        maxHappiness(for: names)
    }

    func part2() async -> Int {
        maxHappiness(for: names + ["Me"])
    }

    private func maxHappiness(for names: [String]) -> Int {
        var maxHappiness = 0
        names.permutations { order in
            let happiness = totalHappiness(for: order, happiness)
            maxHappiness = max(maxHappiness, happiness)
        }
        return maxHappiness
    }

    private func totalHappiness(for names: [String], _ happiness: [String: Int]) -> Int {
        var previousName: String?

        var total = 0
        names.forEach { name in
            if let previous = previousName {
                total += happiness["\(previous):\(name)"] ?? 0
                total += happiness["\(name):\(previous)"] ?? 0
            }
            previousName = name
        }

        let first = names[0]
        let last = names[names.count - 1]
        total += happiness["\(last):\(first)"] ?? 0
        total += happiness["\(first):\(last)"] ?? 0
        return total
    }
}
