//
// Advent of Code 2015 Day 6 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 6 Tests") 
struct Day06Tests {
    @Test("Day 6 Part 1 Solution")
    func testDay06_part1_solution() async {
        let day = Day06(input: Day06.input)
        await #expect(day.part1() == 377891)
    }

    @Test("Day 6 Part 2 Solution")
    func testDay06_part2_solution() async {
        let day = Day06(input: Day06.input)
        await #expect(day.part2() == 14110788)
    }
}
