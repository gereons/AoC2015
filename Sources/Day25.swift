// Solution for part 1: X
// Solution for part 2: Y

struct Day25 {
    let day = "25"
    let testData = [ "1","2","3" ]

    func run() {
        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var number = 20151125
        let row = 2978
        let column = 3083
        let maxX = 2 * column + 10
        let maxY = 2 * column + 10
        let line = [Int](repeating: 0, count: maxX+1)
        var grid = [[Int]](repeating: line, count: maxY+1)
        for i in 0 ..< (maxX*maxY) {
            var r = i
            var c = 0

            repeat {
                if r + 1 == row && c + 1 == column {
                    return number
                }
                grid[r][c] = number
                number = nextNumber(after: number)

                r -= 1
                c += 1
            } while r >= 0
        }

        for line in grid {
            for n in line {
                print(n, terminator: " ")
            }
            print()
        }

        fatalError()
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }
        return 42
    }

    private func nextNumber(after n: Int) -> Int {
//        return n + 1
        let m = n * 252533
        let (_, r) = m.quotientAndRemainder(dividingBy: 33554393)
        return r
    }
}
