//
// Advent of Code 2015 Day 12 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 12 Tests") 
struct Day12Tests {
    @Test("Day 12 Part 1", .tags(.testInput))
    func testDay12_part1() async {
        var day = Day12(input: "[1,2,3]")
        await #expect(day.part1() == 6)

        day = Day12(input: #"{"a":{"b":4},"c":-1}"#)
        await #expect(day.part1() == 3)
    }

    @Test("Day 12 Part 1 Solution")
    func testDay12_part1_solution() async {
        let day = Day12(input: Day12.input)
        await #expect(day.part1() == 111754)
    }

    @Test("Day 12 Part 2", .tags(.testInput))
    func testDay12_part2() async {
        var day = Day12(input: #"[1,"red",5]"#)
        await #expect(day.part2() == 6)

        day = Day12(input: #"[1,{"c":"red","b":2},3]"#)
        await #expect(day.part2() == 4)
    }

    @Test("Day 12 Part 2 Solution")
    func testDay12_part2_solution() async {
        let day = Day12(input: Day12.input)
        await #expect(day.part2() == 65402)
    }
}
