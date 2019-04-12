import UIKit

final class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var event: EventViewModel! {
        didSet {
            configure(event)
        }
    }
    
    private func configure(_ event: EventViewModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        iconImageView.loadImage(event.image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
