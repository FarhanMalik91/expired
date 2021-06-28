





import UIKit

class ImageView: UIImageView {
    init(image : String ) {
        super.init(frame : CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: image)
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
