import Foundation

enum EventsApi {
    case events
    case event(id: String)
}

enum EventsApiPost {
    case checkin(name: String, email: String, eventId: String)
}

extension EventsApiPost {
    static let baseUrl = "https://5b840ba5db24a100142dcd8c.mockapi.io"
    
    var path: String {
        switch self {
        case .checkin:
            return "/api/checkin"
        }
    }
    
    var body: [String: Any] {
        switch self {
        case let .checkin(name, email, eventId):
            var dict: [String: Any] = [:]
            
            dict["name"] = name
            dict["email"] = email
            dict["eventId"] = eventId
            
            return dict
        }
    }
    
    func makeUrl() -> URL? {
        let components = URLComponents(string: EventsApi.baseUrl + path)
        
        return components?.url
    }
}

extension EventsApi {
    static let baseUrl = "https://5b840ba5db24a100142dcd8c.mockapi.io"
    
    var path: String {
        switch self {
        case .events:
            return "/api/events"
        case .event(let id):
            return "/api/events/\(id)"
        }
    }
    
    func makeUrl() -> URL? {
        let components = URLComponents(string: EventsApi.baseUrl + path)
        
        return components?.url
    }
    
}
