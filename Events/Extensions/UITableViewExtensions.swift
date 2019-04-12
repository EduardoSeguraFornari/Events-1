import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(of type: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier,
                                             for: indexPath) as? T else {
                                                fatalError("Could not find cell with \(T.identifier) identifier")
        }
        return cell
    }
}
