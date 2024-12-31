//
// Advent of Code 2015 Day 10 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
"""

@Suite("Day 10 Tests") 
struct Day10Tests {
    @Test("Day 10 Part 1", .tags(.testInput))
    func testDay10_part1() async {
        var day = Day10(input: "1")
        await #expect(day.part1(count: 1) == 2)
        day = Day10(input: "11")
        await #expect(day.part1(count: 1) == 2)
        day = Day10(input: "21")
        await #expect(day.part1(count: 1) == 4)
        day = Day10(input: "1211")
        await #expect(day.part1(count: 1) == 6)
        day = Day10(input: "111221")
        await #expect(day.part1(count: 1) == 6)
    }

    @Test("Day 10 Part 1 Solution")
    func testDay10_part1_solution() async {
        let day = Day10(input: Day10.input)
        await #expect(day.part1() == 252594)
    }

    @Test("Day 10 Part 2 Solution")
    func testDay10_part2_solution() async {
        let day = Day10(input: Day10.input)
        await #expect(day.part2() == 3579328)
    }
}
