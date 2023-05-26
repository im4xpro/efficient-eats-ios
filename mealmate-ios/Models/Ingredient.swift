
import Foundation

struct Ingredient: ConsumableItem {
    let id = UUID()
    var name: String
}

extension Ingredient {
    static let mockData = [
        Ingredient(name: "Flour"),
        Ingredient(name: "Salt"),
        Ingredient(name: "Pepper"),
        Ingredient(name: "Vinegar"),
        Ingredient(name: "Olive oil")
    ]
}
