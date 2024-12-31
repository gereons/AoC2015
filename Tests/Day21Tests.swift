//
// Advent of Code 2015 Day 21 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 21 Tests")
struct Day21Tests {
    @Test("Day 21 Part 1 Solution")
    func testDay21_part1_solution() async {
        let day = Day21(input: Day21.input)
        await #expect(day.part1() == 121)
    }

    @Test("Day 21 Part 2 Solution")
    func testDay21_part2_solution() async {
        let day = Day21(input: Day21.input)
        await #expect(day.part2() == 201)
    }
}
