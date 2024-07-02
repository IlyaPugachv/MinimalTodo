import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControlChanged(to index: Int)
}

final class CustomSegmentedControl: UIView {
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    private(set) var selectedSegmentIndex: Int = 0

    private let allListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(.Localization.allList, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.layer.zPosition = 1
        button.clipsToBounds = true
        return button
    }()
    
    private let pinnedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(.Localization.pinned, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addView(allListButton)
        addView(pinnedButton)
   
        NSLayoutConstraint.activate([
            allListButton.topAnchor.constraint(equalTo: topAnchor),
            allListButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            allListButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allListButton.trailingAnchor.constraint(equalTo: pinnedButton.leadingAnchor, constant: 10),
            allListButton.widthAnchor.constraint(equalTo: pinnedButton.widthAnchor),
            
            pinnedButton.topAnchor.constraint(equalTo: topAnchor),
            pinnedButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            pinnedButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupActions() {
        allListButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        pinnedButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        if sender == allListButton {
            selectSegment(at: 0)
        } else if sender == pinnedButton {
            selectSegment(at: 1)
        }
    }

    private func selectSegment(at index: Int) {
        guard index != selectedSegmentIndex else { return }

        selectedSegmentIndex = index
        delegate?.segmentedControlChanged(to: index)

        if index == 0 {
            allListButton.backgroundColor = .black
            allListButton.setTitleColor(.white, for: .normal)
            allListButton.layer.zPosition = 1
            
            pinnedButton.backgroundColor = .lightGray
            pinnedButton.setTitleColor(.black, for: .normal)
            pinnedButton.layer.zPosition = 0
        } else {
            pinnedButton.backgroundColor = .black
            pinnedButton.setTitleColor(.white, for: .normal)
            pinnedButton.layer.zPosition = 1
            
            allListButton.backgroundColor = .lightGray
            allListButton.setTitleColor(.black, for: .normal)
            allListButton.layer.zPosition = 0
        }
    }
}

//import UIKit
//
//final class CustomSegmentedControl: UIView {
//
//    private let allListButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle(.Localization.allList, for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .black
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        button.layer.cornerRadius = 10
//        button.layer.zPosition = 1
//        button.clipsToBounds = true
//        return button
//    }()
//    
//    private let pinnedButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle(.Localization.pinned, for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .lightGray
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = true
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//        setupActions()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupView() {
//        addView(allListButton)
//        addView(pinnedButton)
//   
//        NSLayoutConstraint.activate([
//            allListButton.topAnchor.constraint(equalTo: topAnchor),
//            allListButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            allListButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            allListButton.trailingAnchor.constraint(equalTo: pinnedButton.leadingAnchor, constant: 10),
//            allListButton.widthAnchor.constraint(equalTo: pinnedButton.widthAnchor),
//            
//            pinnedButton.topAnchor.constraint(equalTo: topAnchor),
//            pinnedButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            pinnedButton.trailingAnchor.constraint(equalTo: trailingAnchor),
//        ])
//    }
//    
//    private func setupActions() {
//        allListButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        pinnedButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//    }
//    
//    @objc
//    private func buttonTapped(_ sender: UIButton) {
//        if sender == allListButton {
//            allListButton.backgroundColor = .black
//            allListButton.setTitleColor(.white, for: .normal)
//            allListButton.layer.zPosition = 1
//            
//            pinnedButton.backgroundColor = .lightGray
//            pinnedButton.setTitleColor(.black, for: .normal)
//            pinnedButton.layer.zPosition = 0
//            
//        } else if sender == pinnedButton {
//            pinnedButton.backgroundColor = .black
//            pinnedButton.setTitleColor(.white, for: .normal)
//            pinnedButton.layer.zPosition = 1
//            
//            allListButton.backgroundColor = .lightGray
//            allListButton.setTitleColor(.black, for: .normal)
//            allListButton.layer.zPosition = 0
//        }
//    }
//}
