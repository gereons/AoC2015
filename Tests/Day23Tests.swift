//
// Advent of Code 2015 Day 23 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 23 Tests") 
struct Day23Tests {
    @Test("Day 23 Part 1 Solution")
    func testDay23_part1_solution() async {
        let day = Day23(input: Day23.input)
        await #expect(day.part1() == 307)
    }

    @Test("Day 23 Part 2 Solution")
    func testDay23_part2_solution() async {
        let day = Day23(input: Day23.input)
        await #expect(day.part2() == 160)
    }
}
