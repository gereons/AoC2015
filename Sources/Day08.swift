// Solution for part 1: X
// Solution for part 2: Y

struct Day08 {
    let day = "08"
    let testData = [
        #""""#,
        #""abc""#,
        #""aaa\"aaa""#,
        #""\x27""#
    ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        print("Solution for part 1: \(part1(data))")
        print("Solution for part 2: \(part2(data))")
    }

    private func part1(_ data: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        var chars = 0
        var inMemory = 0
        for line in data {
            chars += line.count

            var memChars = 0
            var index = line.index(line.startIndex, offsetBy: 1)
            var nextIndex = line.index(after: index)
            while nextIndex != line.endIndex {
                memChars += 1
                let nextCh = line[nextIndex]
                if line[index] == "\\" {
                    var skip = 0
                    if nextCh == "\\" || nextCh == "\"" { skip = 1 }
                    if nextCh == "x" { skip = 3 }
                    nextIndex = line.index(nextIndex, offsetBy: skip)
                }

                index = nextIndex
                nextIndex = line.index(after: nextIndex)
            }

            inMemory += memChars

            // print(line, line.count, memChars)
        }
        return chars - inMemory
    }

    private func part2(_ data: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        var chars = 0
        var encoded = 0
        for line in data {
            chars += line.count
            var enc = line.count + 2

            for ch in line {
                if ch == "\"" || ch == "\\" {
                    enc += 1
                }
            }
            encoded += enc
            // print(line, line.count, enc)
        }

        return encoded - chars
    }
}
