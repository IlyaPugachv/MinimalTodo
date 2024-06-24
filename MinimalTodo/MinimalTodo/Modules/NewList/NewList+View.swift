import UIKit

struct TodoList {
    var title: String
    var items: [String]
    var label: String
    var date: String
}

extension NewList {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
               private lazy var safeArea = self.view.safeAreaLayoutGuide
               private var todoLists: [TodoList] = []
        
        // MARK: - Subviews -
        
        private let backButton: UIButton = .init()
        private let toggleButton = ToggleButton()
        
        private var todoItems: [TodoItem] = []
        
        private let titleTextField: UITextField = .init()
        private let plusTodoImageView: UIImageView = .init()
        private let addListButton: UIButton = .init()
        private let stackView: UIStackView = .init()
        private let addButtonStack: UIStackView = .init()
        
        private var separatorView: UIView = .init()
        private let chooseLabel: UILabel = .init()
        
        private let horizontalButtonStackView = HorizontalButtonStack()
        
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
            setupActions()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .white
            
            view.addView(toggleButton)
            view.addView(backButton)
            view.addView(titleTextField)
            view.addView(stackView)
            view.addView(addButtonStack)
            view.addView(horizontalButtonStackView)
            view.addView(chooseLabel)
            view.addView(separatorView)
        }
        
        private func configureSubviews() {
            
            backButton.setImage(UIImage(named: "custom_back_arrow"), for: .normal)
            
            let backButtonItem = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = backButtonItem
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
            let toggleButtonItem = UIBarButtonItem(customView: toggleButton)
            navigationItem.rightBarButtonItem = toggleButtonItem
            
            titleTextField.placeholder = .Localization.title
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
            
            chooseLabel.text = .Localization.chooseALabel
            chooseLabel.font = .interSemibold(of: 20)
            chooseLabel.textColor = .black
            
            separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                
                toggleButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
                toggleButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
                
                backButton.topAnchor.constraint(equalTo: toggleButton.topAnchor),
                backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                
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
                
                horizontalButtonStackView.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 35),
                horizontalButtonStackView.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
                horizontalButtonStackView.trailingAnchor.constraint(equalTo: separatorView.trailingAnchor),
                
                
            ])
        }
        
        private func addItemView(_ item: TodoItem) {
            let itemView = createItemView(item)
            stackView.addArrangedSubview(itemView)
        }
        
        private func createItemView(_ item: TodoItem) -> UIView {
            let itemView = TodoItemView(item: item, delegate: self, checkBoxAction: #selector(toggleCheckBox(_:)), target: self)
            return itemView
        }
        
        private func setupActions() {
            backButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                self.presenter.back()
            }), for: .touchUpInside)
            
            toggleButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                self.saveTodoList()
            }), for: .touchUpInside)
        }
        
        private func saveTodoList() {
            let title = titleTextField.text ?? ""
            let items = todoItems.map { $0.title }
            let label = "Personal" // или другая выбранная метка
            let date = "13-05-2022" // текущая дата или другая дата
            
            let newList = TodoList(title: title, items: items, label: label, date: date)
            todoLists.append(newList)
            
            presenter.updateMainView(with: newList)
            presenter.back()
        }
    

        
        // MARK: - OBJC FUNC -
        
        @objc
        private func toggleCheckBox(_ sender: UIButton) {
            sender.isSelected.toggle()
        }
        
        @objc
        private func addTodoItem() {
            let newItem = TodoItem(title: "")
            todoItems.append(newItem)
            addItemView(newItem)
        }
    }
}

// MARK: - Extension View -

extension NewList.View: NewListView, UITextFieldDelegate { 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let itemView = textField.superview as? TodoItemView {
            itemView.textFieldDidEndEditing(textField)
        }
    }
}
