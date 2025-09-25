import UIKit

public class ButtonFirst: UIButton {

    init() {
        super.init(frame: .zero)
        setTitleColor(
            .systemPink,
            for: .normal
        )
        backgroundColor = .darkGray.withAlphaComponent(0.25)
        layer.cornerRadius = 16
        //
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
