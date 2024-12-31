//
// Advent of Code 2015 Day 22 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Hit Points: 13
Damage: 8
"""

fileprivate let testInput2 = """
Hit Points: 14
Damage: 8
"""

@Suite("Day 22 Tests") 
struct Day22Tests {
    @Test("Day 22 Part 1", .tags(.testInput))
    func testDay22_part1() async {
        var day = Day22(input: testInput)
        await #expect(day.part1(hp: 10, mana: 250) == 226)

        day = Day22(input: testInput2)
        await #expect(day.part1(hp: 10, mana: 250) == 641)
    }

    @Test("Day 22 Part 1 Solution")
    func testDay22_part1_solution() async {
        let day = Day22(input: Day22.input)
        await #expect(day.part1() == 1269)
    }

    @Test("Day 22 Part 2 Solution")
    func testDay22_part2_solution() async {
        let day = Day22(input: Day22.input)
        await #expect(day.part2() == 1309)
    }
}
