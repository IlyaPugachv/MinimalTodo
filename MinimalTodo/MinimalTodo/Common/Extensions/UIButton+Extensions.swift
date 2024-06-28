import UIKit

extension UIButton {
    func setCustomImage(named imageName: String, for state: UIControl.State) {
        let image = UIImage(named: imageName)
        self.setImage(image, for: state)
    }
}
