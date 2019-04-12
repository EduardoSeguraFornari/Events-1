import Foundation

enum EventsApi {
    case events
    case event(id: String)
    case checkin(user: User, eventId: String)
}

extension EventsApi {
    static let baseUrl = "https://5b840ba5db24a100142dcd8c.mockapi.io"
    
    var path: String {
        switch self {
        case .events:
            return "/api/events"
        case .event(let id):
            return "/api/events/\(id)"
        case .checkin:
            return "/api/checkin"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .events, .event:
            return .get
        case let .checkin(user, eventId):
            var body = user.asDictionary()
            body["eventId"] = eventId
            return .post(body: body)
        }
    }
    
    func makeUrl() -> URL? {
        let components = URLComponents(string: EventsApi.baseUrl + path)
        
        return components?.url
    }
    
}

enum HttpMethod {
    case get
    case post(body: [String: Any])
}
