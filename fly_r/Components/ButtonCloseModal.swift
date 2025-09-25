import UIKit

final class ButtonCloseModal: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        setTitleColor(
            .systemPink,
            for: .normal
        )
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
}
