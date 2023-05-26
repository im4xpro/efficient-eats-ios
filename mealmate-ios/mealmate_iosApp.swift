import SwiftUI
import ParseSwift

@main
struct mealmate_iosApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    let viewModel = AppViewModel(fridgeItems: [])
    
    init() {
        loadMockDataToVM()
        
    }
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
        
    
    func loadMockDataToVM() {
        viewModel.fridgeItems += FridgeItem.mockItems
        // viewModel.recipes += BackendRecipeResult.mockData
    }
}
