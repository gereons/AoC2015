// Solution for part 1: X
// Solution for part 2: Y

struct Day13 {
    let day = "13"
    let testData = [
        "Alice would gain 54 happiness units by sitting next to Bob.",
        "Alice would lose 79 happiness units by sitting next to Carol.",
        "Alice would lose 2 happiness units by sitting next to David.",
        "Bob would gain 83 happiness units by sitting next to Alice.",
        "Bob would lose 7 happiness units by sitting next to Carol.",
        "Bob would lose 63 happiness units by sitting next to David.",
        "Carol would lose 62 happiness units by sitting next to Alice.",
        "Carol would gain 60 happiness units by sitting next to Bob.",
        "Carol would gain 55 happiness units by sitting next to David.",
        "David would gain 46 happiness units by sitting next to Alice.",
        "David would lose 7 happiness units by sitting next to Bob.",
        "David would gain 41 happiness units by sitting next to Carol."
    ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let (happiness, names) = Timer.time(day) { () -> ([String:Int], [String]) in
            var happiness = [String: Int]()
            var names = Set<String>()
            data.forEach { line in
                let tokens = line.split(separator: " ")
                let name1 = String(tokens[0])
                let name2 = String(tokens[10].dropLast())
                let amount = Int(tokens[3])!
                let sign = tokens[2] == "gain" ? +1 : -1

                happiness["\(name1):\(name2)"] = sign * amount
                names.insert(name1)
            }
            return (happiness, Array(names))
        }

        print("Solution for part 1: \(part1(names, happiness))")
        print("Solution for part 2: \(part2(names, happiness))")
    }

    private func part1(_ names: [String], _ happiness: [String: Int]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        var maxHappiness = 0
        names.permutations { order in
            let happiness = totalHappiness(for: order, happiness)
            maxHappiness = max(maxHappiness, happiness)
        }
        return maxHappiness
    }

    private func part2(_ names: [String], _ happiness: [String: Int]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        var names = names
        names.append("Santa")
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
        let last = names[names.count-1]
        total += happiness["\(last):\(first)"] ?? 0
        total += happiness["\(first):\(last)"] ?? 0
        return total
    }
}
