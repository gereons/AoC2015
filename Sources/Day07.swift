//
// Advent of Code 2015 Day 7
//

import Darwin
import AoCTools

struct Day07: AdventOfCodeDay {
    let title = "Some Assembly Required"

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
            let tokens = str.components(separatedBy: " ")
            let target = tokens.last!
            if let value = UInt16(tokens[0]), tokens[1] == "->" {
                self = .set(value: value, target: target)
            } else if tokens[0] == "NOT" {
                self = .not(src: tokens[1], target: target)
            } else if tokens[1] == "AND" {
                if let value = UInt16(tokens[0]) {
                    self = .and_const(value: value, rhs: tokens[2], target: target)
                } else {
                    self = .and(lhs: tokens[0], rhs: tokens[2], target: target)
                }
            } else if tokens[1] == "OR" {
               self = .or(lhs: tokens[0], rhs: tokens[2], target: target)
            } else if tokens[1] == "LSHIFT" {
                self = .lshift(lhs: tokens[0], shift: UInt16(tokens[2])!, target: target)
            } else if tokens[1] == "RSHIFT" {
                self = .rshift(lhs: tokens[0], shift: UInt16(tokens[2])!, target: target)
            } else if tokens[1] == "->" {
                self = .copy(src: tokens[0], target: target)
            } else {
                fatalError()
            }
        }

        var target: String {
            switch self {
            case .set(_, let target): target
            case .copy(_, let target): target
            case .and(_, _, let target): target
            case .and_const(_, _, let target): target
            case .or(_, _, let target): target
            case .lshift(_, _, let target): target
            case .rshift(_, _, let target): target
            case .not(_, let target): target
            }
        }

        var inputs: [String] {
            switch self {
            case .set: []
            case .copy(let src, _): [src]
            case .and(let lhs, let rhs, _): [lhs, rhs]
            case .and_const(_, let rhs, _): [rhs]
            case .or(let lhs, let rhs, _): [lhs, rhs]
            case .lshift(let lhs, _, _): [lhs]
            case .rshift(let lhs, _, _): [lhs]
            case .not(let src, _): [src]
            }
        }

        var description: String {
            switch self {
            case .set(value: let value, target: let target):
                "\(value) -> \(target)"
            case .copy(src: let src, target: let target):
                "\(src) -> \(target)"
            case .and(lhs: let lhs, rhs: let rhs, target: let target):
                "\(lhs) AND \(rhs) -> \(target)"
            case .and_const(value: let value, rhs: let rhs, target: let target):
                "\(value) AND \(rhs) -> \(target)"
            case .or(lhs: let lhs, rhs: let rhs, target: let target):
                "\(lhs) OR \(rhs) -> \(target)"
            case .lshift(lhs: let lhs, shift: let shift, target: let target):
                "\(lhs) LSHIFT \(shift) -> \(target)"
            case .rshift(lhs: let lhs, shift: let shift, target: let target):
                "\(lhs) RSHIFT \(shift) -> \(target)"
            case .not(src: let src, target: let target):
                "NOT \(src) -> \(target)"
            }
        }
    }

    let operations: [String: Operation]

    init(input: String) {
        operations = input.lines
            .map { Operation($0) }
            .mapped(by: \.target)
    }

    func part1() async -> UInt16 {
        var memory = [String: UInt16]()

        let assignA = operations["a"]!
        return evaluate(op: assignA, operations, &memory)
    }

    func part2() async -> UInt16 {
        var memory = [String: UInt16]()
        memory["b"] = await part1()

        let assignA = operations["a"]!
        let wireA = evaluate(op: assignA, operations, &memory)

        return wireA
    }

    @discardableResult
    func evaluate(op: Operation, _ ops: [String: Operation], _ memory: inout [String: UInt16]) -> UInt16 {
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
