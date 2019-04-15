import Foundation

final class CheckinViewModel {

    let eventId: String
    let apiProvider: EventsApiProvider
    
    init(eventId: String, apiProvider: EventsApiProvider) {
        self.eventId = eventId
        self.apiProvider = apiProvider
    }
    
    func checkin() {
        let user = User(name: "", email: "")
        apiProvider.request(for: .checkin(user: user, eventId: eventId)) { (_) in
            
        }
    }
}
