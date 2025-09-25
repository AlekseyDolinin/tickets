import UIKit

final class CityItemCell: UITableViewCell {
    
    private let backView = BackViewContainer()
    private let nameLabel = UILabel()
    private let codeLabel = UILabel()
    
    var city: City! {
        didSet { setCell() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setCell() {
        setName()
        setCode()
    }
    
    private func setName() {
        nameLabel.text = city.name
    }
    
    private func setCode() {
        codeLabel.text = city.code
    }
}


extension CityItemCell {
    
    private func createSubviews() {
        createBackView()
        createNameLabel()
        createCodeLabel()
    }
    
    private func createBackView() {
        contentView.addSubview(backView)
        //
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func createNameLabel() {
        backView.addSubview(nameLabel)
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(
            ofSize: 26,
            weight: .light
        )
        //
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
    }
    
    private func createCodeLabel() {
        backView.addSubview(codeLabel)
        codeLabel.textColor = .lightGray
        codeLabel.font = UIFont.systemFont(
            ofSize: 14,
            weight: .regular
        )
        //
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        codeLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        codeLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
    }
}
