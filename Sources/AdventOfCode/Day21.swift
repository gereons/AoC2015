// Solution for part 1: X
// Solution for part 2: Y

struct Day21 {
    let day = "21"

    enum ItemType {
        case weapon, armor, ring
    }

    enum CharacterType {
        case player, boss
    }

    struct Item: Equatable {
        let type: ItemType
        let cost, dmg, armor: Int
    }

    let inventory = [
        Item(type: .weapon, cost: 8, dmg: 4, armor: 0),
        Item(type: .weapon, cost: 10, dmg: 5, armor: 0),
        Item(type: .weapon, cost: 25, dmg: 6, armor: 0),
        Item(type: .weapon, cost: 40, dmg: 7, armor: 0),
        Item(type: .weapon, cost: 74, dmg: 8, armor: 0),
        Item(type: .armor, cost: 13, dmg: 0, armor: 1),
        Item(type: .armor, cost: 31, dmg: 0, armor: 2),
        Item(type: .armor, cost: 53, dmg: 0, armor: 3),
        Item(type: .armor, cost: 75, dmg: 0, armor: 4),
        Item(type: .armor, cost: 102, dmg: 0, armor: 5),
        Item(type: .ring, cost: 25, dmg: 1, armor: 0),
        Item(type: .ring, cost: 50, dmg: 2, armor: 0),
        Item(type: .ring, cost: 100, dmg: 3, armor: 0),
        Item(type: .ring, cost: 20, dmg: 0, armor: 1),
        Item(type: .ring, cost: 40, dmg: 0, armor: 2),
        Item(type: .ring, cost: 80, dmg: 0, armor: 3),
    ]

    class Character {
        let type: CharacterType
        var hp: Int
        let _dmg: Int
        let _armor: Int

        init(type: CharacterType, hp: Int, dmg: Int, armor: Int) {
            self.type = type
            self.hp = hp
            self._dmg = dmg
            self._armor = armor
        }

        var inventory = [Item?]()

        var dmg: Int {
            _dmg + inventory.compactMap { $0?.dmg }.reduce(0, +)
        }

        var armor: Int {
            _armor + inventory.compactMap { $0?.armor }.reduce(0, +)
        }

        var cost: Int {
            inventory.compactMap { $0?.cost }.reduce(0, +)
        }
    }

    func run() {
        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        let weapons = inventory.filter{ $0.type == .weapon }
        let armor = inventory.filter { $0.type == .armor } + [ nil ]
        let rings = inventory.filter { $0.type == .ring } + [ nil ]
        var minGold = Int.max
        for w in weapons {
            for a in armor {
                for r1 in rings {
                    for r2 in rings {
                        if r1 == r2 { continue }

                        let boss = Character(type: .boss, hp: 103, dmg: 9, armor: 2)
                        let player = Character(type: .player, hp: 100, dmg: 0, armor: 0)

                        player.inventory = [w, a, r1, r2]
                        let winner = fight(player, boss)
                        if winner.type == .player {
                            minGold = min(minGold, player.cost)
                        }
                    }
                }
            }
        }

        return minGold
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        let weapons = inventory.filter{ $0.type == .weapon }
        let armor = inventory.filter { $0.type == .armor } + [ nil ]
        let rings = inventory.filter { $0.type == .ring } + [ nil ]
        var maxGold = 0
        for w in weapons {
            for a in armor {
                for r1 in rings {
                    for r2 in rings {
                        if r1 == r2 { continue }

                        let boss = Character(type: .boss, hp: 103, dmg: 9, armor: 2)
                        let player = Character(type: .player, hp: 100, dmg: 0, armor: 0)

                        player.inventory = [w, a, r1, r2]
                        let winner = fight(player, boss)
                        if winner.type == .boss {
                            maxGold = max(maxGold, player.cost)
                        }
                    }
                }
            }
        }

        return maxGold
    }

    // return true if c1 wins
    private func fight(_ c1: Character, _ c2: Character) -> Character {
        var c1 = c1
        var c2 = c2

        while true {
            // c1 attacks c2
            let dmgDealt = max(1, c1.dmg - c2.armor)
            c2.hp -= dmgDealt
            // print(c1.type, "hits", c2.type, dmgDealt, c2.hp)
            if c2.hp <= 0 {
                return c1
            }
            swap(&c1, &c2)
        }
    }
}
