import SwiftUI

struct AddItemView: View {
    
    @ObservedObject var viewModel: AppViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var userInputName = ""
    @State private var userInputAmount = 1
    @State private var userInputDate = Date()
    
    var knownItem: Bool {
        !viewModel.existingBackendItems.filter { $0.Name == userInputName }.isEmpty
    }
    var item: BackendFridgeItemResult? {
        viewModel.existingBackendItems.filter { $0.Name == userInputName }.first
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("Welches Gut hast du vor dir?", text: $userInputName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Stepper("Menge: \(userInputAmount)", value: $userInputAmount, in: 1...10)
                                    .padding(.horizontal)
                                    .padding(.bottom, 10)
                Text("Gib das Haltbarkeitsdatum an.")
                DatePicker("Haltbarkeitsdatum", selection: $userInputDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: knownItem) { newValue in
                        if knownItem {
                            userInputDate = calculateExpirationDate(days: item!.expirationTime)
                        } else {
                            userInputDate = Date()
                        }
                    }
                
                if knownItem {
                    Text("Info: Geschätztes Haltbarkeitsdatum: \(item!.expirationTime) Tage.")
                } else {
                    Text("")
                }
                
                Spacer()
                Button(action: {
                    let item = FridgeItem(name: userInputName, amount: userInputAmount, description: "", addedDate: Date(), expirationDate: userInputDate, category: .food)
                    
                    viewModel.fridgeItems.append(item)
                    
                    // Calendar.current.date(byAdding: DateComponents.init(day: item.expirationTime)
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Hinzufügen")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(userInputName.isEmpty)
                .opacity(userInputName.isEmpty ? 0.3 : 1.0)
                
                
            }
            .navigationTitle("Hinzufügen")
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing){
                    Button {
                        print("IMPLEMENT ME")
                    } label: {
                        Image(systemName: "camera")
                    }

                }
                
                ToolbarItem (placement: .navigationBarLeading){
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Abbrechen")
                    }

                }
            }
        }
    }
}
struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewModel: AppViewModel(fridgeItems: []))
    }
}

private func calculateExpirationDate(days: Int) -> Date {
        if days > 0 {
            return Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()
        } else {
            return Date()
        }
    }
