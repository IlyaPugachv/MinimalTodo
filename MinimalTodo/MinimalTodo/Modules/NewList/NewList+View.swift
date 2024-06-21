import UIKit

extension NewList {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
        
        private var todoItems: [TodoItem] = []
        
        private let titleTextField: UITextField = .init()
        private let plusTodoImageView: UIImageView = .init()
        private let addListButton: UIButton = .init()
        private let stackView: UIStackView = .init()
        private let addButtonStack: UIStackView = .init()
        private let toggleButton = ToggleButton()
        private let stack = HorizontalButtonStack()
        
        private let chooseLabel: UILabel = .init()
        
        private var separatorView: UIView = .init()
        
        // MARK: - Initializers -
        
        public init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        deinit { }
        
        // MARK: - Lifecycle -
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .white
            view.addView(toggleButton)
            view.addView(titleTextField)
            view.addView(stackView)
            view.addView(addButtonStack)
            view.addView(stack)
            view.addView(chooseLabel)
            view.addView(separatorView)
        }
        
        private func configureSubviews() {
            
            titleTextField.placeholder = "Title"
            titleTextField.font = UIFont.systemFont(
                ofSize: 24,
                weight: .bold
            )
            
            titleTextField.returnKeyType = .done
            titleTextField.delegate = self
            
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            
            plusTodoImageView.image = UIImage(systemName: "plus.square")
            plusTodoImageView.tintColor = .black
            plusTodoImageView.contentMode = .scaleAspectFit
            
            addListButton.setTitle("To-do", for: .normal)
            addListButton.setTitleColor(.lightGray, for: .normal)
            addListButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            addListButton.addTarget(self, action: #selector(addTodoItem), for: .touchUpInside)
            
            addButtonStack.axis = .horizontal
            addButtonStack.alignment = .center
            addButtonStack.distribution = .fill
            addButtonStack.spacing = 8
            
            addButtonStack.addArrangedSubview(plusTodoImageView)
            addButtonStack.addArrangedSubview(addListButton)
            
            chooseLabel.text = "Choose a label"
            chooseLabel.font = .interSemibold(of: 20)
            chooseLabel.textColor = .black
            
            separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                
                toggleButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
                toggleButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
                
                titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
                titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                titleTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                stackView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                
                addButtonStack.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
                addButtonStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                addButtonStack.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -20),
                addButtonStack.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -20),
                
                plusTodoImageView.widthAnchor.constraint(equalToConstant: 20),
                plusTodoImageView.heightAnchor.constraint(equalToConstant: 20),
                
                separatorView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -150),
                separatorView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                separatorView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                separatorView.heightAnchor.constraint(equalToConstant: 1),
                
                chooseLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
                chooseLabel.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
                
                stack.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 35),
                stack.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
                stack.trailingAnchor.constraint(equalTo: separatorView.trailingAnchor),
                
              
            ])
        }
        
        @objc private func addTodoItem() {
            let newItem = TodoItem(title: "")
            todoItems.append(newItem)
            addItemView(newItem)
        }
        
        private func addItemView(_ item: TodoItem) {
            let itemView = createItemView(item)
            stackView.addArrangedSubview(itemView)
        }
        
        private func createItemView(_ item: TodoItem) -> UIView {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.alignment = .center
            hStack.distribution = .fill
            hStack.spacing = 8
            hStack.translatesAutoresizingMaskIntoConstraints = false
            
            let checkBox = UIButton(type: .custom)
            checkBox.setImage(UIImage(systemName: "square"), for: .normal)
            checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            checkBox.tintColor = .black
            checkBox.addTarget(self, action: #selector(toggleCheckBox(_:)), for: .touchUpInside)
            checkBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
            checkBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
            checkBox.contentMode = .scaleAspectFit
            
            let textField = UITextField()
            textField.placeholder = "To-do"
            textField.font = UIFont.systemFont(ofSize: 18)
            textField.borderStyle = .none
            textField.returnKeyType = .done
            textField.text = item.title
            textField.delegate = self
            textField.translatesAutoresizingMaskIntoConstraints = false

            hStack.addArrangedSubview(checkBox)
            hStack.addArrangedSubview(textField)
            
            return hStack
        }

        @objc private func toggleCheckBox(_ sender: UIButton) {
            sender.isSelected.toggle()
        }
    }
}

extension NewList.View: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class TodoItem {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

// MARK: - Extension View -

extension NewList.View: NewListView { }
