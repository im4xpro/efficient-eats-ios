import Foundation
import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    
    @Published var fridgeItems: [FridgeItem]
    @Published var recipes: [BackendRecipeResult]
    @Published var existingBackendItems: [BackendFridgeItemResult]
    
     var enrichedRecipes: [Recipe] {
        recipes.map { backendresult in
            let result = mapToRecipe(backendResult: backendresult)
            return result
        }
        
    }
    let apiHandler: APIHandler
    
    init(fridgeItems: [FridgeItem]) {
        self.fridgeItems = fridgeItems
        self.recipes = []
        self.existingBackendItems = []
        apiHandler = APIHandler()
    }
    
    
    func countItemsWithWarning() -> Int {
        fridgeItems.filter { $0.status == .dueSoon }.count
    }
    
    func mapToRecipe(backendResult: BackendRecipeResult) -> Recipe {
        
        // format the recipe ingredients to an object with properties; itemName = objectId
        let ingredients: [RecipeIngredient] = backendResult.Ingredients.map { ingredientSet in
            return RecipeIngredient(amount: Double(ingredientSet[0])!, unit: ingredientSet[1], itemName: ingredientSet[2])
        }
        
        var updatedRecipeIngredients = ingredients

        for (index, ingredient) in updatedRecipeIngredients.enumerated() {
            if let matchingItem = existingBackendItems.first(where: { $0.objectId == ingredient.itemName }) {
                updatedRecipeIngredients[index].itemName = matchingItem.Name
            }
        }
        
        print(updatedRecipeIngredients)
        
        return Recipe(name: backendResult.Name, description: "", ingredients: updatedRecipeIngredients, instruction: backendResult.Description, image: nil)
    }
    
    // KPI calculating
    var avgDaysInFridge: Int {
        let sum = FridgeItemDataEntry.mockData.reduce(0) { partialResult, dataEntry in
            print(dataEntry.daysInFridge)
            return partialResult + dataEntry.daysInFridge
        }
        print(sum)
        return sum / FridgeItemDataEntry.mockData.count
    }
    
    var countExpiredItems: Int {
        FridgeItemDataEntry.mockData.filter { $0.reachedExpirationDate }.count
    }
    
    
    
    func reloadIngredientsData() {
        apiHandler.getIngredients(completion: { result, error in
            self.existingBackendItems = []
            self.existingBackendItems += result ?? []
            print(result)
            print("Updated existing backend items [\(result?.count)]")
        })
    }
    
    func reloadRecipeData() {
        apiHandler.getRecipes(completion: { result, error in
            self.recipes = []
            self.recipes += result ?? []
            print(result)
            print("Updated existing backend recipes [\(result?.count)]")
        })
    }
    
    func calculateAvgDaysInFridge() -> Int {
        let sum = FridgeItemDataEntry.mockData.reduce(0) { partialResult, dataEntry in
            dataEntry.daysInFridge
        }
        
        return sum / FridgeItemDataEntry.mockData.count
    }
    
}

func fridgeItemsUsed(fridgeItems: [FridgeItem], in recipe: Recipe) -> [FridgeItem] {
    
    let recipeIngredients = recipe.ingredients.map { ingredientSet in
        return ingredientSet.itemName
    }
    
    let fridgeItemNames = fridgeItems.map { $0.name }
    let fridgeItemsInIngredients = recipeIngredients.filter { fridgeItemNames.contains($0) }
    
    return fridgeItems.filter { fridgeItemsInIngredients.contains($0.name)}
}
