// Solution for part 1: X
// Solution for part 2: Y

private struct Parcel {
    let l, w, h: Int

    init(_ str: String) {
        let c = str.split(separator: "x")
        l = Int(String(c[0]))!
        w = Int(String(c[1]))!
        h = Int(String(c[2]))!
    }
}

struct Day02 {
    let day = "02"
    let testData = [ "2x3x4", "1x1x10" ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let parcels = Timer.time(day) {
            data.map { Parcel($0) }
        }

        print("Solution for part 1: \(part1(parcels))")
        print("Solution for part 2: \(part2(parcels))")
    }

    private func part1(_ parcels: [Parcel]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        return parcels.reduce(0) { sum, parcel in
            sum + paperNeededFor(parcel)
        }
    }

    private func part2(_ parcels: [Parcel]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        return parcels.reduce(0) { sum, parcel in
            sum + ribbonNeededFor(parcel)
        }
    }

    private func paperNeededFor(_ parcel: Parcel) -> Int {
        let lw = parcel.l * parcel.w
        let wh = parcel.w * parcel.h
        let hl = parcel.h * parcel.l
        let smallest = min(lw, min(wh, hl))
        return 2 * lw + 2 * wh + 2 * hl + smallest
    }

    private func ribbonNeededFor(_ parcel: Parcel) -> Int {
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
