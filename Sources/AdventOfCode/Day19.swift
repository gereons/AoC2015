// Solution for part 1: X
// Solution for part 2: Y

struct Day19 {
    let day = "19"
    let testData = [
        "e => H",
        "e => O",
        "H => HO",
        "H => OH",
        "O => HH",
        "",
        "HOHOHO",
    ]

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let (replacements, molecule) = Timer.time(day) { () -> ([String: [String]], String) in
            var repl = [String: [String]]()
            var molecule = ""
            for line in data {
                let tokens = line.split(separator: " ")
                if tokens.count == 3 {
                    let from = String(tokens[0])
                    let to = String(tokens[2])
                    repl[from, default: []].append(to)
                } else if tokens.count == 1 {
                    molecule = line
                }
            }

            return (repl, molecule)
        }

        // print("Solution for part 1: \(part1(molecule, replacements))")
        print("Solution for part 2: \(part2(molecule, replacements))")
    }

    private func part1(_ molecule: String, _ replacements: [String: [String]]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let variants = variations(for: molecule, replacements)

        return variants.count
    }

    private func variations(for molecule: String, _ replacements: [String: [String]]) -> Set<String> {
        var new = [String]()
        let cnt = molecule.count
        let start = molecule.startIndex

        for (index, ch) in molecule.enumerated() {
            if let repl = replacements[String(ch)] {
                for r in repl {
                    let newMolecule = "\(molecule.prefix(index))\(r)\(molecule.suffix(cnt - index - 1))"
                    new.append(newMolecule)
                }
            } else if index < molecule.count - 1 {
                let s = molecule[molecule.index(start, offsetBy: index)...molecule.index(start, offsetBy: index+1)]
                if let repl = replacements[String(s)] {
                    for r in repl {
                        let newMolecule = "\(molecule.prefix(index))\(r)\(molecule.suffix(cnt - index - 2))"
                        new.append(newMolecule)
                    }
                }
            }
        }

        return Set(new)
    }

    private func part2(_ molecule: String, _ replacements: [String: [String]]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        // reverse the replacements

        var newReplacements = [String: String]()
        for (key, value) in replacements {
            for v in value {
                newReplacements[v] = key
            }
        }

        return 42
    }

}
