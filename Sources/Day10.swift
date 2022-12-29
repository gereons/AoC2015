// Solution for part 1: X
// Solution for part 2: Y

struct Day10 {
    let day = "10"
    let testData = [ "1","11","21", "1211", "111221" ]
    let realData = "1113222113"

    func run() {
        // let data = testData

        print("Solution for part 1: \(part1(realData))")
        print("Solution for part 2: \(part2(realData))")
    }

    private func lookAndSay(_ input: [Int]) -> [Int] {
        var prev = input[0]
        var count = 0
        var output = [Int]()

        for ch in input {
            if ch == prev {
                count += 1
            } else {
                output.append(count)
                output.append(prev)
                count = 1
            }
            prev = ch
        }

        output.append(count)
        output.append(prev)

        return output
    }

    private func part1(_ str: String) -> Int {
        let timer = Timer(day); defer { timer.show() }
        var digits = str.compactMap { Int(String($0)) }
        for _ in 0..<40 {
            digits = lookAndSay(digits)
        }
        return digits.count
    }

    private func part2(_ str: String) -> Int {
        let timer = Timer(day); defer { timer.show() }
        var digits = str.compactMap { Int(String($0)) }
        for _ in 0..<50 {
            digits = lookAndSay(digits)
        }
        return digits.count
    }
}
