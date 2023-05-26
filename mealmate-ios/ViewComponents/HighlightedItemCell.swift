import SwiftUI

struct HighlightedItemCell: View {
    
    let dataEntry: FridgeItemDataEntry
    let message: String
    let type: ItemKPIType
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                if type == .positive {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.green)
                        .font(.system(size: 32))
                        .frame(width: 50, height: 50)
                } else {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.red)
                        .font(.system(size: 32))
                        .frame(width: 50, height: 50)
                }
                    
                VStack(alignment: .leading){
                    Text(dataEntry.item.name)
                        .font(.title2)
                    Text("Sum: \(dataEntry.item.amount) pcs")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
            }
            Text(message)
        
        }
    }
}

struct HighlightedItemCell_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedItemCell(dataEntry: FridgeItemDataEntry(item: FridgeItem.mockItems.first!, checkoutDate: Date(), reachedExpirationDate: false, cause: .used), message: "Added: You cooked 12 recipes with this item in the last 30 days", type: .negative)
    }
}

enum ItemKPIType {
    case positive
    case negative
}
