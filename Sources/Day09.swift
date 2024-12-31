//
// Advent of Code 2015 Day 9
//

import AoCTools

struct Day09: AdventOfCodeDay {
    let title = "All in a Single Night"

    struct Route {
        let cities: [String]
        let distances: [String: Int]

        func distance() -> Int {
            var result = 0
            var previousCity: String?

            cities.forEach { city in
                if let previous = previousCity {
                    result += distances["\(previous):\(city)"]!
                }
                previousCity = city
            }

            return result
        }
    }

    let distances: [String: Int]
    let cities: [String]

    init(input: String) {
        var distances = [String: Int]()
        var cities = Set<String>()
        for line in input.lines {
            let parts = line.components(separatedBy: " ")
            let city1 = parts[0]
            let city2 = parts[2]
            let distance = Int(parts[4])
            distances["\(city1):\(city2)"] = distance
            distances["\(city2):\(city1)"] = distance
            cities.insert(city1)
            cities.insert(city2)
        }

        self.distances = distances
        self.cities = Array(cities)
    }

    func part1() async -> Int {
        let (minDistance, _) = minMaxDistances(cities)
        return minDistance
    }

    func part2() async -> Int {
        let (_, maxDistance) = minMaxDistances(cities)
        return maxDistance
    }

    private func minMaxDistances(_ cities: [String]) -> (Int, Int) {
        var minDistance = Int.max
        var maxDistance = 0
        for cities in cities.permutations(ofCount: cities.count) {
            let route = Route(cities: cities, distances: distances)
            let distance = route.distance()
            minDistance = min(minDistance, distance)
            maxDistance = max(maxDistance, distance)
        }

        return (minDistance, maxDistance)
    }
}
