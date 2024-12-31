//
// Advent of Code 2015 Day 17 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
20
15
10
5
5
"""

@Suite("Day 17 Tests") 
struct Day17Tests {
    @Test("Day 17 Part 1", .tags(.testInput))
    func testDay17_part1() async {
        let day = Day17(input: testInput)
        await #expect(day.part1(target: 25) == 4)
    }

    @Test("Day 17 Part 1 Solution")
    func testDay17_part1_solution() async {
        let day = Day17(input: Day17.input)
        await #expect(day.part1() == 1304)
    }

    @Test("Day 17 Part 2", .tags(.testInput))
    func testDay17_part2() async {
        let day = Day17(input: testInput)
        await #expect(day.part2(target: 25) == 3)
    }

    @Test("Day 17 Part 2 Solution")
    func testDay17_part2_solution() async {
        let day = Day17(input: Day17.input)
        await #expect(day.part2() == 18)
    }
}
