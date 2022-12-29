// Solution for part 1: X
// Solution for part 2: Y

import Foundation

struct Day12 {
    let day = "12"
    let testData = [
//        "[1,2,3]",
        #"[1,{"c":"red","b":2},3]"#,
//        #"{"d":"red","e":[1,2,3,4],"f":5}"#,
//        #"[1,"red",5]"#
    ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let json = Timer.time(day) {
            let bytes = data[0].data(using: .utf8)!
            return try! JSONSerialization.jsonObject(with: bytes, options: [])
        }

        print("Solution for part 1: \(part1(json))")
        print("Solution for part 2: \(part2(json))")
    }

    private func part1(_ json: Any) -> Int {
        let timer = Timer(day); defer { timer.show() }

        return sumAllNumbers(in: json)
    }

    private func part2(_ json: Any) -> Int {
        let timer = Timer(day); defer { timer.show() }
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
            if nil != dict.values.first(where: { val -> Bool in
                if let str = val as? NSString, str == "red" {
                    return true
                }
                return false
            }) {
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
