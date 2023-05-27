
import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
               
                    Text("Deine Kühlschrank-KPIs:")
                        .font(.headline)
                    Text("Letzte 30 Tage")
                        .font(.caption)
                
                // show 4 (?) KPIs for the last 30 days
                // How many goods did get past the expiration date?
                // Which items do you consume the least/most?
                // What recipes do you like? -> What should you buy more?
                //
                KPIDataCell(value: "\(viewModel.avgDaysInFridge)d", description: "Durchschnittliche Zeit im Kühlschrank")
                KPIDataCell(value: "\(viewModel.countExpiredItems)", description: "Abgelaufene/schlecht gewordene Lebensmittel")
                KPIDataCell(value: "14.47kg", description: "Eingesparter Müll")
                Divider()
                Text("Deine beliebtesten / unbeliebtesten Produkte")
                    .font(.headline)
                HighlightedItemCell(dataEntry: FridgeItemDataEntry(item: FridgeItem.mockItems.first!, checkoutDate: Date(), reachedExpirationDate: false, cause: .used), message: "Du hast im letzten Monat 12 Rezepte mit diesem Lebensmittel gekocht!", type: .positive)
                HighlightedItemCell(dataEntry: FridgeItemDataEntry(item: FridgeItem.mockItems.last!, checkoutDate: Date(), reachedExpirationDate: true, cause: .used), message: "Alle Lebensmittel dieses Typs haben das Ablaufdatum erreicht ☹️", type: .negative)
            }
            .padding()
            .navigationTitle("Hi, Maximilian")
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: AppViewModel(fridgeItems: []))
    }
}
