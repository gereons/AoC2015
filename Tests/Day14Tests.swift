//
// Advent of Code 2015 Day 14 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
"""

@Suite("Day 14 Tests") 
struct Day14Tests {
    @Test("Day 14 Part 1", .tags(.testInput))
    func testDay14_part1() async {
        let day = Day14(input: testInput)
        await #expect(day.part1() == 2660)
    }

    @Test("Day 14 Part 1 Solution")
    func testDay14_part1_solution() async {
        let day = Day14(input: Day14.input)
        await #expect(day.part1() == 2696)
    }

    @Test("Day 14 Part 2", .tags(.testInput))
    func testDay14_part2() async {
        let day = Day14(input: testInput)
        await #expect(day.part2() == 1558)
    }

    @Test("Day 14 Part 2 Solution")
    func testDay14_part2_solution() async {
        let day = Day14(input: Day14.input)
        await #expect(day.part2() == 1084)
    }
}
