// Solution for part 1: X
// Solution for part 2: Y

struct Day17 {
    let day = "17"
    let testData = [ "20", "15", "10", "5", "5"  ]

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let containers = Timer.time(day) {
            data.compactMap { Int($0) }
        }

        // assert(4 == sum_up(numbers: data, target: 25)

        let (count, minCounts) = part1and2(containers)
        print("Solution for part 1: \(count)")
        print("Solution for part 2: \(minCounts)")
    }

    private func part1and2(_ containers: [Int]) -> (Int, Int) {
        let timer = Timer(day); defer { timer.show() }
        let result = sumUp(numbers: containers, target: 150)
        let minContainers = result.map { $0.count }.min()

        let minCount = result.filter { $0.count == minContainers }.count
        return (result.count, minCount)
    }

    private func sumUp(numbers: [Int], target: Int) -> [[Int]] {
        var result = [[Int]]()
        sumUp(numbers, target, [], &result)
        return result
    }

    private func sumUp(_ numbers: [Int], _ target: Int, _ partial: [Int], _ result: inout [[Int]])
    {
        let partialSum = partial.reduce(0, +)

        if partialSum == target {
            result.append(partial)
        }

        if partialSum >= target {
            return
        }

        for i in 0..<numbers.count {
            let remaining = Array(numbers[(i + 1) ..< numbers.count])

            var newPartial = partial
            newPartial.append(numbers[i])
            sumUp(remaining, target, newPartial, &result)
        }
    }


}
