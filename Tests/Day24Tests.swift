//
// Advent of Code 2015 Day 24 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
1
2
3
4
5
7
8
9
10
11
"""

@Suite("Day 24 Tests") 
struct Day24Tests {
    @Test("Day 24 Part 1", .tags(.testInput))
    func testDay24_part1() async {
        let day = Day24(input: testInput)
        await #expect(day.part1() == 99)
    }

    @Test("Day 24 Part 1 Solution")
    func testDay24_part1_solution() async {
        let day = Day24(input: Day24.input)
        await #expect(day.part1() == 10439961859)
    }

    @Test("Day 24 Part 2", .tags(.testInput))
    func testDay24_part2() async {
        let day = Day24(input: testInput)
        await #expect(day.part2() == 44)
    }

    @Test("Day 24 Part 2 Solution")
    func testDay24_part2_solution() async {
        let day = Day24(input: Day24.input)
        await #expect(day.part2() == 72050269)
    }
}
