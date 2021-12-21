// Solution for part 1: X
// Solution for part 2: Y

struct Day22 {
    let day = "22"

    struct Spell: Hashable {
        let name: String
        let cost: Int
        let duration: Int? // nil == instantaneous
        let damage: Int?
        let heal: Int?
        let armor: Int?
        let mana: Int?

        init(name: String, cost: Int, duration: Int? = nil, damage: Int? = nil, heal: Int? = nil, armor: Int? = nil, mana: Int? = nil) {
            self.name = name
            self.cost = cost
            self.duration = duration
            self.damage = damage
            self.heal = heal
            self.armor = armor
            self.mana = mana
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }

        static func == (lhs: Spell, rhs: Spell) -> Bool {
            return lhs.name == rhs.name
        }
    }

    static let magicMissile = Spell(name: "Magic Missile", cost: 53, damage: 4)
    static let drain = Spell(name: "Drain", cost: 73, damage: 2, heal: 2)
    static let shield = Spell(name: "Shield", cost: 113, duration: 6, armor: 7)
    static let poison = Spell(name: "Poison", cost: 173, duration: 6, damage: 3)
    static let recharge = Spell(name: "Recharge", cost: 229, duration: 5, mana: 101)

    static let allSpells = Set([magicMissile, drain, shield, poison, recharge])

    enum CharacterType {
        case player, boss
    }

    class Character {
        let type: CharacterType
        var hp: Int
        let dmg: Int
        let armor: Int

        init(type: CharacterType, hp: Int, dmg: Int, armor: Int) {
            self.type = type
            self.hp = hp
            self.dmg = dmg
            self.armor = armor
        }

        func takeDamage(_ dmg: Int?) {
            guard let dmg = dmg else { return }
            hp -= max(1, dmg - armor)
        }
    }

    class Player: Character, CustomStringConvertible {
        var description: String {
            "Player: hp \(hp), armor \(_armor) mana \(mana)"
        }

        private var mana: Int
        private var activeSpells = [Spell: Int]()
        private var _armor: Int {
            let shield = activeSpells.keys.compactMap { $0.armor }.reduce(0, +)
            return armor + shield
        }

        init(hp: Int, armor: Int, mana: Int) {
            self.mana = mana
            super.init(type: .player, hp: hp, dmg: 0, armor: armor)
        }

        override func takeDamage(_ dmg: Int?) {
            guard let dmg = dmg else { return }
            hp -= max(1, dmg - _armor)
        }

        func selectSpell() -> Spell? {
            var allSpells = Day22.allSpells
            allSpells.subtract(Set(activeSpells.keys))
            if let spell = allSpells.randomElement() {
                if mana >= spell.cost {
                    return spell
                }
            }
            return nil
        }

        func castSpell(_ spell: Spell, against boss: Character) {
            assert(activeSpells[spell] == nil)
            mana -= spell.cost
            assert(mana >= 0)
            if let duration = spell.duration {
                activeSpells[spell] = duration
            } else {
                // mm + drain: apply effects immediately
                boss.takeDamage(spell.damage)
                hp += spell.heal ?? 0
            }
        }

        func spellEffects(against boss: Character) {
            for (spell, timer) in activeSpells {
                boss.takeDamage(spell.damage)
                mana += spell.mana ?? 0

                if timer > 1 {
                    activeSpells[spell] = timer - 1
                } else {
                    activeSpells[spell] = nil
                }
            }
        }
    }

    class Boss: Character, CustomStringConvertible {
        init(hp: Int, dmg: Int, armor: Int) {
            super.init(type: .boss, hp: hp, dmg: dmg, armor: armor)
        }

        var description: String {
            "Boss: hp \(hp), dmg \(dmg) armor \(armor)"
        }
    }


    func run() {
        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var minMana = Int.max
        for _ in 1 ... 100_000 {
            let player = Player(hp: 50, armor: 0, mana: 500)
            let boss = Boss(hp: 58, dmg: 9, armor: 0)
            if let mana = fight(player, boss) {
                minMana = min(minMana, mana)
                print(minMana)
            }
        }

        return minMana
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }
        return 42
    }

    private func fight(_ player: Player, _ boss: Boss) -> Int? {
        var totalMana = 0
        while true {
            // player hits boss
//            print("-- player turn")
//            print(player)
//            print(boss)
            player.spellEffects(against: boss)
            if let spell = player.selectSpell() {
                player.castSpell(spell, against: boss)
                totalMana += spell.cost
            } else {
//                print("no spell")
                return nil
            }

            // boss hits player
//            print("-- boss turn")
//            print(player)
//            print(boss)
            player.spellEffects(against: boss)
            player.takeDamage(boss.dmg)

            if boss.hp <= 0 {
//                print("player wins!")
//                print("total mana: \(totalMana)")
                return totalMana
            }
            if player.hp <= 0 {
//                print("player killed")
                return nil
            }
        }
    }
}
