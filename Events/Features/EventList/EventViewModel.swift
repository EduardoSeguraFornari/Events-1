import Foundation

struct EventViewModel {
    let id: String
    let title: String
    let description: String
    let image: String
    
    init(_ event: Event) {
        id = event.id
        title = event.title
        description = event.description
        image = event.image
    }
}
