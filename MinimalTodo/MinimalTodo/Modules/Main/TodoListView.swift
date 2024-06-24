import UIKit

class TodoListView: UIView {
    
    init(todoList: TodoList) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = todoList.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        let dateLabel = UILabel()
        dateLabel.text = todoList.date
        dateLabel.font = UIFont.systemFont(ofSize: 8)
        dateLabel.textColor = .gray
        
        let calendarImageView = UIImageView(image: UIImage(systemName: "calendar"))
        calendarImageView.tintColor = .gray
        calendarImageView.contentMode = .scaleAspectFit
        
        let blackView = UIView()
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 5
        blackView.layer.masksToBounds = true
        blackView.layer.borderColor = UIColor.black.cgColor
        blackView.layer.borderWidth = 1
        
        let labelLabel = UILabel()
        labelLabel.text = todoList.label
        labelLabel.font = UIFont.systemFont(ofSize: 7)
        labelLabel.textColor = .white
        labelLabel.textAlignment = .center
        labelLabel.numberOfLines = 0
        
        // Add labelLabel inside blackView
        blackView.addSubview(labelLabel)
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelLabel.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 4),
            labelLabel.leadingAnchor.constraint(equalTo: blackView.leadingAnchor, constant: 4),
            labelLabel.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -4),
            labelLabel.bottomAnchor.constraint(equalTo: blackView.bottomAnchor, constant: -4)
        ])
        
        let dateStackView = UIStackView()
        dateStackView.axis = .horizontal
        dateStackView.spacing = 4
        dateStackView.alignment = .center
        
        dateStackView.addArrangedSubview(calendarImageView)
        dateStackView.addArrangedSubview(dateLabel)
        
        let labelsStackView = UIStackView(arrangedSubviews: [blackView, dateStackView])
        labelsStackView.axis = .horizontal
        labelsStackView.spacing = 10
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, labelsStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.spacing = 4
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
