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
        guard let name = nameTextField.text, !name.isEmpty else {
            showMessage("Campo nome é obrigatório.")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showMessage("Campo email é obrigatório.")
            return
        }
        
        viewModel.doneActionTrigger(name: name, email: email)
    }
}
