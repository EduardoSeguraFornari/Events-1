import Foundation

final class EventDetailViewModel {
    
    let apiProvider: EventsApiProvider
    
    init(_ event: EventViewModel, apiProvider: EventsApiProvider) {
        self.apiProvider = apiProvider
    }
}
