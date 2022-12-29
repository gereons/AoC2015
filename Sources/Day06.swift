// Solution for part 1: X
// Solution for part 2: Y

private enum Op {
    case turnOn
    case turnOff
    case toggle
}

private struct Command {
    let op: Op
    let start: Point
    let end: Point

    init(_ line: String) {
        let components = line.split(separator: " ")
        var offset = 2
        if components[0] == "toggle" {
            offset = 1
        }

        let start = Point(components[offset])
        let end = Point(components[offset + 2])
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

private struct Point {
    let x,y: Int

    init(_ str: String.SubSequence) {
        let xy = str.split(separator: ",")
        x = Int(xy[0])!
        y = Int(xy[1])!
    }
}

struct Day06 {
    let day = "06"
    let testData = [
        "turn on 0,0 through 999,999",
        "toggle 0,0 through 999,0",
        "turn off 499,499 through 500,500"
    ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let commands = Timer.time(day) {
            data.compactMap { Command($0) }
        }

        print("Solution for part 1: \(part1(commands))")
        print("Solution for part 2: \(part2(commands))")
    }

    private func part1(_ commands: [Command]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let line = [Bool](repeating: false, count: 1000)
        var board = [[Bool]](repeating: line, count: 1000)

        for command in commands {
            switchLights(command, &board)
        }
        return board.flatMap { $0 }.filter { $0 }.count
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

    private func part2(_ commands: [Command]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let line = [Int](repeating: 0, count: 1000)
        var board = [[Int]](repeating: line, count: 1000)

        for command in commands {
            controlLights(command, &board)
        }
        return board.flatMap { $0 }.reduce(0, +)
    }

    private func controlLights(_ cmd: Command, _ board: inout [[Int]]) {
        for x in cmd.start.x ... cmd.end.x {
            for y in cmd.start.y ... cmd.end.y {
                switch cmd.op {
                case .toggle: board[x][y] += 2
                case .turnOn: board[x][y] += 1
                case .turnOff: board[x][y] = max(0, board[x][y]-1)
                }
            }
        }
    }
}
