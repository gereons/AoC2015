// Solution for part 1: X
// Solution for part 2: Y

import CryptoKit

struct Day04 {
    let day = "04"
    let testData = [ "abcdef" ]

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let prefix5 = part1(data[0])
        print("Solution for part 1: \(prefix5)")
        print("Solution for part 2: \(part2(data[0], start: prefix5))")
    }

    private func part1(_ prefix: String) -> Int {
        let timer = Timer(day); defer { timer.show() }

        for num in 0..<100_000_000 {
            let str = "\(prefix)\(num)"
            let data = str.data(using: .utf8)!
            let md5 = Insecure.MD5.hash(data: data).map { $0 }
            if md5[0] == 0 && md5[1] == 0 && md5[2] & 0xf0 == 0 {
                // print(md5.map { String(format: "%02hhx", $0) }.joined())
                return num
            }
        }

        return 42
    }

    private func part2(_ prefix: String, start: Int) -> Int {
        let timer = Timer(day); defer { timer.show() }

        for num in start..<100_000_000 {
            let str = "\(prefix)\(num)"
            let data = str.data(using: .utf8)!
            let md5 = Insecure.MD5.hash(data: data).map { $0 }
            if md5[0] == 0 && md5[1] == 0 && md5[2] == 0 {
                // print(md5.map { String(format: "%02hhx", $0) }.joined())
                return num
            }
        }

        return 42
    }
}
