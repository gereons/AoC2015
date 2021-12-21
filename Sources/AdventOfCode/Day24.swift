// Solution for part 1: X
// Solution for part 2: Y

struct Day24 {
    let day = "24"
    let testData = [ "1","2","3","4","5", "7","8","9","10","11" ]

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let weights = Timer.time(day) {
            data.compactMap { Int($0) }
        }

        print("Solution for part 1: \(part1(weights))")
        print("Solution for part 2: \(part2(weights))")
    }

    private func part1(_ weights: [Int]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let sum = weights.reduce(0, +) / 3
        var sets = [[Int]]()
        findSubsets(weights, sum: sum, [], &sets)

        sets.sort { set1, set2 -> Bool in
            if set1.count == set2.count {
                let qe1 = set1.reduce(1, mul)
                let qe2 = set2.reduce(1, mul)

                return qe1 < qe2
            }
            return set1.count < set2.count
        }

        return sets[0].reduce(1, *)
    }

    private func mul(_ i1: Int, i2: Int) -> Int {
        let (r, ov) = i1.multipliedReportingOverflow(by: i2)
        return ov ? Int.max : r
    }

    private func part2(_ weights: [Int]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let sum = weights.reduce(0, +) / 4
        var sets = [[Int]]()
        findSubsets(weights, sum: sum, [], &sets)

        sets.sort { set1, set2 -> Bool in
            if set1.count == set2.count {
                let qe1 = set1.reduce(1, mul)
                let qe2 = set2.reduce(1, mul)

                return qe1 < qe2
            }
            return set1.count < set2.count
        }

        return sets[0].reduce(1, *)
    }

    private func findSubsets(_ weights: [Int], sum: Int, _ working: [Int], _ results: inout [[Int]]) {
        for i in 0 ..< weights.count {
            let w = weights[i]
            let workingSum = working.reduce(0,+)
            if workingSum + w <= sum {
                var working = working
                working.append(w)
                findSubsets(Array(weights.dropFirst(i+1)), sum: sum, working, &results)
            }
            else if workingSum > sum {
                break
            }
        }

        if working.reduce(0, +) == sum {
            // print(working)
            results.append(working)
        }
    }

}
