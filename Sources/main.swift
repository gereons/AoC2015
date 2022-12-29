import Foundation

Day01().run()
Day02().run()
Day03().run()
Day04().run()
Day05().run()
Day06().run()
Day07().run()
Day08().run()
Day09().run()
Day10().run()
Day11().run()
Day12().run()
Day13().run()
Day14().run()
Day15().run()
Day16().run()
Day17().run()
Day18().run()
Day19().run()
Day20().run()
Day21().run()
Day22().run()
Day23().run()
Day24().run()
Day25().run()
Timer.showTotal()

protocol Day {
    func run()
    var day: String { get }
    static var rawInput: String { get }
}

extension Day {
    static var rawInput: String { "" }
}

class Timer {
    private let start = Date().timeIntervalSinceReferenceDate
    private let name: String

    private static var total: TimeInterval = 0
    private static let formatter: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.maximumFractionDigits = 3
        fmt.locale = Locale(identifier: "en_US")
        return fmt
    }()

    init(_ day: String, fun: String = #function) {
        self.name = "Day \(day) \(fun)"
    }

    static func time<Result>(_ day: String, name: String = "parse", closure: () -> Result) -> Result {
        let timer = Timer(day, fun: name)
        defer { timer.show() }
        return closure()
    }

    func show() {
        let elapsed = Date().timeIntervalSinceReferenceDate - start
        Self.total += elapsed
        print("\(name) took \(Self.formatted(elapsed))")
    }

    static func showTotal() {
        print("Total time: \(formatted(Self.total))")
    }

    static private func formatted(_ interval: TimeInterval) -> String {
        return "\(formatter.string(for: interval * 1000)!)ms"
    }
}
