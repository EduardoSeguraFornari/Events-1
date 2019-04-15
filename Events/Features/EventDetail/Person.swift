import Foundation

struct Person: Decodable {
    let id: String
    let eventId: String
    let name: String
    let picture: String
}

extension Person: Item {
    var text: String {
        return name
    }
    
    var image: Image {
        return .remote(picture)
    }
    
}
