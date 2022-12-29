// Solution for part 1: X
// Solution for part 2: Y

struct Day05 {
    let day = "05"
    let testData1 = [ "ugknbfddgicrmopn","aaa","jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvszwmarrgswjxmb" ]
    let testData2 = [ "qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy" ]

    func run() {
        // let data = testData2
        let data = Self.rawInput.components(separatedBy: "\n")

        print("Solution for part 1: \(part1(data))")
        print("Solution for part 2: \(part2(data))")
    }

    private func part1(_ words: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        return words.reduce(0) { sum, word in
            sum + (isNice1(word) ? 1 : 0)
        }
    }

    private func part2(_ words: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        return words.reduce(0) { sum, word in
            sum + (isNice2(word) ? 1 : 0)
        }
    }

    private func isNice1(_ word: String) -> Bool {
        let forbidden = [ "ab", "cd", "pq", "xy" ]
        for f in forbidden {
            if word.contains(f) {
                // print("naughty: \(word)")
                return false
            }
        }

        let vowels = "aeiou"
        let vowelsInWord = word.filter { vowels.contains($0) }
        if vowelsInWord.count < 3 {
            // print("naughty: \(word)")
            return false
        }

        var foundDouble = false
        for ch in "abcdefghijklmnopqrstuvwxyz" {
            let pair = "\(ch)\(ch)"
            if word.contains(pair) {
                foundDouble = true
                break
            }
        }

        return foundDouble
    }

    private func isNice2(_ word: String) -> Bool {
        let start = word.startIndex
        var found = false
        for index in 0..<word.count - 1 {
            let pair = word[word.index(start, offsetBy: index)...word.index(start, offsetBy: index + 1)]
            for idx2 in (index + 2) ..< word.count {
                if word.dropFirst(idx2).prefix(2) == pair {
                    found = true
                    break
                }
            }
        }
        if !found {
            // print("naughty: \(word)")
            return false
        }

        for index in 0..<word.count - 2 {
            let ch1 = word[word.index(start, offsetBy: index)]
            let ch2 = word[word.index(start, offsetBy: index + 2)]
            if ch1 == ch2 {
                return true
            }
        }

        // print("naughty: \(word)")
        return false
    }
}
