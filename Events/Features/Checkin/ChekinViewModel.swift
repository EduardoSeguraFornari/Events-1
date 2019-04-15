import Foundation

protocol CheckinViewModelDelegate: AnyObject {
    func cancelActionTriggered()
    func doneActionTriggered()
    func showMessage(_ message: String)
}

final class CheckinViewModel {

    let title = "Check-in"
    let eventId: String
    let apiProvider: EventsApiProviderType
    weak var delegate: CheckinViewModelDelegate?
    private let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    init(eventId: String, apiProvider: EventsApiProviderType) {
        self.eventId = eventId
        self.apiProvider = apiProvider
    }
    
    func cancelTrigger() {
        delegate?.cancelActionTriggered()
    }
    
    func doneActionTrigger(name: String, email: String) {
        guard !name.isEmpty else {
            delegate?.showMessage("Campo nome é obrigatório.")
            return
        }
        
        guard !email.isEmpty else {
            delegate?.showMessage("Campo email é obrigatório.")
            return
        }
        
        guard email.range(of: emailRegEx, options: .regularExpression) != nil else {
            delegate?.showMessage("Deve ser seguir o formato de email. Exemplo: test@test.com")
            return
        }
        
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
