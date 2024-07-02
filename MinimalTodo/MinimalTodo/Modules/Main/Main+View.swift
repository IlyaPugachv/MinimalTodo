import UIKit

extension Main {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        private var todoLists: [TodoList] = []
        
        // MARK: - Subviews -
        
        private let appMiniIconImageView: UIImageView = .init(image: .applicationMiniIcon)
        private let nameAppLabel: UILabel = .init()
        private let searchImageView: UIImageView = .init()
        private let segmentedControl: CustomSegmentedControl = .init()
        private let appImage: UIImageView = .init(image: .imageApp)
        private let createTodoLabel: UILabel = .init()
        private let newListButton: UIButton = .init()
        
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
            loadTodoListsFromUserDefaults()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateUI()
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
            view.addView(appMiniIconImageView)
            view.addView(nameAppLabel)
            view.addView(searchImageView)
            view.addView(segmentedControl)
            view.addView(appImage)
            view.addView(createTodoLabel)
            view.addView(newListButton)
        }
        
        private func configureSubviews() {
            navigationItem.hidesBackButton = true
            
            segmentedControl.delegate = self
            
            appMiniIconImageView.contentMode = .scaleAspectFit
            
            nameAppLabel.configureLabel(
                text: "MinimalTodo",
                font: .interSemibold(of: 20),
                color: .black
            )
            
            searchImageView.image = UIImage(systemName: "magnifyingglass")
            searchImageView.tintColor = .black
            
            createTodoLabel.configureLabel(
                text: .Localization.createYourFirstTodoList,
                font: .interSemibold(of: 20),
                color: .black
            )
            
            newListButton.backgroundColor = .black
            newListButton.layer.cornerRadius = 32.5
            
            let plusImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
            newListButton.setImage(plusImage, for: .normal)
            newListButton.tintColor = .white
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                appMiniIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                appMiniIconImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
                appMiniIconImageView.widthAnchor.constraint(equalToConstant: 31),
                appMiniIconImageView.heightAnchor.constraint(equalToConstant: 26),
                
                nameAppLabel.topAnchor.constraint(equalTo: appMiniIconImageView.topAnchor),
                nameAppLabel.leadingAnchor.constraint(equalTo: appMiniIconImageView.trailingAnchor, constant: 10),
                
                searchImageView.topAnchor.constraint(equalTo: appMiniIconImageView.topAnchor),
                searchImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
                searchImageView.widthAnchor.constraint(equalToConstant: 24),
                searchImageView.heightAnchor.constraint(equalToConstant: 24),
                
                segmentedControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 65),
                segmentedControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                segmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                segmentedControl.heightAnchor.constraint(equalToConstant: 47),
                
                appImage.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 50),
                appImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                createTodoLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -160),
                createTodoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                newListButton.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 25),
                newListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                newListButton.widthAnchor.constraint(equalToConstant: 65),
                newListButton.heightAnchor.constraint(equalToConstant: 65),
            ])
        }
        
        private func setupActions() {
            newListButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.presenter.goToNewListScreen()
            }), for: .touchUpInside)
        }
        
        private func updateUI() {
            view.subviews.forEach { subview in
                if subview is TodoListView {
                    subview.removeFromSuperview()
                }
            }
            
            let filteredTodoLists = filterTodoLists()
            
            if filteredTodoLists.isEmpty {
                appImage.isHidden = false
                createTodoLabel.isHidden = false
            } else {
                appImage.isHidden = true
                createTodoLabel.isHidden = true
                
                var previousView: UIView? = segmentedControl
                for todoList in filteredTodoLists {
                    let todoListView = TodoListView(todoList: todoList)
                    todoListView.delegate = self
                    view.addView(todoListView)
                    
                    NSLayoutConstraint.activate([
                        todoListView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? view.topAnchor, constant: 20),
                        todoListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                        todoListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                    ])
                    
                    previousView = todoListView
                }
            }
        }
        
        private func filterTodoLists() -> [TodoList] {
            let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
            switch selectedSegmentIndex {
            case 0:
                return todoLists.filter { !$0.isPinned } // All Lists excluding pinned
            case 1:
                return todoLists.filter { $0.isPinned } // Pinned Lists
            default:
                return todoLists.filter { !$0.isPinned } // Default to All Lists excluding pinned
            }
        }
        
        private func loadTodoListsFromUserDefaults() {
            if let savedData = UserDefaults.standard.data(forKey: "TodoLists") {
                let decoder = JSONDecoder()
                if let loadedLists = try? decoder.decode([TodoList].self, from: savedData) {
                    todoLists = loadedLists
                }
            }
        }
        
        public func addTodoList(_ todoList: TodoList) {
            var newTodoList = todoList
            newTodoList.assignRandomColor()
            todoLists.append(newTodoList)
            saveTodoListsToUserDefaults()
            updateUI()
        }
        
        private func saveTodoListsToUserDefaults() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(todoLists) {
                UserDefaults.standard.set(encoded, forKey: "TodoLists")
            }
        }
    }
}

extension Main.View: MainView, TodoListViewDelegate {
    func todoListViewDidSwipeToDelete(_ todoListView: TodoListView) {
        guard let index = todoLists.firstIndex(where: { $0.id == todoListView.todoList.id }) else { return }
        
        todoListView.animateDeletion { [weak self] in
            guard let self = self else { return }
            self.todoLists.remove(at: index)
            self.saveTodoListsToUserDefaults()
            self.updateUI()
        }
    }
}

extension Main.View: CustomSegmentedControlDelegate {
    func segmentedControlChanged(to index: Int) {
        updateUI()
    }
}
