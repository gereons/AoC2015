//
// Advent of Code 2015 Day 19
//

import AoCTools

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

struct Day19: AdventOfCodeDay {
    let title = "Medicine for Rudolph"

    private let molecule: Molecule
    private let replacements: [Atom: [[Atom]]]

    init(input: String) {
        var repl = [Atom: [[Atom]]]()
        var molecule = Molecule(atoms: [])
        for line in input.lines {
            let tokens = line.split(separator: " ")
            if tokens.count == 3 {
                let from = Atom(name: String(tokens[0]))
                repl[from, default: []].append(Atom.fromString(String(tokens[2])))
            } else if tokens.count == 1 {
                molecule = Molecule(atoms: Atom.fromString(String(tokens[0])))
            }
        }

        self.replacements = repl
        self.molecule = molecule
    }

    func part1() async -> Int {
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

    func part2() async -> Int {
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
        for _ in 0 ..< 100 {
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

    private func lookup(_ search: [Atom], in data: [Atom]) -> [Int] {
        let len = search.count
        if len > data.count {
            return []
        }

        var found = [Int]()
        for i in 0 ... data.count - len {
            let r = data[i ..< i + len]
            if Array(r) == search {
                found.append(i)
            }
        }

        return found
    }

}
