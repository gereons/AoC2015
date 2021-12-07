// Solution for part 1: X
// Solution for part 2: Y

struct Day17 {
    let day = "17"
    let testData = [ "1","2","3" ]

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let positions = Timer.time(day) {
            data.compactMap { Int($0) }
        }

        print("Solution for part 1: \(part1(positions))")
        print("Solution for part 2: \(part2(positions))")
    }

    private func part1(_ positions: [Int]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        return 42
    }

    private func part2(_ positions: [Int]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        return 42
    }
}
