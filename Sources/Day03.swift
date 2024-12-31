//
// Advent of Code 2015 Day 3
//

import AoCTools

struct Day03: AdventOfCodeDay {
    let title = "Perfectly Spherical Houses in a Vacuum"

    let directions: String

    init(input: String) {
        self.directions = input
    }

    func part1() async -> Int {
        var visited = [Point: Bool]()
        return countVisits(directions, &visited)
    }

    func part2() async -> Int {
        let santa = directions
            .enumerated()
            .filter { index, _ in
                index.isMultiple(of: 2)
            }
            .map { String($0.element) }
            .joined()

        let roboSanta = directions
            .enumerated()
            .filter { index, _ in
                !index.isMultiple(of: 2)
            }
            .map { String($0.element) }
            .joined()

        var visited = [Point: Bool]()
        _ = countVisits(santa, &visited)
        return countVisits(roboSanta, &visited)
    }

    private func countVisits(_ directions: String, _ visited: inout [Point: Bool]) -> Int {
        var x = 0
        var y = 0

        visited[Point(x, y)] = true

        for dir in directions {
            switch dir {
            case "^": y -= 1
            case "<": x -= 1
            case ">": x += 1
            case "v": y += 1
            default: fatalError()
            }

            visited[Point(x, y)] = true
        }

        return visited.count
    }
}
