import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(of type: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier,
                                             for: indexPath) as? T else {
                                                fatalError("Could not find cell with \(T.identifier) identifier")
        }
        return cell
    }
}
