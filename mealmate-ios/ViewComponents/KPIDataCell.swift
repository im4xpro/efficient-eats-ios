import SwiftUI

struct KPIDataCell: View {
    
    let value: String
    let description: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(height: 100)
            VStack {
                Text(value)
                    .font(.title)
                    .bold()
                Text(description)
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

struct KPIDataCell_Previews: PreviewProvider {
    static var previews: some View {
        KPIDataCell(value: "8.0%", description: "Verdorbene Lebensmittel")
    }
}
