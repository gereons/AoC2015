//
// Advent of Code 2015 Day 25 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 25 Tests") 
struct Day25Tests {
    @Test("Day 25 Part 1 Solution")
    func testDay25_part1_solution() async {
        let day = Day25(input: Day25.input)
        await #expect(day.part1() == 2650453)
    }
}
