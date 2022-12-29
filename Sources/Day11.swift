// Solution for part 1: X
// Solution for part 2: Y

struct Day11 {
    let day = "11"
    let realData = "hepxcrrq"

    class Password {
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
                    letters[index] = l+1
                    return
                } else {
                    letters[index] = 97
                }
            }
        }

        private func hasStraight() -> Bool {
            for index in 0..<letters.count - 2 {
                if letters[index+1] == letters[index]+1 && letters[index+2] == letters[index]+2 {
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
                if letters[index+1] == letters[index] {
                    return index
                }
            }
            return nil
        }

        private func lastPairIndex() -> Int? {
            for index in (0..<letters.count - 1).reversed() {
                if letters[index+1] == letters[index] {
                    return index
                }
            }
            return nil
        }
    }

    func run() {
        let data = realData
        // let data = "abcdefgh"

        let newPwd = part1(data)
        print("Solution for part 1: \(newPwd)")
        print("Solution for part 2: \(part2(newPwd))")
    }

    private func part1(_ word: String) -> String {
        let timer = Timer(day); defer { timer.show() }
        let password = Password(string: word)
        return findNextPassword(after: password)
    }

    private func part2(_ word: String) -> String {
        let timer = Timer(day); defer { timer.show() }
        let password = Password(string: word)
        password.increment()
        return findNextPassword(after: password)
    }

    private func findNextPassword(after pwd: Password) -> String {
        while !pwd.isValid {
            pwd.increment()
        }
        return pwd.asString
    }
}
