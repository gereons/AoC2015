//
// Advent of Code 2015 Day 6
//

import AoCTools

private enum Instruction {
    case turnOn
    case turnOff
    case toggle
}

private struct Command {
    let op: Instruction
    let start: Point
    let end: Point

    init(_ line: String) {
        let components = line.components(separatedBy: " ")
        var offset = 2
        if components[0] == "toggle" {
            offset = 1
        }

        let startXY = components[offset].integers()
        let start = Point(startXY[0], startXY[1])

        let endXY = components[offset + 2].integers()
        let end = Point(endXY[0], endXY[1])
        if components[0] == "toggle" {
            op = .toggle
            self.start = start
            self.end = end
        } else if components[1] == "on" {
            op = .turnOn
            self.start = start
            self.end = end
        } else {
            op = .turnOff
            self.start = start
            self.end = end
        }
    }
}

struct Day06: AdventOfCodeDay {
    let title = "Probably a Fire Hazard"

    let testData = [
        "turn on 0,0 through 999,999",
        "toggle 0,0 through 999,0",
        "turn off 499,499 through 500,500"
    ]
    private let commands: [Command]

    init(input: String) {
        commands = input.lines.compactMap { Command($0) }
    }

    func part1() async -> Int {
        let line = [Bool](repeating: false, count: 1000)
        var board = [[Bool]](repeating: line, count: 1000)

        for command in commands {
            switchLights(command, &board)
        }
        return board
            .flatMap { $0 }
            .count { $0 }
    }

    private func switchLights(_ cmd: Command, _ board: inout [[Bool]]) {
        for x in cmd.start.x ... cmd.end.x {
            for y in cmd.start.y ... cmd.end.y {
                switch cmd.op {
                case .toggle: board[x][y].toggle()
                case .turnOn: board[x][y] = true
                case .turnOff: board[x][y] = false
                }
            }
        }
    }

    func part2() async -> Int {
        let line = [Int](repeating: 0, count: 1000)
        var board = [[Int]](repeating: line, count: 1000)

        for command in commands {
            controlLights(command, &board)
        }
        return board
            .flatMap { $0 }
            .reduce(0, +)
    }

    private func controlLights(_ cmd: Command, _ board: inout [[Int]]) {
        for x in cmd.start.x ... cmd.end.x {
            for y in cmd.start.y ... cmd.end.y {
                switch cmd.op {
                case .toggle: board[x][y] += 2
                case .turnOn: board[x][y] += 1
                case .turnOff: board[x][y] = max(0, board[x][y] - 1)
                }
            }
        }
    }
}
