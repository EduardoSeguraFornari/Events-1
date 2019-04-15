import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: Navigator { get set }
    
    func start()
}

protocol Navigator {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension UINavigationController: Navigator {}

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: Navigator
    let apiProvider = EventsApiProvider()
    
    init(navigationController: Navigator) {
        self.navigationController = navigationController
        
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        guard let navigationController = navigationController as? UINavigationController else { return }
        
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let viewModel = EventListViewModel(apiProvider: apiProvider)
        viewModel.delegate = self
        let viewController = EventListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
}

// MARK: - EventListViewModelDelegate
extension MainCoordinator: EventListViewModelDelegate {
    
    func didSelected(event: EventViewModel) {
        let viewModel = EventDetailViewModel(event, apiProvider: apiProvider)
        viewModel.delegate = self
        let viewController = EventDetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - EventDetailViewModelDelegate
extension MainCoordinator: EventDetailViewModelDelegate {
    func shareActionTriggered(text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        navigationController.present(activityViewController, animated: true, completion: nil)
    }
    
    func checkinActionTriggered(eventId: String) {
        let viewModel = CheckinViewModel(eventId: eventId, apiProvider: apiProvider)
        viewModel.delegate = self
        let viewController = CheckinViewController(viewModel: viewModel)
        let rootViewController = UINavigationController(rootViewController: viewController)
        
        navigationController.present(rootViewController, animated: true, completion: nil)
    }
}

extension MainCoordinator: CheckinViewModelDelegate {
    func cancelActionTriggered() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func doneActionTriggered() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
