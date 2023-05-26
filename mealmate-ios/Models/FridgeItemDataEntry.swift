import Foundation


struct FridgeItemDataEntry: Identifiable {
    let id = UUID()
    let item: FridgeItem
    let checkoutDate: Date
    let reachedExpirationDate: Bool
    let cause: ItemCheckoutCause
    
    var daysInFridge: Int {
        calculateDateDifference(startDate: item.addedDate, endDate: checkoutDate).day ?? 0
    }
    
    init(item: FridgeItem, checkoutDate: Date, reachedExpirationDate: Bool, cause: ItemCheckoutCause) {
        self.item = item
        self.checkoutDate = checkoutDate
        self.reachedExpirationDate = reachedExpirationDate
        self.cause = cause
    }
}

enum ItemCheckoutCause {
    case recipe
    case rotten
    case used
}

extension FridgeItemDataEntry {
    static let mockData = FridgeItem.mockItems.map { item in
        FridgeItemDataEntry(item: item, checkoutDate: Date(), reachedExpirationDate: true, cause: .recipe)
    }
}
