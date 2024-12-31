//
// Advent of Code 2015 Day 23
//

import AoCTools
struct Day23: AdventOfCodeDay {
    let title = "Opening the Turing Lock"

    struct Instruction {
        let opcode: String
        let register: String?
        let offset: Int?

        init(_ string: String) {
            let tokens = string.split(separator: " ")
            opcode = String(tokens[0])
            switch opcode {
            case "hlf", "tpl", "inc":
                register = String(tokens[1])
                offset = nil
            case "jmp":
                register = nil
                offset = Int(tokens[1])
            case "jie", "jio":
                register = String(tokens[1].dropLast())
                offset = Int(tokens[2])
            default:
                fatalError()
            }
        }
    }

    final class CPU {
        var registers = [ "a": 0, "b": 0 ]
        private var pc = 0

        func run(_ program: [Instruction]) {
            while pc >= 0 && pc < program.count {
                execute(program[pc])
            }
        }

        private func execute(_ instruction: Instruction) {
            switch instruction.opcode {
            case "hlf":
                registers[instruction.register!]! /= 2
                pc += 1
            case "tpl":
                registers[instruction.register!]! *= 3
                pc += 1
            case "inc":
                registers[instruction.register!]! += 1
                pc += 1
            case "jmp":
                pc += instruction.offset!
            case "jie":
                if registers[instruction.register!]!.isMultiple(of: 2) {
                    pc += instruction.offset!
                } else {
                    pc += 1
                }
            case "jio":
                if registers[instruction.register!]! == 1 {
                    pc += instruction.offset!
                } else {
                    pc += 1
                }
            default:
                fatalError()
            }
        }
    }

    let program: [Instruction]

    init(input: String) {
        program = input.lines.map { Instruction($0) }
    }

    func part1() async -> Int {
        let cpu = CPU()
        cpu.run(program)
        return cpu.registers["b"]!
    }

    func part2() async -> Int {
        let cpu = CPU()
        cpu.registers["a"] = 1
        cpu.run(program)
        return cpu.registers["b"]!
    }
}
