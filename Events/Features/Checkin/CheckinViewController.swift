import UIKit

final class CheckinViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    let viewModel: CheckinViewModel
    
    init(viewModel: CheckinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupNavigationItems()
    }
    
    private func bindViewModel() {
        title = viewModel.title
    }
    
    private func setupNavigationItems() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneAction))
    }
    
    @objc private func cancelAction() {
        viewModel.cancelTrigger()
    }
    
    @objc private func doneAction() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        viewModel.doneActionTrigger(name: name, email: email)
    }
}
