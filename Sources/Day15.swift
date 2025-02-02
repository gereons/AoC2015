//
// Advent of Code 2015 Day 15
//

import AoCTools

struct Day15: AdventOfCodeDay {
    let title = "Science for Hungry People"

    struct Ingredient: Hashable {
        let name: String
        let capacity: Int
        let durability: Int
        let flavor: Int
        let texture: Int
        let calories: Int

        init(_ line: String) {
            let tokens = line.split(separator: " ")
            name = String(tokens[0].dropLast())
            capacity = Int(tokens[2].dropLast())!
            durability = Int(tokens[4].dropLast())!
            flavor = Int(tokens[6].dropLast())!
            texture = Int(tokens[8].dropLast())!
            calories = Int(tokens[10])!
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }

        static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
            return lhs.name == rhs.name
        }
    }

    let ingredients: [Ingredient]

    init(input: String) {
        ingredients = input.lines.map { Ingredient($0) }
    }

    func part1() async -> Int {
        let (maxScore, _) = part1And2()
        return maxScore
    }

    func part2() async -> Int {
        let (_, maxCaloriesScore) = part1And2()
        return maxCaloriesScore
    }

    private func part1And2() -> (Int, Int) {
        var maxScore = 0
        var maxCaloriesScore = 0

        tryIngredients([:],
            remainingQuantity: 100,
            remainingIngredients: ingredients,
            &maxScore,
            targetCalories: 500,
            &maxCaloriesScore
        )
        return (maxScore, maxCaloriesScore)
    }

    // swiftlint:disable:next function_parameter_count
    private func tryIngredients(
        _ quantities: [Ingredient: Int],
        remainingQuantity: Int,
        remainingIngredients: [Ingredient],
        _ maxScore: inout Int,
        targetCalories: Int,
        _ maxCaloriesScore: inout Int
    ) {
        if remainingIngredients.count == 1 {
            var newQuantities = quantities
            newQuantities[remainingIngredients[0]] = remainingQuantity
            let score = total(newQuantities)
            maxScore = max(maxScore, score)
            if calories(newQuantities) == targetCalories {
                maxCaloriesScore = max(maxCaloriesScore, score)
            }
        } else {
            for i in 1 ..< remainingQuantity {
                var newQuantities = quantities
                var stillRemainingIngredients = remainingIngredients
                let nextIngredient = stillRemainingIngredients.removeFirst()
                newQuantities[nextIngredient] = i
                tryIngredients(
                    newQuantities,
                    remainingQuantity: remainingQuantity - i,
                    remainingIngredients: stillRemainingIngredients,
                    &maxScore,
                    targetCalories: targetCalories,
                    &maxCaloriesScore
                )
            }
        }
        return
    }

    private func total(_ quantities: [Ingredient: Int]) -> Int {
        var capacity = 0
        var durability = 0
        var flavor = 0
        var texture = 0
        for (ingredient, qty) in quantities {
            capacity += qty * ingredient.capacity
            durability += qty * ingredient.durability
            flavor += qty * ingredient.flavor
            texture += qty * ingredient.texture
        }

        return max(0, capacity) * max(0, durability) * max(0, flavor) * max(0, texture)
    }

    private func calories(_ quantities: [Ingredient: Int]) -> Int {
        var cal = 0
        for (ingredient, qty) in quantities {
            cal += qty * ingredient.calories
        }
        return cal
    }
}
