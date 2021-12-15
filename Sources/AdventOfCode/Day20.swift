// Solution for part 1: X
// Solution for part 2: Y
import Foundation

struct Day20 {
    let day = "20"

    func run() {
        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        let house = 36000000
        let target = presents(for: house)
        print("target", target)
        // target = 1297444330
        //          129744433
        // house = 27387360
        for i in 1..<house {
            let p = presents(for: i)
            if p >= target {
                print(i, p)
                return i
            }
        }
        fatalError()
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }
        return 42
    }

    private func presents(for house: Int) -> Int {
        divisors(of: house).reduce(0, +) * 10
    }

    private func divisors(of number: Int) -> [Int] {
        var results = [Int]()
        let sqrt = Int(sqrt(Double(number)))
        for i in 1...sqrt {
            if number.isMultiple(of: i) {
                results.append(i)
                if number / i != i {
                    results.append(number / i)
                }
            }
        }
        return results
    }

}
