//
// Advent of Code 2015 Day 22
//

import AoCTools

struct Day22: AdventOfCodeDay {
    let title = "Wizard Simulator 20XX"

    struct Spell: Hashable {
        let name: String
        let cost: Int
        let duration: Int // 0 == instantaneous
        let damage: Int
        let heal: Int
        let armor: Int
        let mana: Int

        init(name: String, cost: Int, duration: Int = 0, damage: Int = 0, heal: Int = 0, armor: Int = 0, mana: Int = 0) {
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

        static let magicMissile = Spell(name: "Magic Missile", cost: 53, damage: 4)
        static let drain = Spell(name: "Drain", cost: 73, damage: 2, heal: 2)
        static let shield = Spell(name: "Shield", cost: 113, duration: 6, armor: 7)
        static let poison = Spell(name: "Poison", cost: 173, duration: 6, damage: 3)
        static let recharge = Spell(name: "Recharge", cost: 229, duration: 5, mana: 101)

        static let allSpells = [magicMissile, drain, shield, poison, recharge]
    }

    let boss: (hp: Int, dmg: Int)

    struct GameState {
        var playerHP: Int
        var playerMana: Int
        var activeSpells: [Spell: Int]
        var bossHP: Int
        let bossDamage: Int
        let hardMode: Bool
    }

    init(input: String) {
        let lines = input.lines
        let hp = lines[0].integers()[0]
        let dmg = lines[1].integers()[0]
        boss = (hp: hp, dmg: dmg)
    }

    func part1() async -> Int {
        await part1(hp: 50, mana: 500)
    }

    func part1(hp: Int, mana: Int) async -> Int {
        let state = GameState(
            playerHP: hp,
            playerMana: mana,
            activeSpells: [:],
            bossHP: boss.hp,
            bossDamage: boss.dmg,
            hardMode: false
        )
        return leastManaToKillBoss(state, manaLimit: Int.max)
    }

    func part2() async -> Int {
        let state = GameState(
            playerHP: 50,
            playerMana: 500,
            activeSpells: [:],
            bossHP: boss.hp,
            bossDamage: boss.dmg,
            hardMode: true
        )
        return leastManaToKillBoss(state, manaLimit: Int.max)
    }

    private func leastManaToKillBoss(_ gameState: GameState, manaLimit: Int) -> Int {
        var manaLimit = manaLimit
        var manaUsage = [Spell: Int]()

        let availableSpells = Spell.allSpells.filter {
            gameState.activeSpells[$0, default: 0] <= 1
        }

        for spell in availableSpells {
            if spell.cost > gameState.playerMana || spell.cost > manaLimit {
                continue
            }
            let nextGameState = oneRound(casting: spell, gameState: gameState)
            if nextGameState.bossHP <= 0 {
                manaUsage[spell] = spell.cost
            } else if nextGameState.playerHP > 0 {
                let lowestMana = leastManaToKillBoss(nextGameState, manaLimit: manaLimit - spell.cost)
                if lowestMana < manaLimit {
                    manaLimit = lowestMana
                }
                manaUsage[spell] = spell.cost + lowestMana
            }
        }

        if manaUsage.isEmpty {
            return 99999
        }

        return manaUsage.values.min()!
    }

    private func oneRound(casting: Spell, gameState: GameState) -> GameState {
        var playerArmor = 0
        var gameState = gameState

        if gameState.hardMode {
            gameState.playerHP -= 1
            if gameState.playerHP <= 0 {
                return gameState
            }
        }

        applyEffects(to: &gameState, armor: &playerArmor)
        if gameState.bossHP <= 0 {
            return gameState
        }

        gameState.playerMana -= casting.cost
        switch casting {
        case .magicMissile:
            gameState.bossHP -= casting.damage
        case .drain:
            gameState.bossHP -= casting.damage
            gameState.playerHP += casting.heal
        default:
            gameState.activeSpells[casting] = casting.duration
        }
        if gameState.bossHP <= 0 {
            return gameState
        }

        applyEffects(to: &gameState, armor: &playerArmor)
        if gameState.bossHP <= 0 {
            return gameState
        }
        let damage = gameState.bossDamage - playerArmor
        gameState.playerHP -= damage
        
        return gameState
    }

    private func applyEffects(to gameState: inout GameState, armor: inout Int) {
        for (spell, duration) in gameState.activeSpells {
            switch spell {
            case .shield:
                armor = spell.armor
            case .poison:
                gameState.bossHP -= spell.damage
            case .recharge:
                gameState.playerMana += spell.mana
            default:
                break
            }
            gameState.activeSpells[spell] = duration == 1 ? nil : duration - 1
        }
    }
}
