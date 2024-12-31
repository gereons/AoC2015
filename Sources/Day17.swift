//
// Advent of Code 2015 Day 17
//

import AoCTools

struct Day17: AdventOfCodeDay {
    let title = "No Such Thing as Too Much"

    let containers: [Int]

    init(input: String) {
        containers = input.lines.map { Int($0)! }
    }

    func part1() async -> Int {
        await part1(target: 150)
    }

    func part1(target: Int) async -> Int {
        let result = sumUp(numbers: containers, target: target)
        return result.count
    }

    func part2() async -> Int {
        await part2(target: 150)
    }

    func part2(target: Int) async -> Int {
        let result = sumUp(numbers: containers, target: target)
        let minContainers = result.map { $0.count }.min()

        let minCount = result.filter { $0.count == minContainers }.count
        return minCount
    }

    private func sumUp(numbers: [Int], target: Int) -> [[Int]] {
        var result = [[Int]]()
        sumUp(numbers, target, [], &result)
        return result
    }

    private func sumUp(_ numbers: [Int], _ target: Int, _ partial: [Int], _ result: inout [[Int]]) {
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
