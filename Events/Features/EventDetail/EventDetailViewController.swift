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
        
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        title = viewModel.title
        
        viewModel.fetchEvents { [tableView] (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    tableView?.reloadData()
                }
            case .failure:
                break
            }
        }
    }

    private func setupTableView() {
        tableView.register(of: ImageTableViewCell.self)
        tableView.register(of: TextTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
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
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension EventDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = viewModel.rows[indexPath.row]
        
        switch row {
        case .image:
            return 200
        case .description, .price:
            return UITableView.automaticDimension
        default:
            return 100
        }
    }
}
