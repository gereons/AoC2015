//
// Advent of Code 2015 Day 4
//

import CryptoKit
import AoCTools

struct Day04: AdventOfCodeDay {
    let title = "The Ideal Stocking Stuffer"

    let prefix: String

    init(input: String) {
        prefix = input
    }

    func part1() async -> Int {
        for num in 0..<100_000_000 {
            let str = "\(prefix)\(num)"
            let data = str.data(using: .utf8)!
            let md5 = Array(Insecure.MD5.hash(data: data))
            if md5[0] == 0 && md5[1] == 0 && md5[2] & 0xf0 == 0 {
                // print(md5.map { String(format: "%02hhx", $0) }.joined())
                return num
            }
        }

        fatalError()
    }

    func part2() async -> Int {
        for num in 0..<100_000_000 {
            let str = "\(prefix)\(num)"
            let data = str.data(using: .utf8)!
            let md5 = Array(Insecure.MD5.hash(data: data))
            if md5[0] == 0 && md5[1] == 0 && md5[2] == 0 {
                // print(md5.map { String(format: "%02hhx", $0) }.joined())
                return num
            }
        }

        fatalError()
    }
}
