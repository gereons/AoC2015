//
// Advent of Code 2015 Day 2
//

import AoCTools

private struct Parcel {
    let l, w, h: Int

    init(_ str: String) {
        let c = str.split(separator: "x")
        l = Int(String(c[0]))!
        w = Int(String(c[1]))!
        h = Int(String(c[2]))!
    }
}

struct Day02: AdventOfCodeDay {
    let title = "I Was Told There Would Be No Math"

    private let parcels: [Parcel]

    init(input: String) {
        parcels = input.lines.map { Parcel($0) }
    }

    func part1() async -> Int {
        parcels.reduce(0) { sum, parcel in
            sum + paperNeeded(for: parcel)
        }
    }

    func part2() async -> Int {
        parcels.reduce(0) { sum, parcel in
            sum + ribbonNeeded(for: parcel)
        }
    }

    private func paperNeeded(for parcel: Parcel) -> Int {
        let lw = parcel.l * parcel.w
        let wh = parcel.w * parcel.h
        let hl = parcel.h * parcel.l
        let smallest = min(lw, min(wh, hl))
        return 2 * lw + 2 * wh + 2 * hl + smallest
    }

    private func ribbonNeeded(for parcel: Parcel) -> Int {
        var sides = [Int: (Int, Int)]()
        let lw = parcel.l * parcel.w
        let wh = parcel.w * parcel.h
        let hl = parcel.h * parcel.l
        sides[lw] = (parcel.l, parcel.w)
        sides[wh] = (parcel.w, parcel.h)
        sides[hl] = (parcel.h, parcel.l)
        let smallest = sides.keys.sorted(by: <).first!
        let side = sides[smallest]!
        let ribbon = side.0 + side.1
        let bow = parcel.l * parcel.w * parcel.h
        return ribbon * 2 + bow
    }
}
