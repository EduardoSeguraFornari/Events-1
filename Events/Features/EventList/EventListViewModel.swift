import Foundation

protocol EventListViewModelDelegate: AnyObject {
    func didSelected(event: EventViewModel)
}

final class EventListViewModel {
    private let apiProvider: EventsApiProvider
    private var events: [EventViewModel] = []
    
    weak var delegate: EventListViewModelDelegate?
    var count: Int {
        return events.count
    }
    let title = "Eventos"
    
    subscript(_ index: Int) -> EventViewModel {
        return events[index]
    }
    
    init(apiProvider: EventsApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchEvents(completion: @escaping (Result<Void, AnyError>) -> Void) {
        apiProvider.request(for: .events) { [weak self] (result: Result<[Event], AnyError>) in
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.events = events.map(EventViewModel.init)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func selectEvent(at indexPath: IndexPath) {
        let event = events[indexPath.row]
        delegate?.didSelected(event: event)
    }
}
