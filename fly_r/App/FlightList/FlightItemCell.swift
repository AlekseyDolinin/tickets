import UIKit

final class FlightItemCell: UITableViewCell {
    
    private let viewBack = BackViewContainer()
    private let pathLabel = UILabel()
    private let separator = Separator()
    private let departDate = UILabel()
    private let price = UILabel()
    
    var cityFrom: City!
    var cityTo: City!
    var flight: Flight! {
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
        setPathLabel()
        setDepartDate()
        setPrice()
    }
    
    private func setPathLabel() {
        pathLabel.text = "\(cityFrom.name) → \(cityTo.name)"
    }
    
    private func setDepartDate() {
        if let flight = flight {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: flight.departDate)
            departDate.text = date?.convertToString(format: .one)
        }
    }
    
    private func setPrice() {
        price.text = "\(flight.price) ₽"
    }
}


extension FlightItemCell {
    
    private func createSubviews() {
        createBackView()
        createPathLabel()
        createSeparator()
        createDepartDate()
        createPrice()
    }
    
    private func createBackView() {
        contentView.addSubview(viewBack)
        //
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        viewBack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        viewBack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        viewBack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func createPathLabel() {
        viewBack.addSubview(pathLabel)
        pathLabel.textColor = .white
        pathLabel.font = UIFont.systemFont(
            ofSize: 18,
            weight: .regular
        )
        //
        pathLabel.translatesAutoresizingMaskIntoConstraints = false
        pathLabel.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        pathLabel.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 16).isActive = true
    }
    
    private func createSeparator() {
        viewBack.addSubview(separator)
        //
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: pathLabel.bottomAnchor, constant: 16).isActive = true
        separator.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separator.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createDepartDate() {
        viewBack.addSubview(departDate)
        departDate.textColor = .gray
        departDate.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )
        //
        departDate.translatesAutoresizingMaskIntoConstraints = false
        departDate.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8).isActive = true
        departDate.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createPrice() {
        viewBack.addSubview(price)
        price.textColor = .white
        price.font = UIFont.systemFont(
            ofSize: 24,
            weight: .heavy
        )
        //
        price.translatesAutoresizingMaskIntoConstraints = false
        price.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor, constant: -16).isActive = true
        price.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
}
