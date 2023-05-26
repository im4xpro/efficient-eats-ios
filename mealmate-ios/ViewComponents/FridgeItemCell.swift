//
//  ItemCell.swift
//  mealmate-ios
//
//  Created by Maximilian Kaiser on 25.05.23.
//

import SwiftUI

struct FridgeItemCell: View {
    
    let model: FridgeItem
    
    var statusColor: Color {
        var color = Color.gray
        if model.status == .good { color = .green }
        if model.status == .dueSoon { color = .orange }
        if model.status == .expired { color = .red }
        
        return color
    }
    
    var dateDifferenceInDays: Int { calculateDateDifference(startDate: Date(), endDate: model.expirationDate).day ?? 0 }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "takeoutbag.and.cup.and.straw")
                    .font(.system(size: 32))
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading){
                    Text(model.name)
                        .font(.title2)
                    Text(model.category.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Circle()
                    .fill(statusColor)
                    .frame(width:20, height: 20)
            }
            Text("Added: \(model.addedDate.formatted())")
            if model.status == .expired {
                Text("Expired since \(model.expirationDate.formatted()) (\(dateDifferenceInDays) Days)")
                    .foregroundColor(.red)
                    .bold()
            } else {
                Text("Good until: \(model.expirationDate.formatted()) (\(dateDifferenceInDays) Days)")
            }
            
            Button {
                
            } label: {
                Text("Show me recipes with this item!")
            }

        }
    }
}

struct FridgeItemCell_Previews: PreviewProvider {
    static var previews: some View {
        FridgeItemCell(model: FridgeItem.mockItems.first!)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("FridgeItemCell")
    }
}
