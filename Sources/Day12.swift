//
// Advent of Code 2015 Day 12
//

import AoCTools
import Foundation

struct Day12: AdventOfCodeDay {
    let title = "JSAbacusFramework.io"

    let json: Any

    init(input: String) {
        let bytes = input.data(using: .utf8)!
        self.json = (try? JSONSerialization.jsonObject(with: bytes, options: []))!
    }

    func part1() async -> Int {
        return sumAllNumbers(in: json)
    }

    func part2() async -> Int {
        return sumAllNonRedNumbers(in: json)
    }

    private func sumAllNumbers(in json: Any) -> Int {
        if let dict = json as? [String: Any] {
            return dict.values.reduce(0) { sum, json in
                sum + sumAllNumbers(in: json)
            }
        } else if let arr = json as? [Any] {
            return arr.reduce(0) { sum, json in
                sum + sumAllNumbers(in: json)
            }
        } else if let num = json as? NSNumber {
            return num.intValue
        }

        return 0
    }

    private func sumAllNonRedNumbers(in json: Any) -> Int {
        if let dict = json as? [String: Any] {
            let firstRed = dict.values.first { val in
                if let str = val as? String, str == "red" {
                    return true
                }
                return false
            }
            if firstRed != nil {
                return 0
            }

            return dict.values.reduce(0) { sum, json in
                sum + sumAllNonRedNumbers(in: json)
            }
        } else if let arr = json as? [Any] {
            return arr.reduce(0) { sum, json in
                sum + sumAllNonRedNumbers(in: json)
            }
        } else if let num = json as? NSNumber {
            return num.intValue
        }

        return 0
    }
}
