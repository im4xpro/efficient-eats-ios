import Foundation
import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    
    @Published var fridgeItems: [FridgeItem]
    @Published var recipes: [Recipe]
    @Published var existingBackendItems: [BackendItem]
    
    let apiHandler: APIHandler
    
    init(fridgeItems: [FridgeItem], recipes: [Recipe]) {
        self.fridgeItems = fridgeItems
        self.recipes = recipes
        self.existingBackendItems = []
        apiHandler = APIHandler()
    }
    
    func reloadData() {
        apiHandler.getIngredients(completion: { result, error in
            self.existingBackendItems = []
            self.existingBackendItems += result ?? []
            print(result)
            print("Updated existing backend items [\(result?.count)]")
        })
    }
    
}
