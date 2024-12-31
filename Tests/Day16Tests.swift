//
// Advent of Code 2015 Day 16 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 16 Tests")
struct Day16Tests {
    @Test("Day 16 Part 1 Solution")
    func testDay16_part1_solution() async {
        let day = Day16(input: Day16.input)
        await #expect(day.part1() == 373)
    }

    @Test("Day 16 Part 2 Solution")
    func testDay16_part2_solution() async {
        let day = Day16(input: Day16.input)
        await #expect(day.part2() == 260)
    }
}
