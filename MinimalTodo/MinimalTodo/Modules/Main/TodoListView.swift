import UIKit

class TodoListView: UIView {
    
    init(todoList: TodoList) {
        super.init(frame: .zero)
        
        let headerLabel = UILabel.createLabel(text: todoList.title, font: UIFont.boldSystemFont(ofSize: 18))
        
        let dateLabel = UILabel.createLabel(text: todoList.date, font: UIFont.systemFont(ofSize: 8), textColor: .gray)
        
        let calendarImageView = UIImageView.createImageView(systemName: "calendar")
        
        let blackView = BackgroundView(text: todoList.label)
        
        let dateStackView = UIStackView.createStackView(axis: .horizontal, spacing: 4, alignment: .center)
        dateStackView.addArrangedSubview(calendarImageView)
        dateStackView.addArrangedSubview(dateLabel)
        
        let labelsStackView = UIStackView(arrangedSubviews: [blackView, dateStackView])
        labelsStackView.axis = .horizontal
        labelsStackView.spacing = 10
        
        let mainStackView = UIStackView(arrangedSubviews: [headerLabel, labelsStackView])
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
        
        for field in todoList.additionalFields {
            let fieldLabel = UILabel.createLabel(text: field, font: UIFont.systemFont(ofSize: 14))
            mainStackView.addArrangedSubview(fieldLabel)
        }
        
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        // Don't forget to add this line
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
