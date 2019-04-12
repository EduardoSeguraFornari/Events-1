import UIKit

enum Image {
    case remote(String)
    case local(String)
}

protocol Item {
    var text: String { get }
    var image: Image { get }
}

final class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
        }
    }
    
    var items: [Item] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(of: ItemCollectionViewCell.self)
        collectionView.dataSource = self
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(cellForItemAt: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel.text = item.text
        
        switch item.image {
        case .remote(let url):
            cell.imageView.loadImage(url)
        case .local(let name):
            cell.imageView.image = UIImage(named: name)
        }
        
        return cell
    }
    
}
