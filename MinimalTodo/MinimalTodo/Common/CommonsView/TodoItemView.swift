import UIKit

final class TodoItem {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

class TodoItemView: UIView {
    
    private let item: TodoItem
    private weak var delegate: UITextFieldDelegate?

    private let checkBox: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        button.tintColor = .black
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "To-do"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .none
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(item: TodoItem, delegate: UITextFieldDelegate?, checkBoxAction: Selector, target: Any?) {
        self.item = item
        self.delegate = delegate
        super.init(frame: .zero)
        setupView(item: item, delegate: delegate, checkBoxAction: checkBoxAction, target: target)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(item: TodoItem, delegate: UITextFieldDelegate?, checkBoxAction: Selector, target: Any?) {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .fill
        hStack.spacing = 8
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        checkBox.addTarget(target, action: checkBoxAction, for: .touchUpInside)
        textField.text = item.title
        textField.delegate = delegate
        
        hStack.addArrangedSubview(checkBox)
        hStack.addArrangedSubview(textField)
        
        addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension TodoItemView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        item.title = textField.text ?? ""
    }
}
