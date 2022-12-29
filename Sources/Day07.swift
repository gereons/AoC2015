// Solution for part 1: X
// Solution for part 2: Y

import Darwin

struct Day07 {
    enum Operation {
        case set(value: UInt16, target: String)
        case copy(src: String, target: String)
        case and(lhs: String, rhs: String, target: String)
        case and_const(value: UInt16, rhs: String, target: String)
        case or(lhs: String, rhs: String, target: String)
        case lshift(lhs: String, shift: UInt16, target: String)
        case rshift(lhs: String, shift: UInt16, target: String)
        case not(src: String, target: String)

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            let target = String(tokens.last!)
            if let value = UInt16(tokens[0]), tokens[1] == "->" {
                self = .set(value: value, target: target)
            } else if tokens[0] == "NOT" {
                self = .not(src: String(tokens[1]), target: target)
            } else if tokens[1] == "AND" {
                if let value = UInt16(tokens[0]) {
                    self = .and_const(value: value, rhs: String(tokens[2]), target: target)
                } else {
                    self = .and(lhs: String(tokens[0]), rhs: String(tokens[2]), target: target)
                }
            } else if tokens[1] == "OR" {
               self = .or(lhs: String(tokens[0]), rhs: String(tokens[2]), target: target)
            } else if tokens[1] == "LSHIFT" {
                self = .lshift(lhs: String(tokens[0]), shift: UInt16(tokens[2])!, target: target)
            } else if tokens[1] == "RSHIFT" {
                self = .rshift(lhs: String(tokens[0]), shift: UInt16(tokens[2])!, target: target)
            } else if tokens[1] == "->" {
                self = .copy(src: String(tokens[0]), target: target)
            } else {
                fatalError()
            }
        }

        var target: String {
            switch self {
            case .set(_, let target):
                return target
            case .copy(_, let target):
                return target
            case .and(_, _, let target):
                return target
            case .and_const(_, _, let target):
                return target
            case .or(_, _, let target):
                return target
            case .lshift(_, _, let target):
                return target
            case .rshift(_, _, let target):
                return target
            case .not(_, let target):
                return target
            }
        }

        var inputs: [String] {
            switch self {
            case .set:
                return []
            case .copy(let src, _):
                return [src]
            case .and(let lhs, let rhs, _):
                return [lhs, rhs]
            case .and_const(_, let rhs, _):
                return [rhs]
            case .or(let lhs, let rhs, _):
                return [lhs, rhs]
            case .lshift(let lhs, _, _):
                return [lhs]
            case .rshift(let lhs, _, _):
                return [lhs]
            case .not(let src, _):
                return [src]
            }
        }

        var description: String {
            switch self {
            case .set(value: let value, target: let target):
                return "\(value) -> \(target)"
            case .copy(src: let src, target: let target):
                return "\(src) -> \(target)"
            case .and(lhs: let lhs, rhs: let rhs, target: let target):
                return "\(lhs) AND \(rhs) -> \(target)"
            case .and_const(value: let value, rhs: let rhs, target: let target):
                return "\(value) AND \(rhs) -> \(target)"
            case .or(lhs: let lhs, rhs: let rhs, target: let target):
                return "\(lhs) OR \(rhs) -> \(target)"
            case .lshift(lhs: let lhs, shift: let shift, target: let target):
                return "\(lhs) LSHIFT \(shift) -> \(target)"
            case .rshift(lhs: let lhs, shift: let shift, target: let target):
                return "\(lhs) RSHIFT \(shift) -> \(target)"
            case .not(src: let src, target: let target):
                return "NOT \(src) -> \(target)"
            }
        }
    }

    let day = "07"
    let testData = [
        "123 -> x",
        "456 -> y",
        "x AND y -> d",
        "x OR y -> e",
        "x LSHIFT 2 -> f",
        "y RSHIFT 2 -> g",
        "NOT x -> h",
        "NOT y -> i"
    ]

    func run() {
        // let data = testData
        let data = Self.rawInput.components(separatedBy: "\n")

        let operations = Timer.time(day) { () -> [String: Operation] in
            var dict = [String: Operation]()
            data.map { Operation($0) }.forEach {
                dict[$0.target] = $0
            }
            return dict
        }

        let wireA = part1(operations)
        print("Solution for part 1: \(wireA)")
        print("Solution for part 2: \(part2(wireA, operations))")
    }

    private func part1(_ operations: [String: Operation]) -> UInt16 {
        let timer = Timer(day); defer { timer.show() }
        var memory = [String: UInt16]()

        let assignA = operations["a"]!
        let wireA = evaluate(op: assignA, operations, &memory)

        return wireA
    }

    private func part2(_ wireA: UInt16, _ operations: [String: Operation]) -> UInt16 {
        let timer = Timer(day); defer { timer.show() }
        var memory = [String: UInt16]()
        memory["b"] = wireA

        let assignA = operations["a"]!
        let wireA = evaluate(op: assignA, operations, &memory)

        return wireA
    }

    @discardableResult
    private func evaluate(op: Operation, _ ops: [String: Operation], _ memory: inout [String: UInt16]) -> UInt16 {
        // print("evaluate \(op.description)")
        let inputs = op.inputs
        switch inputs.count {
        case 0:
            return apply(op, to: &memory)
        case 1:
            if memory[inputs[0]] == nil {
                let nextOp = ops[inputs[0]]!
                evaluate(op: nextOp, ops, &memory)
            }
            return apply(op, to: &memory)
        case 2:
            if memory[inputs[0]] == nil {
                let nextOp = ops[inputs[0]]!
                evaluate(op: nextOp, ops, &memory)
            }
            if memory[inputs[1]] == nil {
                let nextOp = ops[inputs[1]]!
                evaluate(op: nextOp, ops, &memory)
            }
            return apply(op, to: &memory)
        default:
            fatalError()
        }
    }

    private func apply(_ op: Operation, to memory: inout [String: UInt16]) -> UInt16 {
        switch op {
        case .set(let value, let target):
            memory[target] = value
        case .copy(let src, let target):
            memory[target] = memory[src]!
        case .and(let lhs, let rhs, let target):
            memory[target] = memory[lhs]! & memory[rhs]!
        case .and_const(let value, let rhs, let target):
            memory[target] = value & memory[rhs]!
        case .or(let lhs, let rhs, let target):
            memory[target] = memory[lhs]! | memory[rhs]!
        case .lshift(let lhs, let shift, let target):
            memory[target] = memory[lhs]! << shift
        case .rshift(let lhs, let shift, let target):
            memory[target] = memory[lhs]! >> shift
        case .not(let src, let target):
            memory[target] = ~memory[src]!
        }
        // print("apply \(op.description)")
        return memory[op.target]!
    }
}
