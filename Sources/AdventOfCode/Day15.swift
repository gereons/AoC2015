// Solution for part 1: X
// Solution for part 2: Y

struct Day15 {
    let day = "15"
    let testData = [
        "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8",
        "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3"
    ]
    let realData = [
        "Frosting: capacity 4, durability -2, flavor 0, texture 0, calories 5",
        "Candy: capacity 0, durability 5, flavor -1, texture 0, calories 8",
        "Butterscotch: capacity -1, durability 0, flavor 5, texture 0, calories 6",
        "Sugar: capacity 0, durability 0, flavor -2, texture 2, calories 1"
    ]

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

        static func==(lhs: Ingredient, rhs: Ingredient) -> Bool {
            return lhs.name == rhs.name
        }
    }

    func run() {
        // let data = testData
        let data = realData

        let ingredients = Timer.time(day) {
            data.map { Ingredient($0) }
        }

        let (maxScore, maxCaloriesScore) = part1And2(ingredients)
        print("Solution for part 1: \(maxScore)")
        print("Solution for part 2: \(maxCaloriesScore)")
    }

    private func part1And2(_ ingredients: [Ingredient]) -> (Int, Int) {
        let timer = Timer(day); defer { timer.show() }
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

    func total(_ quantities: [Ingredient: Int]) -> Int {
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

    func calories(_ quantities: [Ingredient: Int]) -> Int {
        var cal = 0
        for (ingredient, qty) in quantities {
            cal += qty * ingredient.calories
        }
        return cal
    }
}
