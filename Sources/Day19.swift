// Solution for part 1: X
// Solution for part 2: Y

private struct Atom: Hashable {
    let name: String

    static func fromString(_ string: String) -> [Atom] {
        var atoms = [Atom]()
        var prevCh: Character?
        let chArray = Array(string)

        for i in 0..<chArray.count {
            let ch = chArray[i]
            if let prev = prevCh {
                if chArray[i].isLowercase {
                    atoms.append(Atom(name: "\(prev)\(ch)"))
                    prevCh = nil
                } else {
                    atoms.append(Atom(name: "\(prev)"))
                    prevCh = ch
                }
            } else {
                prevCh = ch
            }
        }
        if let prev = prevCh {
            atoms.append(Atom(name: "\(prev)"))
        }
        return atoms
    }
}

private struct Molecule: Hashable, CustomDebugStringConvertible {
    let atoms: [Atom]

    var debugDescription: String {
        atoms.map { $0.name }.joined(separator: "")
    }
}

private extension Array where Element == Atom {
    var atoms: String {
        self.map { $0.name }.joined(separator: "")
    }
}

struct Day19 {
    let day = "19"
    let testData = [
//        "e => H",
//        "e => O",
        "H => HO",
        "H => OH",
        "O => HH",
        "",
        "HOH",
    ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let (replacements, molecule) = Timer.time(day) { () -> ([Atom: [[Atom]]], Molecule) in
            var repl = [Atom: [[Atom]]]()
            var molecule = Molecule(atoms: [])
            for line in data {
                let tokens = line.split(separator: " ")
                if tokens.count == 3 {
                    let from = Atom(name: String(tokens[0]))
                    repl[from, default: []].append(Atom.fromString(String(tokens[2])))
                } else if tokens.count == 1 {
                    molecule = Molecule(atoms: Atom.fromString(String(tokens[0])))
                }
            }

            return (repl, molecule)
        }

        print("Solution for part 1: \(part1(molecule, replacements))")
        print("Solution for part 2: \(part2(molecule, replacements))")
    }

    private func part1(_ molecule: Molecule, _ replacements: [Atom: [[Atom]]]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let variants = variations(for: molecule, replacements)

        return variants.count
    }

    private func variations(for molecule: Molecule, _ replacements: [Atom: [[Atom]]]) -> Set<Molecule> {
        var molecules = [Molecule]()

        for (index, atom) in molecule.atoms.enumerated() {
            if let replacements = replacements[atom] {
                for repl in replacements {
                    var atoms = molecule.atoms
                    atoms.remove(at: index)
                    atoms.insert(contentsOf: repl, at: index)
                    let newMolecule = Molecule(atoms: atoms)
                    molecules.append(newMolecule)
                }
            }
        }

        return Set(molecules)
    }

    private func part2(_ molecule: Molecule, _ replacements: [Atom: [[Atom]]]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        // reverse the replacements
        var reverseReplacements = [[Atom]: Atom]()
        for (key, value) in replacements {
            for v in value {
                reverseReplacements[v] = key
            }
        }

        let keys = reverseReplacements.keys.sorted { $0.count > $1.count }

        var atoms = molecule.atoms
        let e = Atom(name: "e")
        var counter = 0
        // print(atoms.atoms)
        for _ in 0..<100 {
            for key in keys {
                for position in lookup(key, in: atoms).reversed() {
                    atoms.removeSubrange(position ..< position + key.count)
                    atoms.insert(reverseReplacements[key]!, at: position)
                    counter += 1
                }

            }
            // print(atoms.atoms)
            if atoms == [e] {
                break
            }
        }

        return counter
    }

    func lookup<T: Equatable>(_ search: [T], in data: [T]) -> [Int] {
        let len = search.count
        if len > data.count {
            return []
        }

        var found = [Int]()
        for i in 0 ... data.count - len {
            let r = data[i..<i+len]
            if Array(r) == search {
                found.append(i)
            }
        }

        return found
    }

}
