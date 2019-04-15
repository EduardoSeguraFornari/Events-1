import UIKit
@testable import Events

final class MockNavigator: Navigator {
    
    var pushedViewController: ((UIViewController) -> Void)?
    var presentedViewController: ((UIViewController) -> Void)?
    var dimissed: (() -> Void)?
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController?(viewController)
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentedViewController?(viewControllerToPresent)
        completion?()
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        dimissed?()
        completion?()
    }
}
