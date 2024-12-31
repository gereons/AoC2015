//
// Advent of Code 2015 Day 3 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput1 = "^>v<"
fileprivate let testInput2 = "^v^v^v^v^v"

@Suite("Day 3 Tests") 
struct Day03Tests {
    @Test("Day 3 Part 1", .tags(.testInput))
    func testDay03_part1() async {
        var day = Day03(input: testInput1)
        await #expect(day.part1() == 4)

        day = Day03(input: testInput2)
        await #expect(day.part1() == 2)
    }

    @Test("Day 3 Part 1 Solution")
    func testDay03_part1_solution() async {
        let day = Day03(input: Day03.input)
        await #expect(day.part1() == 2565)
    }

    @Test("Day 3 Part 2", .tags(.testInput))
    func testDay03_part2() async {
        var day = Day03(input: testInput1)
        await #expect(day.part2() == 3)

        day = Day03(input: testInput2)
        await #expect(day.part2() == 11)
    }

    @Test("Day 3 Part 2 Solution")
    func testDay03_part2_solution() async {
        let day = Day03(input: Day03.input)
        await #expect(day.part2() == 2639)
    }
}
