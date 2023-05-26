import Foundation

struct RecipeIngredient: Identifiable {
    let id = UUID()
    let amount: Double
    let unit: String
    var itemName: String
}

extension RecipeIngredient {
    static let mockData = [
        RecipeIngredient(amount: 2, unit: "g", itemName: "Flour"),
        RecipeIngredient(amount: 2, unit: "ml", itemName: "Olive Oil"),
        RecipeIngredient(amount: 5, unit: "mg", itemName: "Salt"),
        RecipeIngredient(amount: 2, unit: "pcs", itemName: "Eggs"),
    ]
}
