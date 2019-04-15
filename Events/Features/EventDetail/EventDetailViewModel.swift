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

protocol EventDetailViewModelDelegate: AnyObject {
    func checkinActionTriggered(eventId: String)
    func shareActionTriggered(text: String)
}

final class EventDetailViewModel {
    
    let apiProvider: EventsApiProvider
    var rows: [EventDetailRow] = []
    let title: String
    let eventId: String
    weak var delegate: EventDetailViewModelDelegate?
    
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
                self.makeRows(event)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func shareActionTrigger() {
        delegate?.shareActionTriggered(text: "teste")
    }
    
    func checkinActionTrigger() {
        delegate?.checkinActionTriggered(eventId: eventId)
    }
    
    private func makeRows(_ event: EventDetail) {
        self.rows.append(.image(event.image))
        self.rows.append(.description(event.description))
        self.rows.append(.price("Preço: \(event.price)"))
        
        if !event.coupons.isEmpty {
            self.rows.append(.coupons(event.coupons))
        }
        
        if !event.people.isEmpty {
            self.rows.append(.people(event.people))
        }
        
        let latitude: Double = event.latitude.left.flatMap(Double.init) ?? event.latitude.right ?? 0
        let longitude: Double = event.longitude.left.flatMap(Double.init) ?? event.longitude.right ?? 0
        
        self.rows.append(.location(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
    }
}
