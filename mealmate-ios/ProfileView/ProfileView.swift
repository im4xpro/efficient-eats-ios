
import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Your personal fridge-KPIs:")
                    .font(.headline)
                // show 4 (?) KPIs for the last 30 days
                // How many goods did get past the expiration date?
                // Which items do you consume the least/most?
                // What recipes do you like? -> What should you buy more?
                //
                KPIDataCell(value: "\(viewModel.avgDaysInFridge)d", description: "Durchschnittliche Zeit im Kühlschrank")
                KPIDataCell(value: "\(viewModel.countExpiredItems)", description: "Abgelaufene/schlecht gewordene Lebensmittel")
                Divider()
                Text("Special items")
                    .font(.headline)
                HighlightedItemCell(dataEntry: FridgeItemDataEntry(item: FridgeItem.mockItems.first!, checkoutDate: Date(), reachedExpirationDate: false, cause: .used), message: "Added: You cooked 12 recipes with this item in the last 30 days", type: .positive)
                HighlightedItemCell(dataEntry: FridgeItemDataEntry(item: FridgeItem.mockItems.last!, checkoutDate: Date(), reachedExpirationDate: true, cause: .used), message: "8/10 items reached the expiration date", type: .negative)
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
