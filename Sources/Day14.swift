//
// Advent of Code 2015 Day 14
//

import AoCTools
import Foundation

struct Day14: AdventOfCodeDay {
    let title = "Reindeer Olympics"

    let reindeers: [Reindeer]

    struct Reindeer {
        let name: String
        let speed: Double
        let flyTime: Double
        let restTime: Double

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            name = String(tokens[0])
            speed = Double(tokens[3])!
            flyTime = Double(tokens[6])!
            restTime = Double(tokens[13])!
        }

        func distanceMoved(atTime time: Int) -> Int {
            let travelTime = Double(time)
            let cycleTime = flyTime + restTime

            let cycles = travelTime / cycleTime

            let fullCycles = floor(cycles)
            let remainder = travelTime - (fullCycles * cycleTime)

            var extraDistance: Double = 0
            if remainder > flyTime {
                extraDistance = flyTime * speed
            } else {
                extraDistance = (travelTime - (fullCycles * cycleTime)) * speed
            }

            return Int(fullCycles * flyTime * speed + extraDistance)
        }
    }

    init(input: String) {
        self.reindeers = input.lines.map { Reindeer($0) }
    }

    func part1() async -> Int {
        var maxDistance = 0
        reindeers.forEach { reindeer in
            let distance = reindeer.distanceMoved(atTime: 2503)
            maxDistance = max(maxDistance, distance)
        }

        return maxDistance
    }

    func part2() async -> Int {
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
