import SwiftUI
import ParseSwift

struct RecipesView: View {
    
    @State private var searchText = ""

    @ObservedObject var viewModel: AppViewModel
    let apiHandler = APIHandler()
    
    var searchResults: [Recipe] {
        if searchText.isEmpty {
            return viewModel.enrichedRecipes
        } else {
            return viewModel.enrichedRecipes.filter {
                $0.name.contains(searchText) || $0.flattenedIngredients.contains(searchText)
                
                
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults, id: \.id) { recipe in
                        RecipeListCell(recipe: recipe, viewModel: viewModel)
                    }
                }
                .listStyle(.grouped)
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .searchable(text: $searchText, prompt: "I'm looking for...")
        .onAppear(
            perform: { viewModel.reloadRecipeData() }
        )
    }
}

struct Recipes: PreviewProvider {
    static var previews: some View {
        RecipesView(viewModel: AppViewModel(fridgeItems: []))
    }
}
