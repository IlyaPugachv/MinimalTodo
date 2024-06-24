import UIKit

extension Main {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
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
            
            appMiniIconImageView.contentMode = .scaleAspectFit
            
            nameAppLabel.text = "MinimalTodo"
            nameAppLabel.font = .interSemibold(of: 20)
            nameAppLabel.textColor = .black
            
            searchImageView.image = UIImage(systemName: "magnifyingglass")
            searchImageView.tintColor = .black
            
            appImage.contentMode = .scaleAspectFit
            
            createTodoLabel.text = .Localization.createYourFirstTodoList
            createTodoLabel.font = .interSemibold(of: 20)
            createTodoLabel.textColor = .black
            
            newListButton.setTitle(.Localization.newList, for: .normal)
            newListButton.setTitleColor(.white, for: .normal)
            newListButton.titleLabel?.font = UIFont.interMedium(of: 14)
            newListButton.backgroundColor = .black
            newListButton.layer.cornerRadius = 15
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
                
                appImage.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 100),
                appImage.widthAnchor.constraint(equalToConstant: 384),
                appImage.heightAnchor.constraint(equalToConstant: 202),
                
                createTodoLabel.topAnchor.constraint(equalTo: appImage.bottomAnchor, constant: 110),
                createTodoLabel.centerXAnchor.constraint(equalTo: appImage.centerXAnchor),
                
                newListButton.topAnchor.constraint(equalTo: createTodoLabel.bottomAnchor, constant: 25),
                newListButton.centerXAnchor.constraint(equalTo: appImage.centerXAnchor),
                newListButton.widthAnchor.constraint(equalToConstant: 124),
                newListButton.heightAnchor.constraint(equalToConstant: 44),
            ])
        }
        
        private func setupActions() {
            
            newListButton.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                presenter.goToNewListScreen()
            }), for: .touchUpInside)
        }
    }
}


// MARK: - Extension View -

extension Main.View: MainView {
    
}
