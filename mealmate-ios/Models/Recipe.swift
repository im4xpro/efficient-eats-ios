
import Foundation


struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let ingredients: [RecipeIngredient]
    let instruction: [String]
    let image: String?
    
    var flattenedIngredients: [String] {
        ingredients.map { $0.itemName }
    }
}

struct BackendRecipeResult: Codable {
    let Name: String
    let Description: [String]
    let objectId: String
    let createdAt: String
    let updatedAt: String
    let Ingredients: [[String]]
}


extension Recipe {
    static let mockData = [
        Recipe(name: "Pfannkuchen", description: "Quick and easy", ingredients: RecipeIngredient.mockData, instruction: [], image: "recipe-pancake")
    ]
}

extension BackendRecipeResult {
    static let mockData = [
        BackendRecipeResult(
            Name: "Pfannkuchen",
            Description: ["Test"],
            objectId: "123",
            createdAt: "2023-05-20",
            updatedAt: "2023-05-20",
            Ingredients: [["4","g","Salt"], ["20","pcs","Eggs"], ["400","ml","Milk"]]
        )
    ]
}
