
import Foundation

protocol ConsumableItem: Identifiable {
    var id: UUID { get }
    var name: String { get set }
}
