import Foundation
import CoreLocation

enum EventDetailRow {
    case image(String)
    case description(String)
    case price(String)
    case location(CLLocationCoordinate2D)
    case coupons([Coupon])
    case people([Person])
}

final class EventDetailViewModel {
    
    let apiProvider: EventsApiProvider
    var rows: [EventDetailRow] = []
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
                
                self.rows.append(.image(event.image))
                self.rows.append(.description(event.description))
                self.rows.append(.price("Preço: \(event.price)"))
                self.rows.append(.coupons(event.coupons))
                self.rows.append(.people(event.people))
                
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
