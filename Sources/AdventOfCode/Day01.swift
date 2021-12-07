// Solution for part 1: 232
// Solution for part 2: 1783

struct Day01 {
    let day = "01"
    let testData = [ "()())" ]

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        print("Solution for part 1: \(part1(data[0]))")
        print("Solution for part 2: \(part2(data[0]))")
    }

    private func part1(_ instructions: String) -> Int {
        let timer = Timer(day); defer { timer.show() }
        var floor = 0
        instructions.forEach { ch in
            switch ch {
            case "(": floor += 1
            case ")": floor -= 1
            default: fatalError()
            }
        }
        return floor
    }

    private func part2(_ instructions: String) -> Int {
        let timer = Timer(day); defer { timer.show() }
        var floor = 0
        for (index, ch) in instructions.enumerated() {
            switch ch {
            case "(": floor += 1
            case ")": floor -= 1
            default: fatalError()
            }
            if floor < 0 {
                return index + 1
            }
        }
        fatalError()
    }
}
