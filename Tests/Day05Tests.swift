//
// Advent of Code 2015 Day 5 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
ugknbfddgicrmopn
aaa
jchzalrnumimnmhp
haegwjzuvuyypxyu
dvszwmarrgswjxmb
"""

fileprivate let testInput2 = """
qjhvhtzxzqqjkmpb
xxyxx
uurcxstgmygtbstg
ieodomkazucvgmuy
"""

@Suite("Day 5 Tests")
struct Day05Tests {
    @Test("Day 5 Part 1", .tags(.testInput))
    func testDay05_part1() async {
        let day = Day05(input: testInput)
        await #expect(day.part1() == 2)
    }

    @Test("Day 5 Part 1 Solution")
    func testDay05_part1_solution() async {
        let day = Day05(input: Day05.input)
        await #expect(day.part1() == 238)
    }

    @Test("Day 5 Part 2", .tags(.testInput))
    func testDay05_part2() async {
        let day = Day05(input: testInput2)
        await #expect(day.part2() == 2)
    }

    @Test("Day 5 Part 2 Solution")
    func testDay05_part2_solution() async {
        let day = Day05(input: Day05.input)
        await #expect(day.part2() == 69)
    }
}
