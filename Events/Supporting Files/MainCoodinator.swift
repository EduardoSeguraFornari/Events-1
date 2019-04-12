import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: Navigator { get set }
    
    func start()
}

protocol Navigator {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
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

extension MainCoordinator: EventListViewModelDelegate {
    
    func didSelected(event: EventViewModel) {
        let viewModel = EventDetailViewModel(event, apiProvider: apiProvider)
        let viewController = EventDetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
