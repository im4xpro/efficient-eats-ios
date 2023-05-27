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
                List{
                    ForEach(sortedResults, id: \.id) { item in
                        FridgeItemCell(model: item)
                    }
                    .onDelete(perform: delete)
    
                }
                .listStyle(.grouped)
            }
            .navigationTitle("Mein Kühlschrank")
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
        .searchable(text: $searchText, prompt: "Ich suche nach...")
        .onAppear(
            perform: { viewModel.reloadIngredientsData() }
        )
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.fridgeItems.remove(atOffsets: offsets)
    }
}

struct RefrigeratorView_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorView(viewModel: AppViewModel(fridgeItems: []))
    }
}
