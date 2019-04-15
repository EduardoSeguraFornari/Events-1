import Foundation

protocol CheckinViewModelDelegate: AnyObject {
    func cancelActionTriggered()
    func doneActionTriggered()
}

final class CheckinViewModel {

    let title = "Check-in"
    let eventId: String
    let apiProvider: EventsApiProvider
    weak var delegate: CheckinViewModelDelegate?
    
    init(eventId: String, apiProvider: EventsApiProvider) {
        self.eventId = eventId
        self.apiProvider = apiProvider
    }
    
    func cancelTrigger() {
        delegate?.cancelActionTriggered()
    }
    
    func doneActionTrigger(name: String, email: String) {
        apiProvider.request(for: .checkin(name: name,
                                          email: email,
                                          eventId: eventId)) { [delegate] (result) in
                                            switch result {
                                            case .success:
                                                delegate?.doneActionTriggered()
                                            case .failure:
                                                delegate?.cancelActionTriggered()
                                            }
        }
        
    }
}
