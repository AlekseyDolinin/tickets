import UIKit

final class TopNavigatonView: UIView {
    
    var buttonClose = ButtonCloseModal()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        setButtonCloseModal()
    }
    
    func setButtonCloseModal() {
        addSubview(buttonClose)
        buttonClose.setTitle(
            "Закрыть",
            for: .normal
        )
        buttonClose.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonClose.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonClose.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
    }
}

