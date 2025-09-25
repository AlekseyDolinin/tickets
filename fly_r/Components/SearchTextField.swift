import UIKit

final class SearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        //
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .darkGray.withAlphaComponent(0.25)
        returnKeyType = .search
        layer.cornerRadius = 8
        clipsToBounds = true
        textColor = .white
        leftViewMode = .always
        autocorrectionType = .no
        spellCheckingType = .no
        tintColor = .gray
        clearButtonMode = .always
        setIcon()

        attributedPlaceholder = NSAttributedString(
            string: "поиск",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        // color clearButton
        if let clearButton = value(forKey: "_clearButton") as? UIButton {
            let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(
                templateImage,
                for: .normal
            )
            clearButton.tintColor = UIColor.white.withAlphaComponent(0.5)
        }
    }

    func setIcon() {
        let imageView = UIImageView(
            frame: CGRect(
                x: 6.0,
                y: 10.0,
                width: 20.0,
                height: 20.0
            )
        )
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let view = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 32,
                height: 40
            )
        )
        view.addSubview(imageView)
        leftViewMode = .always
        leftView = view
    }
}
