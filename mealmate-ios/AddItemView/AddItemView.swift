import SwiftUI

struct AddItemView: View {
    
    @ObservedObject var viewModel: AppViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var userInputName = ""
    @State private var userInputAmount = 0
    
    var knownItem: Bool {
        !viewModel.existingBackendItems.filter { $0.Name == userInputName }.isEmpty
    }
    var item: BackendItem {
        viewModel.existingBackendItems.filter { $0.Name == userInputName }.first!
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("What item are you looking at?", text: $userInputName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if knownItem {
                    Text("Expected shelf life: \(item.expirationTime) days.")
                }
                
                Stepper("Amount: \(userInputAmount)", value: $userInputAmount, in: 1...10)
                                    .padding(.horizontal)
                Spacer()
                Button(action: {
                    let item = FridgeItem(name: userInputName, amount: userInputAmount, description: "", addedDate: Date(), expirationDate: Calendar.current.date(byAdding: DateComponents.init(day: item.expirationTime), to: Date())!, category: .food)
                    viewModel.fridgeItems.append(item)
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add to fridge")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                
            }
            .navigationTitle("Add a new item")
        }
    }
}
struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewModel: AppViewModel(fridgeItems: [], recipes: []))
    }
}
