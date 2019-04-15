import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        showMessage(error.localizedDescription)
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Erro",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
