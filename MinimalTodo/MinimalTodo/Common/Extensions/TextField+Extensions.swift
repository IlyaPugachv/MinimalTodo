import UIKit

extension UITextField {
    
    func configureTextField(placeholder: String, font: UIFont, returnKeyType: UIReturnKeyType, delegate: UITextFieldDelegate?) {
        self.placeholder = placeholder
        self.font = font
        self.returnKeyType = returnKeyType
        self.delegate = delegate
    }
}


