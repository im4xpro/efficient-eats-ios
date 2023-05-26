
import SwiftUI

struct RecipeListCell: View {
    
    let recipe: Recipe
    @ObservedObject var viewModel: AppViewModel
    
    var fridgeItemsUsed: [FridgeItem] {
        mealmate_ios.fridgeItemsUsed(fridgeItems: viewModel.fridgeItems, in: recipe)
    }
    
    var countUsedItems: Int {
        let dueItems = viewModel.fridgeItems.filter { $0.status == .dueSoon }.map { $0.name }
        return fridgeItemsUsed
            .filter { dueItems.contains($0.name) }
            .count
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
//                if recipe.image != nil {
//                    Image(recipe.image!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 50, height: 50)
//                } else {
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .font(.system(size: 32))
                        .frame(width: 50, height: 50)
//                }
                VStack(alignment: .leading){
                    Text(recipe.name)
                        .font(.title2)
                    ForEach(recipe.ingredients, id: \.id) { ingredientSet in
                        Text("\(ingredientSet.amount.formatted()) \(ingredientSet.unit) \(ingredientSet.itemName)")
                    }
                }
                Spacer()
              Image(systemName: "chevron.right")
            }
            
            if countUsedItems == 1 {
                Text("This recipe will use \(countUsedItems) Item in your fridge that is due soon!")
                    .bold()
                    .foregroundColor(.green)
            } else if countUsedItems == 0{
                Text("This recipe may use ingredients from your fridge")
                    .foregroundColor(.gray)
            } else {
                Text("This recipe will use \(countUsedItems) Items in your fridge that are due soon!")
                    .bold()
                    .foregroundColor(.green)
            }
            

        }
    }
}

struct RecipeListCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListCell(recipe: Recipe(name: "Pfannkuchen", description: "", ingredients: [], instruction: [], image: nil), viewModel: AppViewModel(fridgeItems: []))
    }
}
