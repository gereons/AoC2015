//
// Advent of Code 2015 Day 16
//

import AoCTools

struct Day16: AdventOfCodeDay {
    let title = "Aunt Sue"

    struct Aunt {
        let number: Int
        let attributes: [String: Int]

        // Sue 11: vizslas: 5, perfumes: 8, cars: 10
        // Sue 12: children: 10, cars: 6, perfumes: 5
        init(_ str: String) {
            let tokens = str.split(separator: " ")
            number = Int(tokens[1].dropLast())!
            var attrs = [String: Int]()
            for index in stride(from: 2, through: tokens.count - 1, by: 2) {
                let name = String(tokens[index].dropLast())
                var count = tokens[index + 1]
                if count.last == "," {
                    count.removeLast()
                }
                attrs[name] = Int(count)!
            }
            attributes = attrs
        }

        func matches(_ criteria: [String: Int]) -> Bool {
            var match = 0
            for (name, count) in attributes {
                if criteria[name] == count {
                    match += 1
                }
            }

            return match == attributes.count
        }

        func rangeMatches(_ criteria: [String: Int]) -> Bool {
            var match = 0
            for (name, count) in attributes {
                switch name {
                case "cats", "trees":
                    if count > criteria[name, default: 999] {
                        match += 1
                    }
                case "pomeranians", "goldfish":
                    if count < criteria[name, default: -999] {
                        match += 1
                    }
                default:
                    if criteria[name] == count {
                        match += 1
                    }
                }
            }
            return match == attributes.count
        }
    }

    let aunts: [Aunt]
    let criteria = [
        "children": 3,
        "cats": 7,
        "samoyeds": 2,
        "pomeranians": 3,
        "akitas": 0,
        "vizslas": 0,
        "goldfish": 5,
        "trees": 3,
        "cars": 2,
        "perfumes": 1
    ]

    init(input: String) {
        aunts = input.lines.map { Aunt($0) }
    }

    func part1() async -> Int {
        for aunt in aunts {
            if aunt.matches(criteria) {
                return aunt.number
            }
        }

        fatalError()
    }

    func part2() async -> Int {
        for aunt in aunts {
            if aunt.rangeMatches(criteria) {
                return aunt.number
            }
        }

        fatalError()
    }
}
