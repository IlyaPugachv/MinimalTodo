import UIKit

extension UIButton {
    func setCustomImage(named imageName: String, for state: UIControl.State) {
        let image = UIImage(named: imageName)
        self.setImage(image, for: state)
    }
}

extension UIButton {
    
    func configureButton(
        title: String? = nil,
        titleColor: UIColor? = nil,
        font: UIFont? = nil,
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        image: UIImage? = nil,
        imageTintColor: UIColor? = nil
    ) {
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            self.setTitleColor(titleColor, for: .normal)
        }
        
        if let font = font {
            self.titleLabel?.font = font
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
        if let image = image {
            self.setImage(image, for: .normal)
        }
        
        if let imageTintColor = imageTintColor {
            self.tintColor = imageTintColor
        }
    }
}
