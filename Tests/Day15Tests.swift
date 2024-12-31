//
// Advent of Code 2015 Day 15 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
"""

@Suite("Day 15 Tests") 
struct Day15Tests {
    @Test("Day 15 Part 1", .tags(.testInput))
    func testDay15_part1() async {
        let day = Day15(input: testInput)
        await #expect(day.part1() == 62842880)
    }

    @Test("Day 15 Part 1 Solution")
    func testDay15_part1_solution() async {
        let day = Day15(input: Day15.input)
        await #expect(day.part1() == 18965440)
    }

    @Test("Day 15 Part 2", .tags(.testInput))
    func testDay15_part2() async {
        let day = Day15(input: testInput)
        await #expect(day.part2() == 57600000)
    }

    @Test("Day 15 Part 2 Solution")
    func testDay15_part2_solution() async {
        let day = Day15(input: Day15.input)
        await #expect(day.part2() == 15862900)
    }
}
