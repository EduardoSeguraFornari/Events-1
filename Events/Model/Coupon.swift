import Foundation

struct Coupon: Decodable {
    let id: String
    let eventId: String
    let discount: Int
}
