import Foundation

struct Event: Decodable {
    let id: String
    let title: String
    let price: Double
    let image: String
    let description: String
    let latitude: Either<String, Double>
    let longitude: Either<String, Double>
    let date: Date
    let coupons: [Coupon]
    let people: [Person]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case image
        case description
        case latitude
        case longitude
        case date
        case coupons = "cupons"
        case people
    }
}
