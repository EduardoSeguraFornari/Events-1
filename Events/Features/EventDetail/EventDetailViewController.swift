import UIKit

final class EventDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel: EventDetailViewModel
    
    init(viewModel: EventDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        setupTableView()
        bindViewModel()
    }
    
    @objc private func shareAction() {
        viewModel.shareActionTrigger()
    }
    
    @objc private func checkinAction() {
        viewModel.checkinActionTrigger()
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

    private func setupNavigationItems() {
        navigationItem.largeTitleDisplayMode = .never
        
        var buttons: [UIBarButtonItem] = []
        
        buttons.append(UIBarButtonItem(barButtonSystemItem: .action,
                                       target: self,
                                       action: #selector(shareAction)))
        
        buttons.append(UIBarButtonItem(title: "Check-in",
                                       style: .plain,
                                       target: self,
                                       action: #selector(checkinAction)))
        
        navigationItem.rightBarButtonItems = buttons
    }
    
    private func setupTableView() {
        tableView.register(of: ImageTableViewCell.self)
        tableView.register(of: TextTableViewCell.self)
        tableView.register(of: CollectionTableViewCell.self)
        tableView.register(of: MapTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource
extension EventDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.rows[indexPath.row]
        
        switch row {
        case .image(let url):
            let cell: ImageTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.imageUIView.loadImage(url)
            return cell
        case .description(let text), .price(let text):
            let cell: TextTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.textUILabel.text = text
            return cell
        case .people(let items):
            let cell: CollectionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.items = items
            return cell
        case .coupons(let items):
            let cell: CollectionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.items = items
            return cell
        case .location(let location):
            let cell: MapTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.title = viewModel.title
            cell.location = location
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension EventDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = viewModel.rows[indexPath.row]
        
        switch row {
        case .description, .price:
            return UITableView.automaticDimension
        case .image:
            return 200
        case .people, .coupons:
            return 110
        case .location:
            return 200
        }
    }
}
