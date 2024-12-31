//
// Advent of Code 2015 Day 7 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i
"""

@Suite("Day 7 Tests") 
struct Day07Tests {
    @Test("Day 7 Part 1", .tags(.testInput))
    func testDay07_part1() async {
        let day = Day07(input: testInput)
        var memory = [String: UInt16]()
        day.evaluate(op: day.operations["i"]!, day.operations, &memory)
        #expect(memory["i"] == 65079)
    }

    @Test("Day 7 Part 1 Solution")
    func testDay07_part1_solution() async {
        let day = Day07(input: Day07.input)
        await #expect(day.part1() == 46065)
    }

    @Test("Day 7 Part 2 Solution")
    func testDay07_part2_solution() async {
        let day = Day07(input: Day07.input)
        await #expect(day.part2() == 14134)
    }
}
