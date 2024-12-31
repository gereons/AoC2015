//
// Advent of Code 2015 Day 1 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
"""

@Suite("Day 1 Tests") 
struct Day01Tests {
    @Test("Day 1 Part 1", .tags(.testInput))
    func testDay01_part1() async {
        var day = Day01(input: "(())")
        await #expect(day.part1() == 0)

        day = Day01(input: "()()")
        await #expect(day.part1() == 0)

        day = Day01(input: "(((")
        await #expect(day.part1() == 3)

        day = Day01(input: "(()(()(")
        await #expect(day.part1() == 3)

        day = Day01(input: "))(((((")
        await #expect(day.part1() == 3)

        day = Day01(input: "())")
        await #expect(day.part1() == -1)

        day = Day01(input: "))(")
        await #expect(day.part1() == -1)

        day = Day01(input: ")))")
        await #expect(day.part1() == -3)

        day = Day01(input: ")())())")
        await #expect(day.part1() == -3)
    }

    @Test("Day 1 Part 1 Solution")
    func testDay01_part1_solution() async {
        let day = Day01(input: Day01.input)
        await #expect(day.part1() == 232)
    }

    @Test("Day 1 Part 2", .tags(.testInput))
    func testDay01_part2() async {
        let day = Day01(input: "()())")
        await #expect(day.part2() == 5)
    }

    @Test("Day 1 Part 2 Solution")
    func testDay01_part2_solution() async {
        let day = Day01(input: Day01.input)
        await #expect(day.part2() == 1783)
    }
}
