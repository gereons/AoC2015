//
// Advent of Code 2015 Day 4 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = "abcdef"

@Suite("Day 4 Tests") 
struct Day04Tests {
    @Test("Day 4 Part 1", .tags(.testInput))
    func testDay04_part1() async {
        let day = Day04(input: testInput)
        await #expect(day.part1() == 609043)
    }

    @Test("Day 4 Part 1 Solution")
    func testDay04_part1_solution() async {
        let day = Day04(input: Day04.input)
        await #expect(day.part1() == 282749)
    }

    @Test("Day 4 Part 2 Solution")
    func testDay04_part2_solution() async {
        let day = Day04(input: Day04.input)
        await #expect(day.part2() == 9962624)
    }
}
