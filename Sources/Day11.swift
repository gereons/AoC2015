//
// Advent of Code 2015 Day 11
//

import AoCTools

struct Day11: AdventOfCodeDay {
    let title = "Corporate Policy"

    final class Password {
        private var letters: [Int]

        init(string: String) {
            letters = string.map { Int($0.asciiValue!) }
            assert(letters.count == 8)
        }

        var asString: String {
            String(letters.map {
                Character(UnicodeScalar(UInt8($0)))
            })
        }

        var isValid: Bool {
            if letters.contains(105) || letters.contains(108) || letters.contains(111) {
                return false
            }
            if !hasStraight() {
                return false
            }
            if !hasTwoPairs() {
                return false
            }

            return true
        }

        func increment() {
            for index in (0..<letters.count).reversed() {
                let l = letters[index]
                if l < 122 {
                    letters[index] = l + 1
                    return
                } else {
                    letters[index] = 97
                }
            }
        }

        private func hasStraight() -> Bool {
            for index in 0..<letters.count - 2 {
                if letters[index + 1] == letters[index] + 1 && letters[index + 2] == letters[index] + 2 {
                    return true
                }
            }
            return false
        }

        private func hasTwoPairs() -> Bool {
            guard let first = firstPairIndex(), let last = lastPairIndex() else {
                return false
            }
            return abs(first - last) > 1
        }

        private func firstPairIndex() -> Int? {
            for index in 0..<letters.count - 1 {
                if letters[index + 1] == letters[index] {
                    return index
                }
            }
            return nil
        }

        private func lastPairIndex() -> Int? {
            for index in (0..<letters.count - 1).reversed() {
                if letters[index + 1] == letters[index] {
                    return index
                }
            }
            return nil
        }
    }

    let password: String

    init(input: String) {
        self.password = input
    }

    func part1() async -> String {
        return findNextPassword(after: password)
    }

    func part2() async -> String {
        let newPassword = findNextPassword(after: password)
        return findNextPassword(after: newPassword)
    }

    private func findNextPassword(after oldPassword: String) -> String {
        let pwd = Password(string: oldPassword)
        repeat {
            pwd.increment()
        } while !pwd.isValid
        return pwd.asString
    }
}
