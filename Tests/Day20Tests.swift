//
// Advent of Code 2015 Day 20 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 20 Tests")
struct Day20Tests {
    @Test("Day 20 Part 1 Solution")
    func testDay20_part1_solution() async {
        let day = Day20(input: Day20.input)
        await #expect(day.part1() == 831600)
    }

    @Test("Day 20 Part 2 Solution")
    func testDay20_part2_solution() async {
        let day = Day20(input: Day20.input)
        await #expect(day.part2() == 884520)
    }
}
