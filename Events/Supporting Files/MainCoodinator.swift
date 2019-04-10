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
    var childCoordinators = [Coordinator]()
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
        let viewController = EventListViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
