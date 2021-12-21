// Solution for part 1: X
// Solution for part 2: Y

struct Day23 {
    let day = "23"
    let testData = [
        "inc a",
        "jio a, +2",
        "tpl a",
        "inc a"
    ]

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

    class CPU {
        var registers = [ "a": 0, "b": 0 ]
        var pc = 0

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

    func run() {
        // let data = testData
        let data = readFile(named: "Day\(day)_input.txt")

        let program = Timer.time(day) {
            data.map { line in
                Instruction(line)
            }
        }

        print("Solution for part 1: \(part1(program))")
        print("Solution for part 2: \(part2(program))")
    }

    private func part1(_ program: [Instruction]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let cpu = CPU()
        cpu.run(program)
        return cpu.registers["b"]!
    }

    private func part2(_ program: [Instruction]) -> Int {
        let timer = Timer(day); defer { timer.show() }
        let cpu = CPU()
        cpu.registers["a"] = 1
        cpu.run(program)
        return cpu.registers["b"]!
    }
}
