import UIKit

extension UITextField {
    
    func configureTextField(
        placeholder: String? = nil,
        font: UIFont = .systemFont(ofSize: 14),
        returnKeyType: UIReturnKeyType = .default,
        delegate: UITextFieldDelegate? = nil,
        icon: UIImage? = nil,
        iconColor: UIColor = .black,
        backgroundColor: UIColor = .white,
        placeholderColor: UIColor = .lightGray,
        textColor: UIColor = .black,
        cornerRadius: CGFloat = 8,
        padding: CGFloat = 10,
        textAlignment: NSTextAlignment = .left
    ) {
        self.placeholder = placeholder
        self.font = font
        self.returnKeyType = returnKeyType
        self.delegate = delegate
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.textAlignment = textAlignment
        self.textColor = textColor
        
        if let icon = icon {
            let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
            iconView.image = icon.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = iconColor
            iconView.contentMode = .scaleAspectFit
            
            let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            iconContainerView.addSubview(iconView)
            
            self.leftView = iconContainerView
            self.leftViewMode = .always
        } else {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        addClearButton()
        
        if let placeholder = placeholder {
            setPlaceholder(for: self, with: placeholder, color: placeholderColor)
        }
    }
    
    private func setPlaceholder(for textField: UITextField, with text: String, color: UIColor) {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    private func addClearButton() {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .Colors.darkGray
        clearButton.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        
        let clearButtonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        clearButtonContainer.addSubview(clearButton)
        clearButton.center = clearButtonContainer.center
        
        self.rightView = clearButtonContainer
        self.rightViewMode = .whileEditing
    }
    
    @objc 
    private func clearText() {
        self.text = ""
    }
}
