import Foundation
import CoreLocation

enum EventDetailSection {
    case image(String)
    case description(String)
    case price(Double)
    case location(CLLocationCoordinate2D)
    case coupons([Coupon])
    case people([Person])
}

final class EventDetailViewModel {
    
    let apiProvider: EventsApiProvider
    var sections: [EventDetailSection] = []
    let title: String
    let eventId: String
    
    init(_ event: EventViewModel, apiProvider: EventsApiProvider) {
        self.apiProvider = apiProvider
        self.title = event.title
        self.eventId = event.id
    }
    
    func fetchEvents(completion: @escaping (Result<Void, AnyError>) -> Void) {
        apiProvider.request(for: .event(id: eventId)) { [weak self] (result: Result<EventDetail, AnyError>) in
            guard let self = self else { return }
            switch result {
            case .success(let event):
                
                self.sections.append(.image(event.image))
                self.sections.append(.description(event.description))
                self.sections.append(.price(event.price))
                self.sections.append(.coupons(event.coupons))
                self.sections.append(.people(event.people))
                
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
