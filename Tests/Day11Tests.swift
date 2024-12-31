//
// Advent of Code 2015 Day 11 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 11 Tests")
struct Day11Tests {
    @Test("Day 11 Part 1", .tags(.testInput))
    func testDay11_part1() async {
        var day = Day11(input: "abcdefgh")
        await #expect(day.part1() == "abcdffaa")

        day = Day11(input: "ghijklmn")
        await #expect(day.part1() == "ghjaabcc")
    }

    @Test("Day 11 Part 1 Solution")
    func testDay11_part1_solution() async {
        let day = Day11(input: Day11.input)
        await #expect(day.part1() == "hepxxyzz")
    }

    @Test("Day 11 Part 2 Solution")
    func testDay11_part2_solution() async {
        let day = Day11(input: Day11.input)
        await #expect(day.part2() == "heqaabcc")
    }
}
