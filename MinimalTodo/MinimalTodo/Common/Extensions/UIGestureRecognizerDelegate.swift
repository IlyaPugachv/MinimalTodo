import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        if let activeTextField = findActiveTextField(in: self.view),
           let clearButton = activeTextField.rightView,
           clearButton.point(inside: clearButton.convert(location, from: self.view), with: nil) {
            return
        }
        
        view.endEditing(true)
    }

    private func findActiveTextField(in view: UIView) -> UITextField? {
        for subview in view.subviews {
            if let textField = subview as? UITextField, textField.isFirstResponder {
                return textField
            } else if let textField = findActiveTextField(in: subview) {
                return textField
            }
        }
        return nil
    }
}
