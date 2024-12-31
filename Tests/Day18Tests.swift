//
// Advent of Code 2015 Day 18 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
.#.#.#
...##.
#....#
..#...
#.#..#
####..4
"""

@Suite("Day 18 Tests") 
struct Day18Tests {
    @Test("Day 18 Part 1", .tags(.testInput))
    func testDay18_part1() async {
        let day = Day18(input: testInput)
        await #expect(day.part1(steps: 4) == 4)
    }

    @Test("Day 18 Part 1 Solution")
    func testDay18_part1_solution() async {
        let day = Day18(input: Day18.input)
        await #expect(day.part1() == 1061)
    }

    @Test("Day 18 Part 2", .tags(.testInput))
    func testDay18_part2() async {
        let day = Day18(input: testInput)
        await #expect(day.part2(steps: 5) == 17)
    }

    @Test("Day 18 Part 2 Solution")
    func testDay18_part2_solution() async {
        let day = Day18(input: Day18.input)
        await #expect(day.part2() == 1006)
    }
}
