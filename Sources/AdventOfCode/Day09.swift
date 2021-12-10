// Solution for part 1: X
// Solution for part 2: Y

struct Day09 {
    let day = "09"
    let testData = [
        "London to Dublin = 464",
        "London to Belfast = 518",
        "Dublin to Belfast = 141"
    ]

    struct City: Hashable {
        static var distances = [String: Int]()

        let name: String

        func distance(to city: City) -> Int {
            return Self.distances["\(self.name):\(city.name)"]!
        }
    }

    class Route {
        let cities: [City]

        var _distance: Int?
        var distance: Int {
            if _distance == nil {
                _distance = calculateDistance()
            }
            return _distance ?? 0
        }

        init(cities: [City]) {
            self.cities = cities
        }

        private func calculateDistance() -> Int {
            var result = 0
            var previousCity: City?

            cities.forEach { city in
                if let previous = previousCity {
                    result += previous.distance(to: city)
                }
                previousCity = city
            }

            return result
        }
    }

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let (distances, cities) = Timer.time(day) { () -> ([String: Int], [City]) in
            var dist = [String: Int]()
            var cities = Set<City>()
            for line in data {
                let c = line.split(separator: " ")
                let city1 = String(c[0])
                let city2 = String(c[2])
                let distance = Int(c[4])
                dist["\(city1):\(city2)"] = distance
                dist["\(city2):\(city1)"] = distance
                cities.insert(City(name: city1))
                cities.insert(City(name: city2))
            }
            return (dist, Array(cities))
        }
        City.distances = distances

        let (min, max) = part1And2(cities)
        print("Solution for part 1: \(min)")
        print("Solution for part 2: \(max)")
    }

    private func part1And2(_ cities: [City]) -> (Int, Int) {
        let timer = Timer(day); defer { timer.show() }

        var minDistance = Int.max
        var maxDistance = 0
        cities.permutations { cities in
            let route = Route(cities: cities)
            minDistance = min(minDistance, route.distance)
            maxDistance = max(maxDistance, route.distance)
        }

        return (minDistance, maxDistance)
    }
}

extension Array {
    // https://en.wikipedia.org/wiki/Heap%27s_algorithm

    func permutations(closure: ([Element]) -> Void) {
        var data = self
        generate(n: data.count, data: &data, closure: closure)
    }

    private func generate(n: Int, data: inout [Element], closure: ([Element]) -> Void) {
        if n == 1 {
            closure(data)
        } else {
            for i in 0 ..< n {
                generate(n: n - 1, data: &data, closure: closure)
                if n % 2 == 0 {
                    data.swapAt(i, n - 1)
                } else {
                    data.swapAt(0, n - 1)
                }
            }
        }
    }

}
