import UIKit

protocol HeaderFlightListDelegate: AnyObject {
    func changeDate()
}

final class HeaderFlightList: UIView {
        
    weak var delegate: HeaderFlightListDelegate?
    
    private var stack = UIStackView()
    private var titleLabel = UILabel()
    private var separator = Separator()
    private var buttonChangeDate = UIButton()
    
    var dateDeparture: Date! {
        didSet {
            setButtonChangeDate(dateDeparture)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setButtonChangeDate(_ date: Date) {
        let dateFormat = date.convertToString(format: .three)
        buttonChangeDate.setTitle(
            dateFormat,
            for: .normal
        )
    }
    
    @objc
    private func changeDate() {
        delegate?.changeDate()
    }
}


extension HeaderFlightList {

    private func createSubViews() {
        createStack()
        createTitleLabel()
        createSeparator()
        createButtonChangeDate()
    }
    
    private func createStack() {
        addSubview(stack)
        stack.spacing = 16
        stack.axis = .vertical
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
            
    private func createTitleLabel() {
        stack.addArrangedSubview(titleLabel)
        titleLabel.text = "Flight List"
        titleLabel.font = UIFont.systemFont(
            ofSize: 32,
            weight: .bold
        )
        titleLabel.textColor = .white
    }
    
    private func createSeparator() {
        stack.addArrangedSubview(separator)
    }
    
    private func createButtonChangeDate() {
        addSubview(buttonChangeDate)
        buttonChangeDate.backgroundColor = .darkGray.withAlphaComponent(0.5)
        buttonChangeDate.layer.cornerRadius = 16
        buttonChangeDate.clipsToBounds = true
        buttonChangeDate.setTitleColor(
            .gray,
            for: .normal
        )
        buttonChangeDate.titleLabel?.font = UIFont.systemFont(
            ofSize: 14,
            weight: .medium
        )
        buttonChangeDate.addTarget(
            self,
            action: #selector(changeDate),
            for: .touchUpInside
        )
        //
        buttonChangeDate.translatesAutoresizingMaskIntoConstraints = false
        buttonChangeDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        buttonChangeDate.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        buttonChangeDate.widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonChangeDate.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
}
