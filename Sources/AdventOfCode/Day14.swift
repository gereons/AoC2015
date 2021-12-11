// Solution for part 1: X
// Solution for part 2: Y

import Foundation

struct Day14 {
    let day = "14"
    let testData = [
        "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
        "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.",
    ]

    struct Reindeer {
        let name: String
        let speed: Float
        let flyTime: Float
        let restTime: Float

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            name = String(tokens[0])
            speed = Float(tokens[3])!
            flyTime = Float(tokens[6])!
            restTime = Float(tokens[13])!
        }

        func distanceMoved(atTime time: Int) -> Int {
            let travelTime = Float(time)
            let cycleTime = flyTime + restTime

            let cycles = travelTime / cycleTime

            let fullCycles = floor(cycles)
            let remainder = travelTime - (fullCycles * cycleTime)

            var extraDistance: Float = 0
            if remainder > flyTime {
                extraDistance = flyTime * speed
            } else {
                extraDistance = (travelTime - (fullCycles * cycleTime)) * speed
            }

            return Int(fullCycles * flyTime * speed + extraDistance)
        }
    }

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let reindeer = Timer.time(day) {
            data.map { Reindeer($0) }
        }

        print("Solution for part 1: \(part1(reindeer))")
        print("Solution for part 2: \(part2(reindeer))")
    }

    private func part1(_ reindeers: [Reindeer]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        var maxDistance = 0
        reindeers.forEach { reindeer in
            let distance = reindeer.distanceMoved(atTime: 2503)
            maxDistance = max(maxDistance, distance)
        }

        return maxDistance
    }

    private func part2(_ reindeers: [Reindeer]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        var scores = [String: Int]()
        var maxScore = 0
        for time in 1...2503 {
            var maxDistance = 0
            var winner = ""
            reindeers.forEach { reindeer in
                let distance = reindeer.distanceMoved(atTime: time)
                if distance > maxDistance {
                    maxDistance = distance
                    winner = reindeer.name
                }
            }
            scores[winner, default: 0] += 1
            maxScore = max(maxScore, scores[winner]!)
        }

        return maxScore
    }
}
