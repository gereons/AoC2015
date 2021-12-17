// Solution for part 1: X
// Solution for part 2: Y
import Foundation

struct Day20 {
    let day = "20"

    func run() {
        print("Solution for part 1: \(part1(target: 36000000))")
        print("Solution for part 2: \(part2(target: 36000000))")
    }

    private func part1(target: Int) -> Int {
        let timer = Timer(day); defer { timer.show() }

        for i in 1..<Int.max {
            let p = divisors(of: i).reduce(0, +) * 10
            if p >= target {
                return i
            }
        }
        fatalError()
    }

    private func part2(target: Int) -> Int {
        let timer = Timer(day); defer { timer.show() }

        for i in 1..<Int.max {
            let p = divisors(of: i, limit: 50).reduce(0, +) * 11
            if p >= target {
                return i
            }
        }
        fatalError()
    }

    private func divisors(of n: Int, limit: Int = 0) -> [Int] {
        var d: [Int] = []
        var i = 1
        while i <= Int(sqrt(Double(n))) {
            if n % i == 0 {
                let j = n/i
                if limit == 0 || j <= limit {
                    d.append(i)
                }
                if i != j && (limit == 0 || i <= limit) {
                    d.append(j)
                }
            }
            i += 1
        }
        return d
    }

}
