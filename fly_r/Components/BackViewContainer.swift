import UIKit

class BackViewContainer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setup() {
        backgroundColor = .darkGray.withAlphaComponent(0.25)
        layer.cornerRadius = 16
        clipsToBounds = true
    }
}


class BackControlContainer: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setup() {
        backgroundColor = .darkGray.withAlphaComponent(0.1)
        layer.cornerRadius = 16
        clipsToBounds = true
    }
}
