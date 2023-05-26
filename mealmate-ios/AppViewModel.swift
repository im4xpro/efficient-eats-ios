import Foundation
import SwiftUI
import Combine

class AppViewModel: ObservableObject {
    
    @Published var fridgeItems: [FridgeItem]
    @Published var recipes: [Recipe]
    
    init(fridgeItems: [FridgeItem], recipes: [Recipe]) {
        self.fridgeItems = fridgeItems
        self.recipes = recipes
    }
    
}
