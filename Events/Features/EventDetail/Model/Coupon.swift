import Foundation

struct Coupon: Decodable {
    let id: String
    let eventId: String
    let discount: Int
}

extension Coupon: Item {
    var text: String {
        return "Cupom: \(discount)%"
    }
    
    var image: Image {
        return .local("coupon")
    }
}
