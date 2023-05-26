import SwiftUI

struct AddItemView: View {
    
    @ObservedObject var viewModel: AppViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var userInputName = ""
    @State private var userInputDate = Date()
    
    var body: some View {
        VStack{
            TextField("What item are you looking at?", text: $userInputName)
            DatePicker("Select the expiration date", selection: $userInputDate)
            
            Button {
                let item = FridgeItem(name: userInputName, description: "", addedDate: Date(), expirationDate: userInputDate, category: .food)
                viewModel.fridgeItems.append(item)
                
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add to fridge")
            }

        }
        .navigationTitle("Add a new item")
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewModel: AppViewModel(fridgeItems: [], recipes: []))
    }
}
