//
// Advent of Code 2015 Day 2 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput1 = "2x3x4"
fileprivate let testInput2 = "1x1x10"

@Suite("Day 2 Tests") 
struct Day02Tests {
    @Test("Day 2 Part 1", .tags(.testInput))
    func testDay02_part1() async {
        var day = Day02(input: testInput1)
        await #expect(day.part1() == 58)

        day = Day02(input: testInput2)
        await #expect(day.part1() == 43)
    }

    @Test("Day 2 Part 1 Solution")
    func testDay02_part1_solution() async {
        let day = Day02(input: Day02.input)
        await #expect(day.part1() == 1586300)
    }

    @Test("Day 2 Part 2", .tags(.testInput))
    func testDay02_part2() async {
        var day = Day02(input: testInput1)
        await #expect(day.part2() == 34)

        day = Day02(input: testInput2)
        await #expect(day.part2() == 14)
    }

    @Test("Day 2 Part 2 Solution")
    func testDay02_part2_solution() async {
        let day = Day02(input: Day02.input)
        await #expect(day.part2() == 3737498)
    }
}
