import Foundation

// where do the Day input files live relative to $HOME
let fixturePath = "Developer/AdventOfCode/AoC2015/Fixtures"

//Day01().run()
Day02().run()
//Day03().run()
//Day04().run()
//Day05().run()
//Day06().run()
//Day07().run()
//Day08().run()
//Day09().run()
//Day10().run()
//Day11().run()
//Day12().run()
//Day13().run()
//Day14().run()
//Day15().run()
//Day16().run()
//Day17().run()
//Day18().run()
//Day19().run()
//Day20().run()
//Day21().run()
//Day22().run()
//Day23().run()
//Day24().run()
//Day25().run()
Timer.showTotal()

protocol Day {
    func run()
    var day: String { get }
}

public func readFile(named name: String) -> [String] {
    // relative url, works when running with "swift run"
    var url = URL(fileURLWithPath: "Fixtures/\(name)")
    do {
        _ = try url.checkResourceIsReachable()
    } catch {
        // absolute url, used when running from Xcode
        if let home = ProcessInfo().environment["HOME"] {
            url = URL(fileURLWithPath: "\(home)/\(fixturePath)/\(name)")
        }
    }
    if let data = try? Data(contentsOf: url), let str = String(bytes: data, encoding: .utf8) {
        var arr = str.split(separator: "\n", omittingEmptySubsequences: false)
        if arr.last?.isEmpty == true {
            arr.removeLast()
        }
        return arr.map { String($0) }
    }
    print("OOPS: can't read \(url.absoluteURL)")
    return []
}

class Timer {
    private let start = Date().timeIntervalSinceReferenceDate
    private let name: String

    private static var total: TimeInterval = 0

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
        print("\(name) took \(elapsed)s")
    }

    static func showTotal() {
        print("Total time: \(Self.total)s")
    }
}