import UIKit
import RxSwift

final class EventListViewController: UIViewController {

    let apiProvider = EventsApiProvider()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(of: EventTableViewCell.self)
    }
}
