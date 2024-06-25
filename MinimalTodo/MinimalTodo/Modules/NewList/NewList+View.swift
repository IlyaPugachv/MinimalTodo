import UIKit

struct TodoList {
    var title: String
    var label: String
    var date: String
}

extension NewList {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        private var todoLists: [TodoList] = []
        private var selectedLabel: String?
        
        // MARK: - Subviews -
        
        private let backButton: UIButton = .init()
        private let toggleButton = ToggleButton()
        
        private let titleTextField: UITextField = .init()
        private let plusTodoImageView: UIImageView = .init()
        private let addListButton: UIButton = .init()
        private let stackView: UIStackView = .init()
        private let addButtonStack: UIStackView = .init()
        
        private var separatorView: UIView = .init()
        private let chooseLabel: UILabel = .init()
        
        private let helloButton: UIButton = .init()
        private let byeButton: UIButton = .init()
        private let seeButton: UIButton = .init()
        private let haveButton: UIButton = .init()
        
        private let buttonStackView: UIStackView = .init()
        
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
        
        public override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            saveTodoList()
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
            view.addView(chooseLabel)
            view.addView(separatorView)
            view.addView(buttonStackView)
        }
        
        private func configureSubviews() {
            
            backButton.setImage(UIImage(named: "custom_back_arrow"), for: .normal)
            
            let backButtonItem = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = backButtonItem
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
            let toggleButtonItem = UIBarButtonItem(customView: toggleButton)
            navigationItem.rightBarButtonItem = toggleButtonItem
            
            titleTextField.placeholder = "Title"
            titleTextField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            titleTextField.returnKeyType = .done
            titleTextField.delegate = self
            
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            
            addButtonStack.axis = .horizontal
            addButtonStack.alignment = .center
            addButtonStack.distribution = .fill
            addButtonStack.spacing = 8
            
            addButtonStack.addArrangedSubview(plusTodoImageView)
            addButtonStack.addArrangedSubview(addListButton)
            
            chooseLabel.text = "Choose a Label"
            chooseLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            chooseLabel.textColor = .black
            
            separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            
            [helloButton, byeButton, seeButton, haveButton].forEach {
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = .lightGray
                $0.layer.cornerRadius = 8
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.addTarget(self, action: #selector(labelButtonTapped(_:)), for: .touchUpInside)
            }
            
            helloButton.setTitle("Personal", for: .normal)
            byeButton.setTitle("Work", for: .normal)
            seeButton.setTitle("Finance", for: .normal)
            haveButton.setTitle("Other", for: .normal)
            
            buttonStackView.axis = .horizontal
            buttonStackView.alignment = .center
            buttonStackView.distribution = .fillEqually
            buttonStackView.spacing = 10
            
            buttonStackView.addArrangedSubview(helloButton)
            buttonStackView.addArrangedSubview(byeButton)
            buttonStackView.addArrangedSubview(seeButton)
            buttonStackView.addArrangedSubview(haveButton)
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                toggleButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
                toggleButton.trailingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: -20),
                
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
                
                buttonStackView.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 10),
                buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                buttonStackView.heightAnchor.constraint(equalToConstant: 40),
            ])
        }
  
        private func setupActions() {
            backButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter.back()
            }), for: .touchUpInside)
        }
 
        private func saveTodoList() {
            let title = titleTextField.text ?? ""
            let label = selectedLabel ?? "Personal"
            let date = DateFormatter.formattedDate()
            
            let newList = TodoList(title: title, label: label, date: date)
            todoLists.append(newList)
            
            presenter.updateMainView(with: newList)
        }
        
        // MARK: - OBJC FUNC -
        
        @objc
        private func labelButtonTapped(_ sender: UIButton) {
            [helloButton, byeButton, seeButton, haveButton].forEach {
                $0.backgroundColor = .lightGray
            }
            sender.backgroundColor = .black
            selectedLabel = sender.title(for: .normal)
        }
    }
}

// MARK: - Extension View -

extension NewList.View: NewListView, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Presenter -


