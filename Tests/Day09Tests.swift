//
// Advent of Code 2015 Day 9 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141
"""

@Suite("Day 9 Tests") 
struct Day09Tests {
    @Test("Day 9 Part 1", .tags(.testInput))
    func testDay09_part1() async {
        let day = Day09(input: testInput)
        await #expect(day.part1() == 605)
    }

    @Test("Day 9 Part 1 Solution")
    func testDay09_part1_solution() async {
        let day = Day09(input: Day09.input)
        await #expect(day.part1() == 117)
    }

    @Test("Day 9 Part 2", .tags(.testInput))
    func testDay09_part2() async {
        let day = Day09(input: testInput)
        await #expect(day.part2() == 982)
    }

    @Test("Day 9 Part 2 Solution")
    func testDay09_part2_solution() async {
        let day = Day09(input: Day09.input)
        await #expect(day.part2() == 909)
    }
}
