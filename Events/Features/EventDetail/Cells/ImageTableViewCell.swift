import UIKit

final class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageUIView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView?.layer.cornerRadius = 10
        imageView?.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
