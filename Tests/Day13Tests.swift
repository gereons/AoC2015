//
// Advent of Code 2015 Day 13 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.
Alice would lose 2 happiness units by sitting next to David.
Bob would gain 83 happiness units by sitting next to Alice.
Bob would lose 7 happiness units by sitting next to Carol.
Bob would lose 63 happiness units by sitting next to David.
Carol would lose 62 happiness units by sitting next to Alice.
Carol would gain 60 happiness units by sitting next to Bob.
Carol would gain 55 happiness units by sitting next to David.
David would gain 46 happiness units by sitting next to Alice.
David would lose 7 happiness units by sitting next to Bob.
David would gain 41 happiness units by sitting next to Carol.
"""

@Suite("Day 13 Tests") 
struct Day13Tests {
    @Test("Day 13 Part 1", .tags(.testInput))
    func testDay13_part1() async {
        let day = Day13(input: testInput)
        await #expect(day.part1() == 330)
    }

    @Test("Day 13 Part 1 Solution")
    func testDay13_part1_solution() async {
        let day = Day13(input: Day13.input)
        await #expect(day.part1() == 664)
    }

    @Test("Day 13 Part 2", .tags(.testInput))
    func testDay13_part2() async {
        let day = Day13(input: testInput)
        await #expect(day.part2() == 286)
    }

    @Test("Day 13 Part 2 Solution")
    func testDay13_part2_solution() async {
        let day = Day13(input: Day13.input)
        await #expect(day.part2() == 640)
    }
}
