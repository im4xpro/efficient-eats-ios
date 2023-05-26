
import Foundation
import SwiftUI

struct FridgeItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let addedDate: Date
    let expirationDate: Date
    let category: FridgeItemCategory
    let image: Image?
    
    var status: FridgeItemStatus {
        let today = Date()
        let daysDifference = calculateDateDifference(startDate: today, endDate: expirationDate).day ?? 0
        
        if daysDifference > 7 {
            return .good
        } else if daysDifference <= 7 && daysDifference > 0 {
            return .dueSoon
        } else {
            return .expired
        }
    }
    
    init(name: String, description: String, addedDate: Date, expirationDate: Date, category: FridgeItemCategory) {
        self.name = name
        self.description = description
        self.addedDate = addedDate
        self.expirationDate = expirationDate
        self.category = category
        self.image = nil
    }
    
}


enum FridgeItemCategory: String {
    case beverage = "Beverages"
    case food = "Food"
}

enum FridgeItemStatus: String {
    case good = "Good"
    case dueSoon = "Due soon"
    case expired = "Expired"
}

public func calculateDateDifference(startDate: Date, endDate: Date) -> DateComponents {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: startDate, to: endDate)
    return components
}

extension FridgeItem {
    static let mockItems = [
        FridgeItem(name: "Milk", description: "Muuh", addedDate: Date(), expirationDate: Date(fromString: "2023-05-30")!, category: .food),
        FridgeItem(name: "Butter", description: "", addedDate: Date(), expirationDate: Date(fromString: "2023-06-30")!, category: .food),
        FridgeItem(name: "Olives", description: "", addedDate: Date(), expirationDate: Date(fromString: "2023-07-20")!, category: .food),
        FridgeItem(name: "Yoghurt", description: "", addedDate: Date(), expirationDate: Date(fromString: "2023-05-24")!, category: .food),
        FridgeItem(name: "Chicken", description: "", addedDate: Date(), expirationDate: Date(fromString: "2023-05-30")!, category: .food)
    ]
}
