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
        
        title = "Events"
        
        setupTableView()
        
        viewModel.fetchEvents { [tableView] (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    tableView?.reloadData()
                }
            case .failure(let error):
                break
            }
        }
    }
    
    private func setupTableView() {
        tableView.register(of: EventTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
