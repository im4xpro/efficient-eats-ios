import SwiftUI
import ParseSwift

struct RefrigeratorView: View {
    
    @State private var searchText = ""
    @State private var sortedByExpiredDate = false
    @State private var presentAddItemView = false

    @ObservedObject var viewModel: AppViewModel
    let apiHandler = APIHandler()
    
    var searchResults: [FridgeItem] {
        if searchText.isEmpty {
            return viewModel.fridgeItems
        } else {
            return viewModel.fridgeItems.filter { $0.name.contains(searchText)}
        }
    }
    
    var sortedResults: [FridgeItem] {
        if sortedByExpiredDate {
            return searchResults.sorted { $0.expirationDate < $1.expirationDate }
        } else {
            return searchResults
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(sortedResults) { item in
                        FridgeItemCell(model: item)
                    }
                }
                .listStyle(.grouped)
            }
            .navigationTitle("My fridge")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sortedByExpiredDate.toggle()
                    } label: {
                        if sortedByExpiredDate {
                            Image(systemName: "arrowtriangle.down.square.fill")
                        } else {
                            Image(systemName: "arrowtriangle.up.square")
                        }
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentAddItemView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $presentAddItemView) {
                AddItemView(viewModel: viewModel)
            }
        }
        .searchable(text: $searchText, prompt: "I'm looking for...")
        .onAppear(
            perform: { apiHandler.getIngredients() }
        )
    }
}

struct RefrigeratorView_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorView(viewModel: AppViewModel(fridgeItems: [], recipes: []))
    }
}
