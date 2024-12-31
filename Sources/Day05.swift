//
// Advent of Code 2015 Day 5
//

import AoCTools
import Algorithms

struct Day05: AdventOfCodeDay {
    let title = "Doesn't He Have Intern-Elves For This?"

    let words: [String]

    init(input: String) {
        words = input.lines
    }

    func part1() async -> Int {
        words.count(where: isNice1)
    }

    func part2() async -> Int {
        words.count(where: isNice2)
    }

    private func isNice1(_ word: String) -> Bool {
        let forbidden = [ "ab", "cd", "pq", "xy" ]
        for f in forbidden {
            if word.contains(f) {
                // print("naughty: \(word)")
                return false
            }
        }

        let vowels = Set("aeiou")
        let vowelsInWord = word.filter { vowels.contains($0) }
        if vowelsInWord.count < 3 {
            // print("naughty: \(word)")
            return false
        }

        let double = word.adjacentPairs().first { $0.0 == $0.1 }
        return double != nil
    }

    private func isNice2(_ word: String) -> Bool {
        let start = word.startIndex
        var found = false
        for index in 0 ..< word.count - 1 {
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

        for index in 0 ..< word.count - 2 {
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
