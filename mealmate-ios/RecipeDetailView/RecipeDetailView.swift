import SwiftUI

struct RecipeDetailView: View {
    
    @ObservedObject var viewModel: AppViewModel
    let recipe: Recipe
    
    var usedItemsString: [String] {
        fridgeItemsUsed(fridgeItems: viewModel.fridgeItems, in: recipe).map { $0.name }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Zutaten")
                    .font(.title2)
                    .bold()
                ForEach(recipe.ingredients) { ingredientSet in
                    Text("\(ingredientSet.amount.formatted()) \(ingredientSet.unit) \(ingredientSet.itemName)")
                }
                Text("Zutaten im Kühlschrank")
                    .font(.title2)
                    .bold()
                ForEach(usedItemsString, id: \.description) {
                    Text($0)
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Jetzt kochen!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

            }
            .navigationTitle(recipe.name)
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: AppViewModel(fridgeItems: []), recipe: Recipe(name: "Test", description: "", ingredients: [], instruction: [], image: nil))
    }
}
