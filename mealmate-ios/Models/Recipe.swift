
import Foundation


struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let ingredients: [RecipeIngredient]
    let expectedDuration: String
    let instruction: [String]
}


extension Recipe {
    static let mockData = [
        Recipe(name: "Pfannkuchen", description: "Quick and easy", ingredients: RecipeIngredient.mockData, expectedDuration: "00:30", instruction: [])
    ]
}
