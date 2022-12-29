// Solution for part 1: X
// Solution for part 2: Y

private struct Point: Hashable {
    let x,y : Int
}

struct Day03 {
    let day = "03"
    let testData = [ "^v^v^v^v^v" ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        // print("Solution for part 1: \(part1(data[0]))")
        print("Solution for part 2: \(part2(data[0]))")
    }

    private func part1(_ directions: String) -> Int {
        let timer = Timer(day); defer { timer.show() }
        var visited = [Point: Bool]()
        return countVisits(directions, &visited)
    }

    private func countVisits(_ directions: String, _ visited: inout [Point: Bool]) -> Int {
        var x = 0
        var y = 0

        visited[Point(x: x, y: y)] = true

        for dir in directions {
            switch dir {
            case "^": y -= 1
            case "<": x -= 1
            case ">": x += 1
            case "v": y += 1
            default: fatalError()
            }

            visited[Point(x: x, y: y)] = true
        }

        return visited.count
    }

    private func part2(_ directions: String) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let santa = directions.enumerated().filter { index, ch in
            index.isMultiple(of: 2)
        }.map { String($0.element) }.joined()
        let roboSanta = directions.enumerated().filter { index, ch in
            !index.isMultiple(of: 2)
        }.map { String($0.element) }.joined()

        var visited = [Point: Bool]()
        _ = countVisits(santa, &visited)
        return countVisits(roboSanta, &visited)
    }
}
