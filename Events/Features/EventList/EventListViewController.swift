import UIKit

final class EventListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: EventListViewModel
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        title = viewModel.title
        viewModel.fetchEvents { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.tableView?.reloadData()
            case .failure(let error):
                self.showError(error)
            }
        }
    }
    
    private func setupTableView() {
        tableView.register(of: EventTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
}

// MARK: - UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectEvent(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.event = viewModel[indexPath.row]
        
        return cell
        
    }
    
}
